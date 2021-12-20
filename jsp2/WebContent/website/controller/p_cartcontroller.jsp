<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Cart"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
 	//선택한 제품의 제품번호, 옵션, 수량
 	//main.js cartadd()함수에서 넘어온 인수들
 	int p_num = Integer.parseInt(request.getParameter("p_num"));
	String p_size = request.getParameter("p_size");
	int p_count = Integer.parseInt(request.getParameter("p_count"));
	//System.out.println("p_num : " + p_num);
	//System.out.println("p_size : " + p_size);
	//System.out.println("p_count : " + p_count);
	
	//객체화
	Cart cart = new Cart(p_num, p_size, p_count);
		
		Login login = (Login)session.getAttribute("login"); //세션 자료형/클래스 => object
		//System.out.println("login : " + login);

		//아이디 앞에 cart를 붙여줘서 고유 이름 만든 거임 회원의 장바구니를 서로 구분하려고
		String sname = "cart" + login.getM_id();

		//리스트 선언과 장바구니 세션 이름화	
		//0. 카트에 세션 할당
		ArrayList<Cart> carts = (ArrayList<Cart>)session.getAttribute(sname);
		
		//기존 카트가 있을 경우 없을 경우
		//1. 기존 카트 세션이 없을 경우
		if(carts == null){	
			
			//2. 카트리스트에 메모리 할당
			carts = new ArrayList<>(); 
			//3. 카트리스트에 추가
			carts.add(cart);
			//4. 카트 세션 생성
			//세션에 장바구니 이름 저장 [이름 : cart+아이디 값 : cart리스트]
			//회원의 그 고유 장바구니 이름과 (제품의 제품번호, 옵션, 수량)이 담긴 리스트 객체 carts를 세션화 한거임
			session.setAttribute(sname, carts);
			
		//5. 카트 세션이 있을 경우	
		}else{			
			//만약에 기존 카트에 동일한 제품이 있을 경우
			boolean pcheck = true;
			for(Cart temp : carts){
				//카트에 제품번호와 제품 사이즈가 동일하면
				if(temp.getP_num() == p_num && temp.getP_size().equals(p_size)){
					//기존 제품에 수량을 추가
					temp.setP_count(temp.getP_count()+p_count);
					pcheck = false;
				}
			}
			//6.카트 리스트에 제품 추가 (동일한 제품이 없을 경우에 카트리스트에 제품 추가)
			if(pcheck) carts.add(cart); 
			//7. 세션 다시 할당(업데이트 느낌)
			session.setAttribute(sname, carts);
		}

		//비동기식 방식 사용시 페이지 전환 X
	//response.sendRedirect("../view/product/productcart.jsp");
	
%>
