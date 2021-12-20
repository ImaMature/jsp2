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
	
	<div class="container">
		<div><!-- 차트 표시 구역 -->
			<canvas id="myChart"></canvas>
		</div>
	</div>
	
</body>
</html>