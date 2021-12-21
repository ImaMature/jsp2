package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Map;

import org.json.simple.JSONObject;

import DTO.Cart;
import DTO.Porder;
import DTO.Porderdetail;

public class PorderDao extends DB{

	//Porder.java, Porderdetail.java 둘다 씀
	
	//1. DB클래스에서 연결하는 생성자 상속
		public PorderDao() {
		 
			super();
		}
		
		public static PorderDao porderDao = new PorderDao() ; 	// 2. Dao 객체 생성
		public static PorderDao getporderDao() { return porderDao; } // 3. Dao 객체 반환
		
		//1. 주문 등록 [1)주문등록 2)세부 주문등록 3)재고 업데이트]
		public boolean orderwrite( Porder porder , ArrayList<Cart> carts ) {
			String sql = "insert into porder( m_num , order_name , order_phone,"
					+ "order_address , order_pay , order_payment , delivery_pay,"
					+ "order_contents)values(?,?,?,?,?,?,?,?)";
			try {
				ps = con.prepareStatement(sql);
				ps.setInt(1, porder.getM_num() );	
				ps.setString(2, porder.getOrder_name() );
				ps.setString(3, porder.getOrder_phone() );
				ps.setString(4, porder.getOrder_address() );
				ps.setInt(5, porder.getOrder_pay() );
				ps.setString(6, porder.getOrder_payment() );
				ps.setInt(7, porder.getDelivery_pay() );
				ps.setString(8, porder.getOrder_contents() );
				ps.executeUpdate();
				// 방금 주문한 주문번호 검색
				sql ="select * from porder where m_num="+porder.getM_num()+
						" order by order_num desc";
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery(); if( rs.next() ) {
					int order_num = rs.getInt(1); // 주문번호
					for( Cart cart : carts ) { // 카트내 제품수만큼 DB에 저장
						//2. 주문 상세 등록 						//p_count : 구매수량
						sql ="insert into porderdetail( order_num, p_num , p_count , delivery_state)"
								+ "values(?,?,?,?)";
						ps=con.prepareStatement(sql);
						ps.setInt(1, order_num);	ps.setInt(2, cart.getP_num());
						ps.setInt(3, cart.getP_count() ); ps.setInt(4, 1 ); ps.executeUpdate();
						
						//3. 재고 업데이트 [ 주문시 주문 수량만큼 제품 재고 차감 ]
						//제품 번호가 같으면 카트에 구매 수량만큼 재고 깎기
						sql = "update product set p_stock = p_stock-? where p_num=?";
						ps=con.prepareStatement(sql);
						ps.setInt(1, cart.getP_count());	ps.setInt(2, cart.getP_num());
						ps.executeUpdate();
						
					}
					return true;
				} 
			}
			catch (Exception e) {System.out.println(e);}
			return false;
		}
		
		//2. 주문 목록(본인 거만 빼오기)
		public ArrayList<Porder> getporderlist(int m_num){
			
			ArrayList<Porder> porders = new ArrayList<Porder>();
						//m_num로 구분해서 porder에서 빼오기
			String sql = "select * from porder where m_num = "+m_num+" order by order_num";
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
					Porder porder = new Porder(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), 
												rs.getString(6), rs.getInt(7), rs.getString(8), rs.getInt(9), rs.getInt(10), rs.getString(11));
					
					porders.add(porder);
				}
				return porders;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//3. 주문 상세 목록
		public ArrayList<Porderdetail> getpPorderdetails (int order_num){
			
			ArrayList<Porderdetail> porderdetails = new ArrayList<Porderdetail>(); 
			
			String sql ="select * from porderdetail where order_num="+order_num+" order by order_num";
			
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
					Porderdetail porderdetail = new Porderdetail(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5));
					
					porderdetails.add(porderdetail);
				}
				return porderdetails;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}	
		
		//4. 날짜별 주문 수
		public JSONObject getOrderDateCount(){
			JSONObject jsonObject = new JSONObject();
			
			String sql = "select substring_index(order_date, ' ', 1), "
						+ "count(*) from jsp.porder group by substring_index(order_date, ' ', 1)";
			try {
				//인터페이스가 중복되면 안됨, 서로 다른 값을 넣어야하기 때문임. 그래서 ps와 rs를 새로운 인터페이스로 만듦
				//안 그러면 차트끼리 랜덤게임을 한다.
				PreparedStatement ps3 = con.prepareStatement(sql);
				ResultSet rs3 = ps3.executeQuery();
				while(rs3.next()) { //검색된 레코드 개수만큼 json에 추가
					jsonObject.put(rs3.getString(1), rs3.getString(2));
								//날짜 		,		//주문 수
				}
				return jsonObject;
			} catch (Exception e) {
				// TODO: handle exception
			}
			return null;
		}
		
		//5. 제품별 판매 량
		public JSONObject getPcount() {
			
			JSONObject jsonObject = new JSONObject();
			String sql = "select p_num, sum(p_count) from porderdetail group by p_num";
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
					// String sql2로 새로 선언해도 되지만, 사실 sql로 그냥 이어가도 됨 sql문을 새로 쓴거라 상관 없음 
					String sql2 = "select p_name from product where p_num = " + rs.getInt(1);
					//인터페이스가 중복되면 안됨, 서로 다른 값을 넣어야하기 때문임. 그래서 ps와 rs를 새로운 인터페이스로 만듦
					//안 그러면 차트끼리 랜덤게임을 한다.
					PreparedStatement ps2 = con.prepareStatement(sql2);
					ResultSet rs2 = ps2.executeQuery();
					if(rs2.next()) {
						rs2.getString(1);
					}
					jsonObject.put(rs2.getString(1), rs.getInt(2));
							//sql2 결과 [ 제품명 (1) ], sql결과 [제품번호, 제품 총 판매 수]
				}
				return jsonObject;
			} catch (Exception e) {
				System.out.print(e);
			}
			return null;
		}
		
		//6. 제품별 날짜 판매량
		public JSONObject getpdatecount(int p_num) {
			JSONObject jsonObject = new JSONObject();
			String sql = "select order_num, p_count from porderdetail where p_num = " + p_num;
			//having : (가장 먼저) where -> group by -> order by (가장 나중) 명령어 순서가 있음
			
			try {
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) { //sql문 값이 존재하면
					sql = "select substring_index(order_date, ' ', 1) from porder where order_num= "+rs.getInt(1);
												//해당값의 1번째 인덱스 (여기서는 order_num)을 order_num에 넣어서 검색하기
					PreparedStatement ps2 = con.prepareStatement(sql);
					ResultSet rs2 = ps2.executeQuery();
					if(rs2.next()) {
						jsonObject.put(rs2.getString(1), rs.getInt(2));
					}
				}
				return jsonObject;
			}catch (Exception e) {
				System.out.print(e);
			}
			return null;
		}
}
