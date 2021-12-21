<%@page import="DTO.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../header.jsp" %>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script> <!-- slim이 있으면 실행 안됨 -->
	<!-- 차트 표시 구역 -->
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h6> 주문 그래프 </h6>
				<canvas id="myChart"></canvas>
			</div>
			<div class="col-md-6">
				<h6> 제품별 판매량 </h6>
				<canvas id="productchart"></canvas>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<h6> 제품별 판매 추이</h6>
				<!-- 검색하기 --> <!-- 나는 input hidden으로 넘길려 그랬는데 onchange 멧소드로 아약스로 연결하셨음 -->
				제품명 : <select class="form-control" onchange="pchange()" id="pselect">
					<option>제품명 선택</option>
						<%ArrayList<Product> products = ProductDao.getproductDao().getproductlist(null, null); %>
						<%for(Product temp : products){ %>
							<option value="<%=temp.getP_num() %>"><%=temp.getP_name() %></option>
						<%} %>
					<option></option>
				</select>
				<canvas id="productdatechart"></canvas>
			</div>
			<div class="col-md-6">
				<h6> 제품별 판매량 </h6>
			</div>
		</div>
	</div>
</body>
</html>