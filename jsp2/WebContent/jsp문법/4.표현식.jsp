<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h3>표현식</h3>
	<%! String []이름 = {"유재석", "강호동","신동엽"}; %>
	
	<table border="1" width="200">
		<% 		//java start
			for(int i = 0; i<이름.length; i++){
				//java end
		%>
			<!-- html 시작 -->
		<tr>	
			<td><%=i %></td> <td><%=이름[i] %></td>
		</tr>
			
			<!-- html 끝 -->
		<% 
		} //java 시작
		 	//java 끝
		%>
	</table>
	
</body>
</html>