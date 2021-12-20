<%@page import="java.text.DecimalFormat"%>
<%@page import="DTO.Product"%>
<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%@include file ="../header.jsp" %>
	
	<%
	//Login login =  (Login)session.getAttribute("login"); // 헤더에 로그인 있어서 빼기
	String sname = "cart"+ login.getM_id();
	ArrayList<Cart> carts = (ArrayList<Cart>)session.getAttribute(sname);
	int totalprice = 0; //총금액
	DecimalFormat decimalFormat = new DecimalFormat("###,###"); //java에서 사용하는 천단위 쉼표 클래스
	
	%>
	<h3 style="border:solid 1px #eeeee;">장바구니</h3>
	
	<div class="container">
		<table class="table">
		<tr>
			<th>이미지</th><th>상품정보</th><th>수량</th><th>가격</th><th>비고</th>
		</tr>
		<%
			if(carts==null){%>
			<tr>
			<td colspan="5" class="text-center"> 장바구니에 상품이 없습니다. </td>
			</tr>
				
		<%	}else{
			int i = 0; //식별용 반복 인덱스 변수
			for(Cart cart : carts){ 
			Product product = ProductDao.getproductDao().getproduct(cart.getP_num()); //제품 번호에 해당하는 제품 정보
			totalprice += cart.getP_count() * product.getP_price(); //카트 내 제품 누적합계
		%>
		<tr>
				<!-- div는 align-middle 안됨 -->
			<td width="12%"><img class="align-middle" src="../../upload/<%=product.getP_img()%>" style="max-width: 100%;"></td>
			<td width="40%">
				<div class="p-1">
					제품명 : (<%=product.getP_manufacturer()%>) <%=product.getP_name() %>
				</div>
				<hr>
				<div class="p-1" style="font-size: 12px;">
					옵션 : <%=cart.getP_size() %>
				</div>
			</td>
			<td class="row no-gutters">
				<!-- 장바구니 식별을 위해서 i를 넣어서 이름을 각각 다르게 만들기 -->
				<button class="btn btn-outline-secondary" 
					onclick="pchange2(<%=i %>, 'p', <%=product.getP_stock()%>, <%=product.getP_price()%>)"> + </button>
				
				<div class="col-md-2">
					<input class="form-control" name="p_count" type="text" id="pcount<%=i %>" 
					onchange="pchange2(<%=i %>, 's', <%=product.getP_stock()%>, <%=product.getP_price()%>)" value="<%=cart.getP_count()%>">
				</div>
				
				<button class="btn btn-outline-secondary" 
					onclick="pchange2(<%=i %>, 'm', <%=product.getP_stock()%>, <%=product.getP_price()%>)"> - </button>
			</td>
											<!-- i를 추가해서 서로 다른 total값도 만들기 -->
			<td width="15%" class="align-middle" id="total<%=i %>"><%=decimalFormat.format(product.getP_price()*cart.getP_count()) %> 원</td>
			<td width="5%"><button class="form-control" 
					onclick="cartdelete('in', '<%=cart.getP_num()%>', '<%=cart.getP_size()%>')">X</button></td>
		</tr>
		<%
			i++;}
		}
		%>
		</table>
		<div>
			<button onclick="cartdelete('all','0','0')" class="btn btn-danger">모두삭제</button> <!-- 모두 삭제는 0집어넣기 왜냐면 오토키라 0이 들어갈수 없음 -->
		</div>
		
		<div class = "text-center totalbox">
			<p>총 상품 가격 <span class="carttotal"><%=decimalFormat.format(totalprice) %></span>
			+ 총배송비 <span class="carttotal">3000</span> 총 주문금액 : 
			<span class="carttotal"><%=decimalFormat.format(totalprice+3000)  %></span> </p>
		</div>
		<div class="row">
			<div class="col-md-3 offset-3">
				<a href="productpayment.jsp">
					<button class="form-control bg-success text-white p-3">주문하기</button>
				</a>
			</div>
			<div class="col-md-3">
				<button class="form-control p-3">쇼핑하기</button>
			</div>
		</div>
	</div>
	<br><br><br><br><br><br>	
	

</body>
</html>