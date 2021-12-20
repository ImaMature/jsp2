<%@page import="DAO.BoardDao"%>
<%@page import="DTO.Board"%>
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
	
	<%
		//검색 처리 : 키워드 입력하고 검색 버튼을 눌렀을 때
		String key = request.getParameter("key");
		String keyword = request.getParameter("keyword");
		
		//페이징 처리 [1. 검색이 있을 경우 2. 검색이 없을 경우]
		//1. 총 게시물 수.
		int lastrow = BoardDao.getBoardDao().boardcount(key, keyword); 
		
		//System.out.println(lastrow);
		//4. 클릭한 페이지 번호
		String pagenum = request.getParameter("pagenum");	
		if( pagenum == null ){ 	// pagenum가 없다면 = 게시물 첫화면
			pagenum = "1";		//1페이지 설정
		}
		
		//2. 페이지 당 화면에 표시할 게시물 수 
		int listsize = 10; 	
		
		//3. 마지막페이지 구하기
		int lastpage = 0;					
		if( lastrow % listsize ==0 ){		//만약에 총 게시물 / 페이지 당 게시물 = 나머지 X이면 그대로
			lastpage = lastrow / listsize;	//총 게시물/ 페이지 당 게시물
		}else{								//나머지가 있으면
			lastpage = lastrow / listsize + 1; // * 총 게시물 / 페이지 당 게시물 + 1 
			//ex) //게시물이 34개면 10개로 나눠서 (3+1)= 4페이지
		}
		
		
		//5. 현재 페이지 번호
		int currentpage = Integer.parseInt(pagenum);
		
		//6. 현재 페이지 시작 컬럼 번호
		int startrow = (currentpage-1)*listsize;
			/* 
			시작번호 ex) 	1페이지 -> 0*10 -> 0 10개씩 1그룹하는거임
						2페이지 -> 1*10 -> 10
						3페이지 -> 2*10 -> 20
			*/
		//7. 현재 페이지 마지막 번호
		int endrow= currentpage*listsize;
						
		ArrayList<Board> boards = BoardDao.getBoardDao().boardList(startrow, listsize, key, keyword);
						
		/* System.out.println(lastrow);
		System.out.println(pagenum);
		System.out.println(currentpage);				
		System.out.println(startrow);				
		System.out.println(endrow); */
		
		
		
	%>
	
	<!-- 고객센터 페이지 -->
	<div class = "container my-5"> <!-- 박스권 -->
		
		<div class="text-center">	
			<h3 style = "border-bottom solid 1px #eeeeee;"> 고객센터 </h3>
			<br>
			<p style="color:orange;">지금 가입하시면 다양한 이벤트를 제공받을 수 있습니다.</p>
		</div>
		<%if(loginid ==null) {%>
		<p>로그인 후에 등록 가능합니다.</p>
		<%} %>
		
		<div class="text-center">
		
		<%if(keyword != null){ %>
		<p>총 게시물 수 : <%=lastrow %></p>
		<%}else {	%>
			<p>총 게시물 수 : <%=lastrow %></p>
		<% }%>
		
			<div class="col-md-12">
				<table class = "table text-center">
					<tr class="table-active">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
					<%
						//저 위에 64번째 줄 ArrayList에서 갖다씀
						//out.print(boards.size()); //DB에서 오류나면 사이즈가 0으로 반환
						if (boards.size() == 0){%>
							<tr>
								<td colspan = "5" style="text-align: center;">검색 결과가 없습니다.</td>
							</tr>	
					<% 	
						}
					%>	
					
					<%	
						for(Board temp : boards) {	
					%>	
						<tr>
							<td><%=temp.getB_num() %></td>
							<td><a href="boardview.jsp?b_num=<%=temp.getB_num() %>"><%=temp.getB_title() %></a></td>
									<!-- 게시물 상세페이지 이동 [ 클릭한 게시물 번호 요청 ] -->
									<!-- b_num 값 ArrayList에서 for문으로 가져와서 넘기기 -->
							<td><%=temp.getB_writer() %></td>
							<td><%=temp.getB_date()%></td>
							<td><%=temp.getB_view()%></td>
						</tr>
					<% 
						}
					%>
				</table>
			</div>
			
			<div class="row">
				<div class="col-md-6 offset-4 my-3">
					<ul class="pagination"> <!-- 게시판 페이징 번호 -->
						
							<!-- 첫페이지에서 이전 페이지 눌렀을 때  첫페이지 고정-->
						<% if( currentpage == 1 ){%>
							<%if ( keyword==null ) {%>
								<li class="page-item"> <a href= "boardlist.jsp?pagenum=<%=currentpage %>"  class="page-link">이전</a> </li>
							<%}else{ %>
								<li class="page-item"> <a href= "boardlist.jsp?pagenum=<%=currentpage %>&key=<%=key %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
							<%} %>	
						<%}else{ %>
							<li class="page-item"> <a href= "boardlist.jsp?pagenum=<%=currentpage-1 %>&key=<%=key %>&keyword<%=keyword %>"  class="page-link">이전</a> </li>
						<%} %>														<!-- 현재페이지번호-1 -->
						
							<!-- 게시물의 수만큼 페이지 번호 생성 -->
						<% for(int i=1; i<=lastpage; i++){ %>
						
							<% if( keyword == null ){ %>
							<li class="page-item"><a href="boardlist.jsp?pagenum=<%=i %>" class="page-link"> <%=i %> </a> </li>
									<!-- i 클릭했을때 현재 페이지 이동 [ 클릭한 페이지번호 ] -->
							<%}else{%>
							<li class="page-item"><a href="boardlist.jsp?pagenum=<%=i %>&key=<%=key %>&keyword=<%=keyword %>" class="page-link"> <%=i %> </a> </li>
							<%} %>
							
						<%} %>
						
							<!-- 마지막페이지에서 다음버튼 눌렀을때 마지막 페이지 고정 -->
						<% if( currentpage == lastpage ){%>	
						<% if( keyword == null ){ %>
							<li class="page-item"><a href="boardlist.jsp?pagenum=<%=currentpage%>" class="page-link"> 이전 </a> </li>
							<%}else{%>
							<li class="page-item"><a href="boardlist.jsp?pagenum=<%=currentpage%>&key=<%=key %>&keyword=<%=keyword %>" class="page-link"> 이전 </a> </li>	
							<%} %>
						<%}else{ %>
							<li class="page-item"><a href="boardlist.jsp?pagenum=<%=currentpage+1 %>&key=<%=key %>&keyword=<%=keyword %>" class="page-link"> 이전 </a> </li>
						<%} %>		
						
					</ul>
				</div>
				<div class="col-md-1 my-3">	
				      <%
				         if(loginid != null){ //null값은 equal 불가
				      %>
			            <a href = "boardwrite.jsp"><button class = "btn btn-primary text-right">글쓰기</button></a>
				      <%
				         }
				      %>
				</div>
			</div>
		
			<!-- 검색 -->
			<form action="boardlist.jsp?pagenum=<%=currentpage %>" method="get" class = "col-md-5 offset-3 input-group my-3">
				<select class="custom-select col-md-3" name="key"> <!-- key : 필드명 form으로 넘길거 -->
					<!-- 밑에 value넣는 이유? !!key역할!! 검색할 카테고리같은 느낌 -->
					<!-- 필드명이 들어가야됨 -->
					<option value="b_title">제목</option>
					<option value="b_contents">내용</option>
					<option value="b_num">번호</option>
					<option value="b_writer">작성자</option>
				</select>
				<input type="text" class="form-control" name="keyword">	<!-- keyword : 검색대상 -->
				<input type="submit" class="btn btn-outline-info" value="검색">
			</form>
			
		
		
			<div class="row">
				<div class="col-md-12 border  border-warning">
					<h4>자주 묻는 질문</h4>
					<table class="table">
						<tr>	<td> Q </td> <td> 아이디를 분실했습니다 </td> </tr>
						<tr>	<td> Q </td> <td> 아이디를 분실했습니다 </td> </tr>
						<tr>	<td> Q </td> <td> 아이디를 분실했습니다 </td> </tr>
						<tr>	<td> Q </td> <td> 아이디를 분실했습니다 </td> </tr>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 border m-3">
					<h3>고객센터</h3> 
					<p>1577-7011 365일 24시간 운영</p>
				</div>
				
			</div>
		</div>	
	</div>
	<br><br><br>
	

</body>
</html>