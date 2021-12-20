<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 만약에 로그인이 되어있는 경우 -->
	
	<%	
		//로그인이 되어 있는 경우
		if(session.getAttribute("login") != null) {
			out.print("<script>alert('이미 로그인이 되어 있으십니다.');</script>");
			out.println("<script>location.href='../main.jsp';</script>");
		}
	%>

   <%@ include file = "../header.jsp" %><!-- 상위폴더라서 ../를 사용해야 함 -->
   <div class = "container"> <!-- 박스 -->
      <div class = "row"> <!-- 가로박스 -->
         <div class = "col-md-6">
            <img alt="" src="../../img/woman.jpg" width="100%">
         </div>
         <div class = "col-md-6 align-self-center">
            <form action = "../../controller/logincontroller.jsp" method = "post">
               <div class = "row"> <!-- 3:8 -->
                  <div class = "col-md-3 m-2"><label>아이디</label></div><!-- name만 logincontroller에 request.getParameter()에 전달가능 -->
                  <div class = "col-md-8"><input type = "text" name = "id" class = "form-control" maxlength="15"></div>
               </div>
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>비밀번호</label></div>
                  <div class = "col-md-8"><input type = "password" name = "password" class = "form-control" maxlength="15"></div>
               </div>
               <%
               	String result = request.getParameter("result");
               	if(result != null){
               		%> 	<div>
               				<span>회원정보가 올바르지 않습니다.</span>
               			</div>
               		<% 
               	}
               
               %>
               
               <div>
                 <input type = "submit" value = "로그인" class="form-control p-3 m-3">
               </div>
               <div class = "text-right m-2">
               		<!-- text-center : 가운데 정렬 text-right : 오른쪽 정렬 text-left : 왼쪽 정렬 -->
                  <a href="#" class ="btn text-dark">아이디 찾기</a> <a href="#" class ="btn text-dark">비밀번호 찾기</a>
                  
               </div>
            </form>
         </div>
      </div>
   </div>
</body>
</html>