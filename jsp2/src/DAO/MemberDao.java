package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DTO.Member;

public class MemberDao {
	// 1. 빌드 -> 라이브러리 추가
	// 2. 프로젝트내 WEB-INF -> lib -> 라이브러리 추가
	
		//1. 자주 사용하는 인터페이스 
		private Connection con;
		private ResultSet rs;
		private PreparedStatement ps;
		
		// 2. 생성자 
		public MemberDao() {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3307/jsp?serverTimezone=UTC" , "root","1234");
				//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp?serverTimezone=UTC" , "root","dhkfeh!!12");
			}
			catch (Exception e) {System.out.println("[연동 실패]");}
		}
		public static MemberDao memberDao = new MemberDao() ; 	// 3. Dao 객체 생성
		public static MemberDao getmemberDao() { return memberDao; } // 4. Dao 객체 반환
		
	//1. 회원가입 메소드 
	public boolean membersignup( Member member) {
		
		String sql = "insert into member(m_id,m_password,m_name,m_birth,m_sex,m_phone,m_address) values(?,?,?,?,?,?,?)";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, member.getM_id() );	ps.setString(2, member.getM_password() );
			ps.setString(3, member.getM_name() );	ps.setString(4, member.getM_birth() );
			ps.setString(5, member.getM_sex() );	ps.setString(6, member.getM_phone() );
			ps.setString(7, member.getM_address() );	ps.executeUpdate();
			return true;
		}
		catch (Exception e) {System.out.println(e);}
		return false;
	}
	
	//2. 로그인 메소드
	public boolean memberlogin(Member member) {
		String sql = "select * from member where m_id=? and m_password=?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, member.getM_id());
			ps.setString(2, member.getM_password());
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//3. 아이디 체크 메소드
	public boolean idcheck(String userid) {
		
		String sql = "select m_id from member where m_id=?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
				//아이디가 존재함
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false; //아이디 존재X
	}
	
	//4. 로그인 체크 메소드
	public boolean longin(String id, String password) {
		
		String sql = "select * from member where m_id=? and m_password=?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()) {
				return true;
			}
			return false;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	//5.회원 정보 메소드 
	//회원 넘버 일부러 뺀거임
//	public Member memberinfo(String loginid) {
//		
//		String sql = "select m_id, m_name, m_birth, m_sex, m_phone, m_address, m_point from member where m_id=?";
//		
//		try {
//			ps = con.prepareStatement(sql);
//			ps.setString(1, loginid);
//			rs = ps.executeQuery();
//			if(rs.next()) {
//				Member member = new Member(	
//						rs.getString(1),rs.getString(2),rs.getString(3),
//						rs.getString(4),rs.getString(5),rs.getString(6),rs.getInt(7)
//						);
//				return member;
//			}
//		}catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return null;
//		
//	}
	
	
	
	//6.회원 탈퇴 메소드 

	//DB에서 아무거나 넣어도 true값이 뜬다 //그래서 새로운 sql문을 만들어야 한다.
	//검색하고 해당회원 삭제하기
	
	public boolean delete(String id, String password) {
		
		String sql1 = "select * from member where m_id=? and m_password=?"; //회원 검사
		String sql2 = "delete from member where m_id=? and m_password=?";	//회원 삭제
		
		try {
			ps = con.prepareStatement(sql1);
			ps.setString(1, id);
			ps.setString(2, password);
			rs= ps.executeQuery();
			
			if(rs.next()) { // 아이디와 비밀번호가 동일한 경우의 결과가 있는 경우에만 회원 삭제
				PreparedStatement ps2 = con.prepareStatement(sql2); 
				//db연동이 한 메소드에서 두번 이상일 때, PreparedStatement 변수를 그만큼 더 새로 추가해야 연결이 끊기지 않는다.
				ps2.setString(1, id);
				ps2.setString(2, password);
				ps2.executeUpdate();
				return true;
			}
		} catch (Exception e) {
			System.out.println("delete method(): " + e.getMessage());
		}
		return false;
	}

	// 회원정보 메소드 (다가져오는 버전)
	public Member memberinfo(String loginid) {
		
		String sql = "select * from member where m_id=?";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, loginid);
			rs = ps.executeQuery();
			if(rs.next()) {
				Member member = new Member(	
						rs.getInt(1),rs.getString(2),null,
						rs.getString(4),rs.getString(5),rs.getString(6),
						rs.getString(7), rs.getString(8), rs.getInt(9),
						rs.getString(10)
						);
				return member;
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return null;
		
	}
	
	//8. 회원 정보 수정 메소드
	//패스워드, 회원명, 성별, 생년월일, 연락처, 주소
	//type을 인수로 받는다
	public boolean update (String type, String newdata, String loginid) {
		String sql = "update member set "+type+" =? where m_id=?";
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, newdata);
			ps.setString(2, loginid);
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return false;
	}
	
	//회원번호 검색하는 메소드
	public int getmembernum(String id) {
		String sql = "select m_num from member where m_id = ?";
		try {
			ps= con.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;		
	}
	
	//회원아이디 검색하는 메소드
		public String getmemberid(int m_num) {
			String sql = "select m_id from member where m_num = ?";
			try {
				ps= con.prepareStatement(sql);
				ps.setInt(1, m_num);
				rs=ps.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
			
		}
}
