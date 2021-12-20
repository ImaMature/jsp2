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
		int sum= 0;
		for (int i =0; i<=100; i++) {
			sum+=i;
		
		}
	%>
	
	1부터 100까지의 합 : <%= sum %>
	
	<form action="6.제어문2결과.jsp" method="post">
	
		반복할 문자 : <input type="text" name="string"><br>
		반복할 횟수 : <input type="text" name="count"><br>
		전송 <input type="submit" value="전송">
	</form>
	
	<!-- 
		form 
			action : "이용할 페이지 경로"
			method : 전송방식
				* post : URL 변수가 안보임 [기록을 안남김. 보안 중요!! / 로그인시 사용]
				* get : URL 변수가 보임 [ 보안 별로 안중요할때, 속도가 빠름 ]
				
		
	
	 -->
</body>


</html>