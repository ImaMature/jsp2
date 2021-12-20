package DAO;


import java.util.ArrayList;
import DTO.Product;
import DTO.Reply;

public class ProductDao extends DB{
				//DB클래스 상속
	
	//super와 this의 막간의 정리
		//super : 부모 자체의 메모리에 접근
		//super.필드명 : 부모클래스 내 필드에 접근
		//super() : 부모클래스 내 생성자
		//super.메소드명 : 부모클래스 내 메소드에 접근
		
		//this : 현재 클래스 메모리에 접근
		//this.필드명 : 현재 클래스 필드에 접근 (외부 변수(인수)와 겹칠 경우)
		//this.메소드명() : 현재 클래스 내 메소드
		//ProductDao s = this; => 현재 객체는 클래스 객체
	
	//1. DB클래스에서 연결하는 생성자 상속
	public ProductDao() {
	 
		super();
	}
	
	public static ProductDao productDao = new ProductDao() ; 	// 2. Dao 객체 생성
	public static ProductDao getproductDao() { return productDao; } // 3. Dao 객체 반환
	
	//4. 메소드
	
	//1) 제품 등록 메소드
	public boolean productwrite(Product product) {
			String sql =  "insert into product(p_name, p_price, p_category, p_manufacturer, p_active, p_size, p_stock, p_img, p_contents) values(?,?,?,?,?,?,?,?,?)" ;
			try {
				ps = con.prepareStatement(sql);
				ps.setString(1, product.getP_name());
				ps.setInt(2, product.getP_price());
				ps.setString(3, product.getP_category());
				ps.setString(4, product.getP_manufacturer());
				ps.setInt(5, product.getP_active());
				ps.setString(6, product.getP_size());
				ps.setInt(7, product.getP_stock());
				ps.setString(8, product.getP_img());
				ps.setString(9, product.getP_contents());
				ps.executeUpdate();
				return true;
			}catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
	//2) 제품 모든 컬럼 출력 메소드
	public ArrayList<Product> getproductlist (String key, String keyword){
		
		String sql = null;
		
		ArrayList<Product> products = new ArrayList<>();
		
		if(key != null && keyword !=null) {
			sql = "select * from product where "+key+" = '"+keyword+"'";
										//keyword를 '로 구분해야됨
		}else {
			sql = "select * from product";

		}
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				Product product = new Product(
						rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getString(7),
						rs.getInt(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11)
						);
				products.add(product);
			}return products;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
		
	//3) 제품 조건 [ 검색 /카테고리 ] 중복 메소드
	//4) 제품 수정 메소드
	
	//5) 제품 삭제 메소드
	public boolean productDelete(int p_num) {
		String sql = "delete from product where p_num = "+p_num;
		try {
			ps=con.prepareStatement(sql);
			ps.executeUpdate();
			 return true;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}
	
	//6) 제품 상태변경 메소드
	public boolean p_ActivteUpdate(int p_num) {
		String sql = "select p_active from product where p_num= "+p_num; //1. 해당 제품 번호의 제품 상태 검색
		
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				if(rs.next()) {
					int p_active = rs.getInt(1)+1;			//	 2. 검색된 제품상태 + 1 [다음 상태]
					if( p_active == 4 )  { p_active = 1;}	//***3. 제품상태가 4면 1로 다시 변경해서 1로 초기화!!!!
					
					sql = "update product set p_active = "+p_active+" where p_num= "+p_num;
																		//!!!!!!문자일 경우 '넣고 아니면 안 넣어도 됨
					ps=con.prepareStatement(sql);
					ps.executeUpdate();
				}
				return true;
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
		return false;
	}
	
	

	//3. 제품 번호에 해당하는 제품  가져오기
	 public Product getproduct(int p_num) {
		 String sql = "select * from product where p_num=?";
		 try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, p_num);
			rs = ps.executeQuery();
			//한 개니까 while이 아니라 if
			while(rs.next()) {
				Product product = new Product(
						rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getString(7),
						rs.getInt(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11)
						);
				return product;	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	 } 
	 
	 //4. (내가만들어본) 제품 수정하기 메소드
	 public boolean p_Update(Product product , int p_num) {
			String sql = "update product set p_name=?, p_price=?, p_manufacturer=?, "+
						"p_category=?, p_size=?, p_stock=?, p_img=?, p_contents=? where p_num=?";
			try {
				ps = con.prepareStatement(sql);
				ps.setString(1, product.getP_name());
				ps.setInt(2, product.getP_price());
				ps.setString(3, product.getP_manufacturer());
				ps.setString(4, product.getP_category());
				ps.setString(5, product.getP_size());
				ps.setInt(6, product.getP_stock());
				ps.setString(7, product.getP_img());
				ps.setString(8, product.getP_contents());
				ps.setInt(9, p_num);
				ps.executeUpdate();
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return false;
		}
	 
	 //6. 제품 개별 출력(물음표 없는 버전)
	 public Product getproduct2(int p_num) {
		 String sql = "select * from product where p_num="+p_num;
		 try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				Product product = new Product(
						rs.getInt(1),
						rs.getString(2),
						rs.getInt(3),
						rs.getString(4),
						rs.getString(5),
						rs.getInt(6),
						rs.getString(7),
						rs.getInt(8),
						rs.getString(9),
						rs.getString(10),
						rs.getString(11)
						);
				return product;
			}
		} catch (Exception e) {}
		return null;
	 }
	 
	 
	 //7. 제품 찜하기 
	 public int plikeupdate(int p_num, int m_num) {
		 //1) 좋아요 버튼 -> 좋아요 [제품번호, 회원번호]
		 //2) 제품번호와 회원번호가 일치한 좋아요가 없으면 좋아요 생성 //3) 있으면 좋아요 삭제
		 String sql = null;
		 sql = "select * from plike where p_num="+p_num+" and m_num="+m_num;
		 try {
			 ps = con.prepareStatement(sql);
			 rs = ps.executeQuery();
			 if(rs.next()) { //좋아요 기존에 존재하면 (검색이 되었다면)
				 sql = "delete from plike where p_num="+p_num+" and m_num="+m_num;
				 ps = con.prepareStatement(sql);
				 ps.executeUpdate();
				 return 1; // 좋아요 제거
			 }else { //좋아요 기존에 존재하지 않으면 (검색이 안되면)
				 sql = "insert into plike(p_num, m_num) values("+p_num+","+m_num+")";
				 ps = con.prepareStatement(sql);
				 ps.executeUpdate();
				 return 2; // 좋아요 추가
			 }
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return 0; //DB오류
	 }
	 
	 //8. 제품 좋아요 확인 메소드
	 public boolean plikecheck(int p_num, int m_num) {
		 String sql = null;
		 sql = "select * from plike where p_num="+p_num+" and m_num="+m_num;
		 try {
			 ps = con.prepareStatement(sql);
			 rs = ps.executeQuery();
			 if(rs.next()) { //좋아요 기존에 존재하면(검색이 되었다면)
				 return true;
			 }
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false; //DB오류
	 }
	 
	//9. 실시간 재고가 0이면 제품 상태를 품절 업데이트 처리하기
		public void stockupdate() {
			//재고가 0인 제품 찾기
			String sql ="select * from product where p_stock = 0";
			try {
				ps =con.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
						//품절 처리하기			//p_active = 3 (품절로 하기로 함)		//재고 0인 제품의 제품번호를 갖다가 상태를 품절로 바꿈
					sql="update product set p_active = 3 where p_num=" + rs.getInt(1);
					ps=con.prepareStatement(sql);
					ps.executeUpdate();
					
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
}
