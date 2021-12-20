<%@page import="DTO.Board"%>
<%@page import="DAO.BoardDao"%>
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
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	Board board = BoardDao.getBoardDao().getBoard(b_num); //수정할 게시물 가져오기
	board.setB_contents(board.getB_contents().replaceAll("<br>", "\n")); // 컨텐츠 값 넣기 //<br> -> /n으로 바꿔야 기존 것이 된다.
%>

	<div class = "container my-5"> 
		<form action="../../controller/boardupdatecontroller.jsp" method="post" enctype="multipart/form-data">
		<!-- form 전송 데이터 기본타입 : text (String) : enctype = "applicatio/x-www-form-urlencoded --> <!-- 기본 텍스트 값만 보낼 수 있음 -->
		<!-- form 파일 데이터 타입 : mltipart/form-data-->		<!-- 첨부파일 보낼 수 있음 -->
			<!-- hidden  ; 폼 제출 시에 사용자가 변경해서는 안 되는 데이터를 함께 보낼 때 사용-->
			<input type="hidden" name = "b_num" value="<%=b_num %>">				<!-- 수정할 게시물 번호 -->
			<input type="hidden" name = "oldfile" value="<%=board.getB_file()%>"> 	<!-- 첨부파일 변경이 없을 경우 기존 파일 -->
			<input type="hidden" name = "oldfile2" value="<%=board.getB_file2()%>"> 	<!-- 첨부파일 변경이 없을 경우 기존 파일 -->
			
			
			제목 : <input class="form-control" type="text" name="title" value="<%=board.getB_title() %>"> <br>	
			내용 : <textarea class="form-control"  rows="10" cols="20" name="contents"><%=board.getB_contents() %></textarea> <!--글 내용 --> <br>
			첨부파일 : <input class="form-control"  type="file" name="file"> <%=board.getB_file() %> <!-- 첨부파일 --><br>
			첨부파일2 : <input class="form-control"  type="file" name="file2" > <%=board.getB_file2() %> <br>
			<input type="submit" class="form-control btn btn-primary" value="등 록"><br>
				
		</form>
	</div>

</body>
</html>