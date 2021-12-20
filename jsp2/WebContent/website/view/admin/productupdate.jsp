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
	<%@include file="../header.jsp" %>

<%
	int p_num = Integer.parseInt(request.getParameter("p_num"));
	Product product = ProductDao.getproductDao().getproduct(p_num); //수정할 게시물 가져오기
	product.setP_contents(product.getP_contents().replaceAll("<br>", "\n")); // 컨텐츠 값 넣기 //<br> -> /n으로 바꿔야 기존 것이 된다.
	
%>
	
	<div class = "container my-5"> 

			<form action="../../controller/productupdatecontroller.jsp" method="post" enctype="multipart/form-data">
			<!-- form 전송 데이터 기본타입 : text (String) : enctype = "applicatio/x-www-form-urlencoded --> <!-- 기본 텍스트 값만 보낼 수 있음 -->
			<!-- form 파일 데이터 타입 : mltipart/form-data-->		<!-- 첨부파일 보낼 수 있음 -->
				<!-- hidden  ; 폼 제출 시에 사용자가 변경해서는 안 되는 데이터를 함께 보낼 때 사용-->
				<input type="hidden" name = "p_num" value="<%=p_num%>">				<!-- 수정할 게시물 번호 -->
				<input type="hidden" name = "oldfile" value="<%=product.getP_img()%>"> 	<!-- 첨부파일 변경이 없을 경우 기존 파일 -->
				
					제품명 : <input class="form-control" type="text" name="p_name"  value="<%=product.getP_name()%>"> <br>
					가격 : <input class="form-control" type="text" name="p_price" value="<%=product.getP_price()%>"> <br>
					제조사 : <input class="form-control" type="text" name="p_manufacturer" value="<%=product.getP_manufacturer()%>"> <br>
					카테고리 : <select class="form-control" name="p_category" > <%=product.getP_category()%>
							<option value="top"> top </option>
							<option value="pants"> pants </option>
							<option value="outer"> outer </option>
						</select><br>
					제품사이즈 : <select class="form-control" name="p_size"> <%=product.getP_size()%>
							<option value="S"> S </option>
							<option value="M"> M </option>
							<option value="L"> L </option>
						</select><br>
					제품재고 : <input class="form-control" type="text" name="p_stock" value="<%=product.getP_stock()%>"><br>
					제품이미지 : <input class="form-control" type="file" name="p_img" ><%=product.getP_img()%><br>
					제품내용 : <textarea class="form-control" rows="" cols="" name="p_contents" ><%=product.getP_contents()%></textarea><br>
				
				
				<input type="submit" class="form-control btn btn-primary" value="수정"><br>
					
			</form>
	</div>

</body>
</html>