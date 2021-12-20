<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		//제품 상세페이지 == 게시물 보기
		int p_num = Integer.parseInt(request.getParameter("p_num"));
		//이미지 개별 출력
		Product product = ProductDao.getproductDao().getproduct2(p_num);
	%>

	<%@include file ="../header.jsp" %>
	 
	<!--  style="display: inline" : 한줄로 두기 -->
	
	 <div class="container"> <!-- 박스권 --> 
	 	<div class="row"> <!-- 가로배치 -->
	 		<div class="col-md-6" style="width:50%;">
	 			<img alt="" src="../../upload/<%=product.getP_img()%>" style="max-width:100%;">
	 		</div>
	 		
	 		<div class="col-md-6">
	 			<!-- 이게 있어야 p_num을 main.js의 cartadd()함수에 넘길 수 있음 아이디, 클래스, 네임의 밸류 정해서 그값 js로 넘기는 법 알아보기 위해서 이렇게 잔뜩 쓴거임 -->
	 			<input type="hidden" class="p_num" name="p_num" id="p_num" value="<%=p_num%>">
	 		
	 			<p><%=product.getP_manufacturer() %></p>
	 			<h4><%=product.getP_name() %></h4>
	 			<hr> <!-- 라인 긋는거 hr -->
	 				<div class="row">
	 					<div class="col-md-3"> 구매 혜택 </div>
	 					<div class="col-md-9"> 포인트 1% 제공 </div>
	 				</div>
	 				<div class="row">
	 					<div class="col-md-3"> 배송 정보 </div>
	 					<div class="col-md-9"> 영업일 기준 1~3일( 휴일 제외 ) </div>
	 				</div>
	 			<hr>
		 			<div class="row">
	 					<div class="col-md-3"> 가격 </div>
	 					<div class="col-md-9"> <%=product.getprice() %> </div>
	 												<!-- dto(product)에 천 단위 쉼표 만들어놓은거임 -->
		 			</div>
	 			<hr>
		 			<div class="row">
						<div class="col-md-3"> 제품 사이즈 </div>
		 				<div class="col-md-9">					
			 				<select id="p_size" name="p_size"class="form-control" style="cursor: pointer;">
			 					<!-- 옵션 선택에 value값을 0을 주거나 해당 id(p_size)를 불러오는 함수에 p_size =='옵션선택'일때 알림창 뜨게 하기 -->
			 					<!-- 이 작업은 아무것도 선택하지 않았을 경우를 막는 법 -->
			 					<option >옵션 선택</option>
			 					<option>S</option>
			 					<option>M</option>
			 					<option>L</option>
			 				</select>
		 				</div> 
		 			</div>
	 			<hr>
		 			<div class="row">
	 					<div class="col-md-3"> 수량 </div>
	 					<div class="col-md-9 row no-gutters"> <!-- row 한 행으로 / no-gutters : 기본 여백 없애기 -->
	 						<button class="btn btn-outline-secondary" onclick="pchange('p', <%=product.getP_stock()%>, <%=product.getP_price()%>)"> + </button>
	 						
	 						<div class="col-md-2">
	 							<input class="form-control" name="p_count" type="text" id="pcount" onchange="pchange('s', <%=product.getP_stock()%>, <%=product.getP_price()%>)" value="1">
	 						</div>
	 						
	 						<button class="btn btn-outline-secondary" onclick="pchange('m', <%=product.getP_stock()%>, <%=product.getP_price()%>)"> - </button>
	 					</div>
		 			</div>
	 			<hr>
	 				<div class="row">
	 					<div class="col-md-3"> 총 상품 금액 </div>
	 					<div class="col-md-9 text-right">
	 						<div id="total"><%=product.getprice() +"원" %> </div>
	 					</div>
		 			</div>
	 			<hr>
		 			<div>
		 				<button class="form-control bg-success text-white" style="font-size: 1.5rem; cursor: pointer;" >구매하기</button>
		 			</div>
		 			<div class="row my-3">
		 				<div class="col-md-6">
		 					<button class="form-control" onclick="cartadd();">장바구니</button>
		 				</div>
		 				<div class="col-md-6">
			 				<%
			 					int m_num = 0;
			 					//로그인 아이디가 존재하는 경우(회원이 찜하기 하는 경우)
			 					if(login != null){
			 					//m_num에 로그인한 아이디의 번호 저장	
			 					m_num = login.getM_num(); 
			 					}
			 					//만약 좋아요가 존재하면
			 					if(ProductDao.getproductDao().plikecheck(p_num, m_num)) {
			 				%>
			 						<button class="form-control" id="btnPlike" onclick="plike(<%=p_num %>,<%=m_num %>)" style="cursor: pointer;">찜하기♥</button>
			 				<%
			 					}else{ //좋아요가 존재하지 않으면
			 				%>
			 						<button class="form-control" id="btnPlike" onclick="plike(<%=p_num %>,<%=m_num %>)" style="cursor: pointer;">찜하기♡</button>
			 					
			 				<%	} %>
		 				
		 				</div>
		 			</div>	
	 		</div>
	 	</div>
	 	<br><br>
	 	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	 		<ul class="navbar-nav col-md-12 text-center">
	 			<li class="nav-item col-md-3"><a href="#detail" class="nav-link pview">상품상세</a></li>
	 			<li class="nav-item col-md-3"><a href="#guide" class="nav-link pview">상품가이드</a></li>
	 			<li class="nav-item col-md-3"><a href="#review" class="nav-link pview">상품리뷰</a></li>
	 			<li class="nav-item col-md-3"><a href="#qna" class="nav-link pview">상품문의</a></li>
	 		</ul>
	 	</nav>
	 	
	 	<div id="detail">
	 		상품상세 위치 <br><br><br><br><br><br><br><br><br><br><br><br>
	 	</div>
	 	<div id="guide">
	 		상품가이드 위치 <br><br><br><br><br><br><br><br><br><br><br><br>
	 	</div>
	 	<div id="review">
	 		상품리뷰 위치 <br><br><br><br><br><br><br><br><br><br><br><br>
	 	</div>
	 	<div id="qna">
	 		상품문의 위치 <br><br><br><br><br><br><br><br><br><br><br><br>
	 	</div>
	 	
	 </div>	<!-- container end -->
	 
	 <%@include file ="../footer.jsp" %>
</body>
</html>