<%@page import="test.Board"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="test.Member"%>
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

	<% // 세션 호출
		String loginid = (String)session.getAttribute("loginid");
		//logincontroller에서 호출됨
		//member.getId()한 값을 받아서
		//String loginid 에 저장
		out.print("loginid 값 :" +loginid);
		//세션은 서버에서 돌아가기 때문에 한번 호출해놓으면 해당 jsp로 include한 모든 jsp파일에서 해당 세션을 사용할 수 있음.
	%>
	<% String[] 도서목록 = {   "된다! 네이버 블로그&포스트","스프링 부트 실전 활용 마스터","Tucker의 Go 언어 프로그래밍","혼자 공부하는 C 언어"}; %>
	
	<%
		ArrayList<Member> members = new ArrayList<>();					//1. 파일 내 회원 객체 저장할 리스트
													//1-1 회원리스트를 초기화, 누적되지 않도록
													
													//2. 파일 입력 스트림 선언
		FileInputStream fileInputStream = new FileInputStream("C:\\Users\\JHD\\git\\html2\\jsp2\\src\\test\\memberlist.txt");
		byte bytes [] = new byte[1024];				//3. 읽어올 바이트들을 저장할 배열
		fileInputStream.read(bytes);				//4. 파일 읽기 -> 바이트배열 저장
		String strmember = new String(bytes);		//5. 바이트배열 -> 문자열 변환
		String [] ssmember = strmember.split("\n");	//6. 문자열 분해[\n] : 회원 구분
		//맨 끝 개행 땜시 -1
		for(int i =0; i<ssmember.length-1; i++) {	//7. 마지막 \n 제외한 반복문
			
			//memberlist.txt의 i 번째 ,를 기점으로 0번째 ~ 2번째 인덱스 값들을 각각 member 객체에 저장
			Member member = new Member(ssmember[i].split(",")[0], ssmember[i].split(",")[1], ssmember[i].split(",")[2]);
			members.add(member);	//리스트에 저장
		}
		
		fileInputStream.close();
	%>
	
	<%	//게시물 파일처리
		ArrayList<Board> boards = new ArrayList<>();
	
		fileInputStream = new FileInputStream("C:\\Users\\JHD\\git\\html2\\jsp2\\src\\test\\boardlist.txt");
		bytes = new byte[1000];
		fileInputStream.read(bytes);
		String strboard = new String(bytes);
		String [] b_list = strboard.split("\n");
		for(int i =0; i<b_list.length-1; i++) {
			Board board = new Board(b_list[i].split(",")[0], b_list[i].split(",")[1], b_list[i].split(",")[2]);
			boards.add(board);
		}
		fileInputStream.close();
	%>
	
	<h3><a href="main.jsp" >페이지 구역</a></h3>
	<ul>
		<!-- 로그인 성공시 표시되는 세션 -->
		<% if (loginid != null) {out.print("<li>" + loginid+"님 안녕하세요!");} %>
		<% if (loginid != null) {%>
			<li><a href="logout.jsp">로그아웃</a></li>
		<%} %>
		<li><a href="login.jsp">로그인</a></li>
		<li><a href="signup.jsp">회원가입</a></li>
		<li><a href="boardlist.jsp">게시판</a></li>
		<li><a href="book.jsp">도서검색</a></li>
		<li><a href="lotto.jsp">로또</a></li>
	</ul>
</body>
</html>