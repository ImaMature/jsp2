<%@page import="DTO.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//장바구니 세션 이름 [이름 : cart+아이디 값 : cart리스트]
	Login login = (Login)session.getAttribute("login"); 
	String sname = "cart" + login.getM_id();
	
	ArrayList<Cart> carts = (ArrayList<Cart>)session.getAttribute(sname);
	
	String type = request.getParameter("type");
	int p_num = Integer.parseInt(request.getParameter("p_num"));
	String p_size = request.getParameter("p_size");
	//i번째 인수 받기
	//임시로 p_cartdeletecontroller에 쓰는 거임 나중에 다른데로 옮기기
	int i = Integer.parseInt(request.getParameter("i"));
	int p_count = Integer.parseInt(request.getParameter("p_count"));
	//System.out.print("i값 : "+i);
	
	//카트 호출

	if(type.equals("all")){//모두 삭제버튼 눌렀을때
		session.setAttribute(sname, null); //장바구니 세션 초기화
	}
	else if(type.equals("in")){	//개별 삭제 버튼 눌렀을때
		for( Cart cart : carts){ //반복문 돌려서 동일한 제품번호와 사이즈 찾기
			if(cart.getP_num() == p_num && cart.getP_size().equals(p_size)){
				carts.remove(cart); //장바구니에서 해당 제품 삭제
				session.setAttribute(sname, carts); //다시 세션 줘서 업데이트하기
				break; //반복문 종료
			}
		}
	//장바구니 개별 수량 변경하기
	//수량 타입이 p	
	}else if(type.equals("p")){
		carts.get(i).setP_count(p_count); //p_count세팅
		session.setAttribute(sname, carts); //다시 세션값 줘서 업데이트하기
	//수량 타입이 m	
	}else if(type.equals("m")){
		carts.get(i).setP_count(p_count); //p_count세팅
		session.setAttribute(sname, carts); //다시 세션값 줘서 업데이트하기
	}	
	
%>