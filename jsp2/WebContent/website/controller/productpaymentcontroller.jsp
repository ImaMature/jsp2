<%@page import="DTO.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.PorderDao"%>
<%@page import="DTO.Login"%>
<%@page import="DTO.Porder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//순서 [ 1. 주문 db등록하고 -> 2. 주문 상품 수만큼 주문 상세 등록]

	//1. 주문 등록
		//1) 회원 번호 : m_num : 세션
		//2) 수령자 : order_name
		//3) 수령자연락처 : order_phone
		//4) 수령자주소 : order_address
		//5) 주문총금액 : order_pay
		//6) 결제수단 : order_payment
		//7) 배송비 : delivery_pay
		//8) 배송요청사항 : order_contents
	
	//2. 주문 상세 [먼저 주문 등록이 된다는 가정하] : 반복문
		//주문번호 : order_num : db
		//상품번호 : p_num : 카트 세션
		//구매수량 : p_count : 카트 세션
		//배송상태 : delivery_state : 임의값 [1]
				
	//3. 재고 감소 [ 제품 업데이트 ]
			
	//4. 카트세션 초기화
	
//ajax를 이용한 매개변수 요청
String order_name = request.getParameter("order_name");
String order_phone = request.getParameter("order_phone");
String order_address = request.getParameter("order_address");
int order_pay = Integer.parseInt(request.getParameter("order_pay"));
String order_payment = request.getParameter("order_payment");
int delivery_pay = Integer.parseInt(request.getParameter("delivery_pay"));
String order_contents = request.getParameter("order_contents");
//System.out.print(order_contents);

//productpayment
Login login = (Login)session.getAttribute("login"); //로그인 세션 요청
//System.out.print("login : "+  login.toString());

//DB에 저장하기 위해 객체화
Porder porder = new Porder(login.getM_num(), order_name, order_phone, order_address, 
				order_pay, order_payment, delivery_pay, order_contents);

//카트 세션 호출 (카트를 DB에 저장하기 위해)
//장바구니 세션 이름 [ 이름 : cart + 아이디 / 값 : cart리스트 ]
String sname = "cart"+login.getM_id();
ArrayList<Cart> carts = (ArrayList<Cart>)session.getAttribute(sname);

//DB저장하기
boolean rs = PorderDao.getporderDao().orderwrite(porder, carts);

System.out.println("rs : " + rs);
if(rs){
	out.print("1"); session.setAttribute(sname, null); //장바구니 초기화
}else{
	out.print("0");
}
//결제하기 눌렀을 때
//out.print(order_name + order_phone + order_address + order_pay + order_payment + delivery_pay + order_contents);	
%>