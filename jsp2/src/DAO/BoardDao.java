package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DTO.Board;
import DTO.Reply;

public class BoardDao {

	//인터페이스
	private Connection con;
	private ResultSet rs;
	private PreparedStatement ps;
	
	//생성자
	public BoardDao() {
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3307/jsp?serverTimezone=UTC" , "root","1234");
		
			//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp?serverTimezone=UTC" , "root","dhkfeh!!12");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("db연동 실패");
		}
	}
	
	//Dao 객체 생성
	public static BoardDao boardDao = new BoardDao();
	
	//Dao 객체 반환
	public static BoardDao getBoardDao () {
		return boardDao;
	}
	
	//Reply 객체 생성
	
	
	//1. 게시판 글 등록(글쓰기) 메소드
	public boolean boardwrite(Board board) {
		String sql = "insert into board(b_title, b_contents, m_num, b_file, b_file2) values(?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, board.getB_title());
			ps.setString(2, board.getB_contents());
			ps.setInt(3, board.getM_num());
			ps.setString(4, board.getB_file());
			ps.setString(5, board.getB_file2());
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;	
	}
	
	//2. 모든 게시물 출력( 첫페이지 번호 부터 마지막 페이지 번호 까지 이는 boardlist.jsp에 있음 )			
	
	//2-1. 게시판 검색한거 출력
	public ArrayList<Board> boardList (int startrow, int listsize, String key, String keyword){
		
		String sql = null;
		//먼저 sql 문 초기화 해야 조건 추가 가능
		
		ArrayList<Board> boards = new ArrayList<Board>();
		if(key == null && keyword == null) { //검색이 없을경우
			sql = "select * from board order by b_num desc limit ?, ?";
													//limit ? (시작기준) ? (몇개로 자를건지)
		}else { //검색이 있을 때 키워드 있을때
			
			if(key.equals("b_writer"))	{		//작성자 검색 : 작성자 -> 회원번호
				int m_num = MemberDao.getmemberDao().getmembernum(keyword);
				sql = "select * from board where m_num=" + m_num +" order by b_num desc limit ?, ?";
	
			}else if (key.equals("b_num")){		//번호 검색 : 일치한 값 검색
				sql = "select * from board where b_num=" + keyword+ " order by b_num desc limit ?, ?";
					
			}
			else {							 	//제목, 내용 검색 : 포함된 값 검색			
				sql = "select * from board where "+key+" like '%"+keyword+"%' order by b_num desc limit ?, ?";
			}
		}
		try {
			ps=con.prepareStatement(sql);
			// ??가 없기 때문에 set~~안함
			ps.setInt(1,startrow);
			ps.setInt(2,listsize);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Board board = new Board(
						rs.getInt(1), 
						rs.getString(2), 
						rs.getString(3), 
						rs.getInt(4), 
						rs.getString(5), 
						rs.getString(6), 
						rs.getInt(7), 
						rs.getInt(8),
						rs.getString(9));
				
				boards.add(board);
				
			}
			return boards;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	
	//3. 게시물 번호에 해당하는 게시물 가져오기
	 public Board getBoard(int b_num) {
		 String sql = "select * from board where b_num=?";
		 try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, b_num);
			rs = ps.executeQuery();
			//한 개니까 while이 아니라 if
			if(rs.next()) {
				Board board = new Board(
						rs.getInt(1), 
						rs.getString(2), 
						rs.getString(3), 
						rs.getInt(4), 
						rs.getString(5), 
						rs.getString(6), 
						rs.getInt(7), 
						rs.getInt(8),
						rs.getString(9));
				return board;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	 }
	 
	//4. 조회수 증가
	// 게시물번호의 해당 게시물 가져오기 
		public boolean boardView( int b_num) {
			String sql = "update board set b_view = b_view+1 where b_num = ?";
			try {
				ps = con.prepareStatement(sql);
				ps.setInt(1, b_num); 	ps.executeUpdate();
				return true;
			}catch (Exception e) {} return false;
		}	 
			 
	 
	 //5. 게시물 삭제하기
		 public boolean boardDelete(int b_num) {
			 String sql ="delete from board where b_num = ?";
			 try {
				 ps = con.prepareStatement(sql);
				 ps.setInt(1, b_num);
				 ps.executeUpdate();
				 return true;
			 }catch (Exception e) {
				 e.printStackTrace();
			}
			return false;
		 }
		 
	 //5. 게시물 총 개수 반환 메소드
	 public int boardcount( String key , String keyword) {
		 String sql = null;
		 //null로 초기화
		 
		 if( key != null && keyword != null ) { // 검색이 있을때 [ 조건이 있는 레코드 개수 세기 ]
			 
			 if( key.equals("b_writer")  ) {		 //작성자 검색 : 작성자 -> 회원번호
				 int m_num = MemberDao.getmemberDao().getmembernum(keyword);
				 sql ="select count(*) from board where m_num = "+ m_num ;
				 
			 }else if( key.equals("b_num") ) {	//번호 검색 : 일치한 값만 검색
				 sql ="select count(*) from board where b_num = "+ keyword;
				 
			 }else {							// 제목 혹은 내용 검색 : 포함된 값 검색 
				 sql ="select count(*) from board where "+key+" like '%"+keyword+"%'";
				 //sql문은 띄어쓰기 해줘야됨	where "+key+" like "+ +" 사이는 매개값 따옴표 바깥을 띄워줘야됨 
			 }
		 }else { // 검색이 없을때				
			 sql="select count(*) from board"; //[ 조건 없는 모든 레코드 개수 세기 ]
		 }
		 try {
			 ps = con.prepareStatement(sql);
			 rs = ps.executeQuery();	
			 if( rs.next() ) { return rs.getInt(1); }
		 }catch (Exception e) {} return 0;
	 }
		 
	//6. 게시물 수정 메소드
		 public boolean boardupdate(Board board) {
			 String sql ="update board set b_title=?, b_contents=?, b_file=?, b_file2=? where b_num=?";
			 try {
				 ps = con.prepareStatement(sql);
				 ps.setString(1, board.getB_title());
				 ps.setString(2, board.getB_contents());
				 ps.setString(3, board.getB_file());
				 ps.setString(4, board.getB_file2());
				 ps.setInt(5,  board.getB_num());
				 ps.executeUpdate();
				 return true;
			 }catch (Exception e) {
				 System.out.println("boardDelete method(): " + e.getMessage());
			}
			return false;
		 }
		 
		
//----------------------------- 여기부터 리플 ----------------------------------------------------		 
	//1. 리플 등록 메소드
		 public boolean replywrite(Reply reply) {
			 String sql = "insert into reply (r_contents, m_num, b_num) values(?,?,?)";
			 try {
					ps=con.prepareStatement(sql);
					ps.setString(1, reply.getR_contents());
					ps.setInt(2, reply.getM_num());
					ps.setInt(3, reply.getB_num());
					ps.executeUpdate();
					return true;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				return false;	
			}
		 
	//2.리플 출력
		 public ArrayList<Reply> replyList (int b_num, int startreply, int replysize){
			ArrayList<Reply> replies = new ArrayList<Reply>();
			String sql = "select * from reply where b_num=? order by r_num desc limit ?, ?";	
											//limit ? (시작기준) ? (몇개로 자를건지)
			
			try {
				ps=con.prepareStatement(sql);
				ps.setInt(1, b_num);
				ps.setInt(2, startreply);
				ps.setInt(3, replysize);
				rs = ps.executeQuery();
				while(rs.next()) {
					Reply reply = new Reply(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getInt(4),
							rs.getInt(5));
					replies.add(reply);
				}
				return replies;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		}	 
		 
		//3. 게시물 번호에 해당하는 리플 가져오기
		 public Reply getreply(int b_num) {
			 String sql = "select * from reply where b_num=?";
			 try {
				ps = con.prepareStatement(sql);
				ps.setInt(1, b_num);
				rs = ps.executeQuery();
				//한 개니까 while이 아니라 if
				while(rs.next()) {
					Reply reply = new Reply(
							rs.getInt(1),
							rs.getString(2),
							rs.getString(3),
							rs.getInt(4),
							rs.getInt(5)
							);
					return reply;	
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		 } 
		
		//4. 리플 삭제하기
		 public boolean replyDelete(int r_num) {
			 String sql ="delete from reply where r_num = ?";
			 try {
				 ps = con.prepareStatement(sql);
				 ps.setInt(1, r_num);
				 ps.executeUpdate();
				 return true;
			 }catch (Exception e) {
				 System.out.println("replyDelete method(): " + e.getMessage());
			}
			return false;
		 }
		 
		
		//5. 리플 페이징 처리하기 (리플 총 개수 찾아서 넘기기 단, b_num로 구분해야함 안그러면 다 나옴)	
		public int replyCount(int b_num) {
			String sql = "select count(*) from reply where b_num=?";
			try {
				ps=con.prepareStatement(sql);
				ps.setInt(1, b_num);
			
				rs=ps.executeQuery();
				if(rs.next()) {
					rs.getInt(1);
				}
				return rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return 0;
		}
}
