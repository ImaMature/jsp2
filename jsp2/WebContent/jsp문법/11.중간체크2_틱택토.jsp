<%@page import="java.util.Arrays"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 틱택토 jsp 버전 -->
	<h1>틱택토 jsp</h1>
	<%!	//선언문 1. : [멤버 변수 필드]
		String [] arr = {" "," "," "," "," "," "," "," "," "};

	%>
	<%	//스크립트 문 메소드[ javaService 메소드 내에서 실행 ]
		out.print(Arrays.toString(arr)); //확인 [Arrays.toString : 배열 내용물 출력]	
	%>
	<%		
		//사용자 선택	
		for(int i =0; i<arr.length; i++){
			if(request.getParameter(i+"") !=null && request.getParameter(i+"").equals(i+"")&& arr[i].equals(" ")) {
				out.print(i+"번 선택 !!!");
				arr[i] = "O";
				//컴퓨터 난수 생성
				while(true){
					Random random = new Random();
					int com = random.nextInt(9);
					if (arr[com].equals(" ")) {
						arr[com] = "X"; break;
					}
				}
			}
		}
		
	%>
	
	<form action = "11.중간체크2_틱택토.jsp" method="get">
		<% for(int i =0; i<arr.length; i++) {%> <!-- 0 ~ 9 까지 1씩 증가 -->
		
			<button type="submit" value="<%=i %>" name="<%=i %>"> <%=i %>버튼 </button>
			<!-- type = 전송 value = "i번째 게임판" name = "i번째 인덱스" -->
			
			<!-- 3줄마다 줄바꿈 -->
			<% if(i%3==2){ out.print("<br>");}%>
	
		<% }%>
	
	</form>
</body>
</html>