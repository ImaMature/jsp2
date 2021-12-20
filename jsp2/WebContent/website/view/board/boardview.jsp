<%@page import="DTO.Reply"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.BoardDao"%>
<%@page import="DAO.MemberDao"%>
<%@page import="DTO.Board"%>
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
	
		//전 페이지(boardlist)에서 클릭한 게시물 번호
		int b_num = Integer.parseInt(request.getParameter("b_num")); //전 페이지에서 클릭한 게시물 번호
		
		//총 리플 수
		int replyLastRow = BoardDao.getBoardDao().replyCount(b_num);
		
		//System.out.println("replyLastRow 값 : " + replyLastRow);
		//클릭한 리플 번호
		String ReplyPageNum = request.getParameter("ReplyPageNum");
		if( ReplyPageNum == null) {
			ReplyPageNum="1";
		}
		
		//리플 페이지 수 몇 단위로 자를 건지
		int replysize = 5;
		
		//마지막 페이지 구하기
		int lastreply = 0;
		if(replyLastRow % replysize == 0){
			lastreply = replyLastRow / replysize;
			//System.out.println("lastreply 값 : " + lastreply);
		}else{
			lastreply = replyLastRow / replysize +1;
		}	
		//현재 페이지 번호
		int currentreply = Integer.parseInt(ReplyPageNum);
		
		//현재 페이지 시작 번호
		int startreply = (currentreply-1)*replysize;
		
		
		
						//loginid => header.jsp에서 가져옴
		String boardviews = loginid + " : " + b_num; 	// 1. 현재 로그인 id + 게시물 번호; => 세션 이름 사용예정
		//null값이 아니고, 가져온 세션이 false이면
		if(session.getAttribute(boardviews) == null){ 	// 2. (현재 로그인 id + 게시물)의 세션명이 존재하지 않으면
			//조회수 증가
			BoardDao.getBoardDao().boardView(b_num); 	// 3. DB호출 [ 조회수 증가 ]
			//조회수 증가 방지 [세션 생성 -> 세션아이디, 세션 값]
			String boardview = loginid + " : " + b_num;	// 4. 세션명 = 현재 로그인 id + 게시물 번호
			session.setAttribute(boardview, true);		// 5. 조회수 증가 방지 [ 세션 생성 : 세션아이디 , 세션값 ]
			session.setMaxInactiveInterval(60*60*24); 	// 세션 유효시간 60초*60*24 == 하루
		}
		
		//해당 게시물 번호의 게시물 가져오기
		Board board = BoardDao.getBoardDao().getBoard(b_num);
		//System.out.println(board);
		
		//해당 게시물 번호의 리플 가져오기
		Reply reply = BoardDao.getBoardDao().getreply(b_num);
	%>
	
	<!-- 게시물 상세 페이지 -->
	<div class="container my-5 table-responsive">
		<h3  >문의게시판</h3>
			<div class="row">
					<div class="m-2"><a href="boardlist.jsp"><button class = "form-control">목록보기</button></a></div>
					<%if(loginid != null && loginid.equals(board.getB_writer())){ %> <!-- 로그인이 되어있고, 작성자 아이디가 로그인한 아이디와 같으면 -->
						<div class="m-2"><a href="boardupdate.jsp?b_num=<%=board.getB_num() %>"><button class = "form-control btn btn-primary">수정하기</button></a></div>
						<div class="m-2"><a href="../../controller/boardDeletecontroller.jsp?b_num=<%=board.getB_num() %>"><button class = "form-control btn btn-danger">삭제하기</button></a></div>
					<%} %>
			</div>
			<table class= "table  text-center">
				<tr>
					<td style="background-color:#cccccc; width:20%;">작성자</td><td><%=board.getB_writer() %></td>
					<td style="background-color:#cccccc;">작성일</td><td><%=board.getB_date() %></td>
					<td style="background-color:#cccccc;">조회수</td><td><%=board.getB_view() %></td>
				</tr>
				<tr >
					<td style="background-color:#cccccc;">제목</td>
					<td colspan="5"><%=board.getB_title() %></td>
				</tr>
				<tr>
					<td style="height:300px; background-color:#cccccc;">내용</td>
					<td colspan="5"><%=board.getB_contents() %></td>
				</tr>
				<tr>
					<td style="background-color:#cccccc;">첨부파일 다운로드
						<%	if(board.getB_file() == null){ %>
						<%	}else{%>
							<a href="../../controller/filedowncontroller.jsp?file=<%=board.getB_file()%>"><%=board.getB_file() %></a>
					</td>								<!-- 첨부파일과 같이 이동하기 -->			<!-- 이동하는 애 -->				<!-- 화면에 표시되는 애 -->
						<%	}%>
						<%	if(board.getB_file() == null){ %>
							<td colspan="5" height="300px;"></td>
						<%	}else{ %>
							<td colspan="5" height="300px;">	<!-- 박스권 안에 사진 사이징 : max-width , max-height -->
							파일1 미리보기<br> <img src="../../upload/<%=board.getB_file()%>" style="max-width: 100%; max-height: 100%">
							</td>
						<%} %>
				</tr>
				<tr>
					<td style="background-color:#cccccc;">첨부파일 다운로드
						<%	if(board.getB_file2() == null){ %>
						<%	}else{%>
							<a href="../../controller/filedowncontroller.jsp?file=<%=board.getB_file2()%>"><%=board.getB_file2() %></a>
					</td>								<!-- 첨부파일과 같이 이동하기 -->			<!-- 이동하는 애 -->				<!-- 화면에 표시되는 애 -->
						<%	}%>
						<%	if(board.getB_file2() == null){ %>
							<td colspan="5" height="300px;"></td>
						<%	}else{ %>
							<td colspan="5" height="300px;">	<!-- 박스권 안에 사진 사이징 : max-width , max-height -->
								파일2 미리보기<br> <img src="../../upload/<%=board.getB_file2()%>" style="max-width: 100%; max-height: 100%">
							</td>
						<%} %>
				</tr>
		</table>
		<br><br>
			<hr>
			<form action="../../controller/replycontroller.jsp?b_num=<%=board.getB_num() %>" method="post">
			<div class="row">
				<div class="col-md-2" >
					<h6>댓글작성 </h6>
				</div>
				<div class="col-md-8" >
					<textarea rows="" cols="" class="form-control" name="replycontents" ></textarea> 
				</div>
				<%if(loginid != null){ %>
					<div class="col-md-2">
						 <input type="submit" class="form-control btn btn-primary" value="등 록"><br>
					</div>
				<%} %>
			</div>
			</form>
			
			<table class="table">
				<tr>
					<th> 작성자 </th> <th> 내용 </th> <th> 작성일 </th>
				</tr>
					<%
						//위에서 b_num 가져옴
						ArrayList <Reply> replies = BoardDao.getBoardDao().replyList(b_num, startreply, replysize);
						for(Reply temp : replies){
					%>
								<tr>
									<td> <%=temp.getR_writer() %></td> 
									<td> <%=temp.getR_contents() %></td> 
									<td> <%=temp.getR_date() %> </td>
									<%if(loginid != null && loginid.equals(temp.getR_writer())){ %>
										<td><a href="../../controller/replyDeletecontroller.jsp?r_num=<%=temp.getR_num() %>&b_num=<%=temp.getB_num()%>"><button class="form-control btn btn-danger" style="cursor: pointer;">삭제</button></a></td>
									<%} %>
								</tr>
					<%		
						}
					%>
					
			<!-- 리플!!!!! -->		
			</table>
			<div class="row">
			<div class="col-md-6 offset-4 my-3">
			<ul class="pagination"> <!-- 리플 페이징 번호 -->
					
					<!-- 첫페이지에서 이전 페이지 눌렀을 때 -->
					<% if( currentreply == 1 ){%>
						<li class="page-item"> <a href= "boardview.jsp?ReplyPageNum=<%=currentreply %>&b_num=<%=b_num %>"  class="page-link">이전</a> </li>
					<%}else{ %>
						<li class="page-item"> <a href= "boardview.jsp?ReplyPageNum=<%=currentreply-1 %>&b_num=<%=b_num %>"  class="page-link">이전</a> </li>
					<%} %>
					
						<!-- 게시물의 수만큼 페이지 번호 생성 -->
					<% for(int i=1; i<=lastreply; i++){ %>
						<!-- i를 클릭했을 때 현재 페이지 이동 [ 클릭한 페이지번호 ] -->
						<li class="page-item"> <a href= "boardview.jsp?ReplyPageNum=<%=i %>&b_num=<%=b_num %>" class="page-link"><%=i %></a> </li>
					<%} %>
					
						<!-- 마지막페이지에서 다음버튼 눌렀을때 마지막 페이지 고정 -->
					<% if( currentreply == lastreply ){%>	
						<li class="page-item"> <a href= "boardview.jsp?ReplyPageNum=<%=currentreply %>&b_num=<%=b_num %>" class="page-link">다음</a> </li>
					<%}else { %>
						<li class="page-item"> <a href= "boardview.jsp?ReplyPageNum=<%=currentreply+1 %>&b_num=<%=b_num %>" class="page-link">다음</a> </li>
					<%} %>
					
				</ul>
			</div>
		</div>
	</div>
</body>
</html>