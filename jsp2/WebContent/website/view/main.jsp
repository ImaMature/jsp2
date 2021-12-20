<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사이트</title>
</head>
<body>
	<%@include file="header.jsp" %>
	
	<!-- 캐러셀 start -->
	
		<div id="carouselcontent" class="carousel slide" data-ride="carousel" data-interval="2000">
			<ol class="carousel-indicators">
				<li data-target="#carouselcontent" data-slide-to="0" class="active"></li>
				<li data-target="#carouselcontent" data-slide-to="1"></li>
				<li data-target="#carouselcontent" data-slide-to="2"></li>
				<li data-target="#carouselcontent" data-slide-to="3"></li>
				<li data-target="#carouselcontent" data-slide-to="4"></li>
			</ol>
			<div>
				<div class="carousel-inner">
					<div class="carousel-item active"><img src="../img/car1.jpg"></div>
					<div class="carousel-item"><img src="../img/car2.jpg"></div>
					<div class="carousel-item"><img src="../img/car3.jpg"></div>
					<div class="carousel-item"><img src="../img/car4.jpg"></div>
					<div class="carousel-item"><img src="../img/car5.jpg"></div>
				</div>
			</div>		
					<a class="carousel-control-prev" href="#carouselcontent" data-slide="prev" >
						<span class="carousel-control-prev-icon"></span>
					</a>
					<a class="carousel-control-next" href="#carouselcontent" data-slide="next" >
						<span class="carousel-control-next-icon"></span>
					</a>
		</div>
	
	
	<!-- 캐러셀 end -->
	
	<!-- 구분선 -->
	<hr>
	<div class="container text-center">
		<h3>신제품</h3>
		<p> NEW ARRAIVAL </p>
	</div>
	
	
	
	<!-- 제품목록 -->
	<div class="container">
		<div class="row">
			<%	
				ArrayList<Product> products = ProductDao.getproductDao().getproductlist(null, null);
				
				for( Product product : products) {
			%>
			<div class="col-md-4">
				<div class="card">
					<a href="product/productview.jsp?p_num=<%=product.getP_num()%>">
						<img class="card-img-top pimg" src="../upload/<%=product.getP_img()%>">
					</a>
					<div class="card-body">
						<p class="card-text"> <%=product.getP_name()%></p>
						<hr>
						<p class="item"> 
							<%=product.getP_contents()%><br><br>
							<span class="price"><%=product.getprice( )%> 원 </span> <!-- 한칸 띄워줘야함 --><br>
							<span class="badge badge-pill badge-danger"><%=product.getactive()%></span>
						</p>	
					</div>
				</div>
			</div>
			<% } %>
		</div>
	</div>
	
	
	<!-- 제품목록 end -->
	
	
	<%@include file="footer.jsp" %>
</body>
</html>