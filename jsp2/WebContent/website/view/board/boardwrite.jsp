<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../header.jsp" %> <!-- 헤더페이지 -->
	
	<!-- 글쓰기 페이지 -->
	
	<div class = "container my-5"> 
		<form action="../../controller/boardwritecontroller.jsp" method="post" enctype="multipart/form-data">
		<!-- form 전송 데이터 기본타입 : text (String) : enctype = "applicatio/x-www-form-urlencoded --> <!-- 기본 텍스트 값만 보낼 수 있음 -->
		<!-- form 파일 데이터 타입 : mltipart/form-data-->		<!-- 첨부파일 보낼 수 있음 -->
			
			제목 : <input class="form-control" type="text" name="title"> <br>
			내용 : <textarea class="form-control"  rows="10" cols="20" name="contents"></textarea> <!--글 내용 --> <br>
			첨부파일 : <input class="form-control"  type="file" name="file" > <!-- 첨부파일 --><br>
			첨부파일2 : <input class="form-control"  type="file" name="file2" > <br>
			<input type="submit" class="form-control btn btn-primary" value="등 록"><br>
				
		</form>
	</div>
</body>
</html>