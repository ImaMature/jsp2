<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <%@include file ="../header.jsp" %> <!--  헤더 페이지 -->
   
   <% 
   //로그인[세션]이 되어 있는 경우
		if(loginid != null) {
			out.print("<script>alert('이미 로그인이 되어 있으십니다.');</script>");
			out.println("<script>location.href='../main.jsp';</script>");
		}
   %>
   <div class = "container"> <!-- 박스권 :  -->
      <div class = "row"> <!-- 가로 박스 -->
         <div class = "col-md-6"> <!-- 6:6 -->
            <img src="../../img/woman.jpg " width = 100%; >
         </div>
         
         <div class = "col-md-6"> <!-- 6:6 -->												<!-- onsubmit이 있어야 main.js의 signupcheck()가 작동함 -->
            <form id = "signupform"action = "../../controller/signupcontroller.jsp" method="post" onsubmit="return signupcheck()">
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>아이디</label></div>
                  <div class = "col-md-8"> <input type="text" id="id" name = "id" onchange ="signupcheck();" class = "form-control" maxlength="15" ></div>
               </div>
               <div>
                  <span id = "idresult"></span>
               </div>
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>비밀번호</label></div>
                  <div class = "col-md-8"> <input id = "password" onchange ="signupcheck();" type="password" name = "password" class = "form-control" maxlength="15"></div>
               </div>
               
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>비밀번호 확인</label></div>
                  <div class = "col-md-8"> <input id = "passwordconfirm" onchange ="signupcheck();" type="password" name = "passwordconfirm" class = "form-control" maxlength="15"></div>
               </div>
               <div>
                   <span id = "pwresult"></span>
               </div>
               
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>이름</label></div>
                  <div class = "col-md-8"> <input type="text" id="name" onchange="signupcheck();" name = "name" class = "form-control"></div>
               </div>
               <div>
                   <span id = "nameresult"></span>
               </div>
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>생년월일</label></div>
                  <div class = "col-md-8"> <input type="date" id="birth" onchange="signupcheck();" name = "birth" class = "form-control"></div>
               </div>
               <div>
                   <span id = "birthresult"></span>
               </div>
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>성별</label></div>
                  <div class = "col-md-8 text-center"> 
                  
                     <input type="radio" name = "sex" value = "man" id="sex1" onchange="signupcheck();">남
                     <input type="radio" name = "sex" value = "woman" id="sex2" onchange="signupcheck();">여
                     
                  </div>
               </div>
               
               <div>
                   <span id = "sexresult"></span>
               </div>
               
               <div class = "row">
                  <div class = "col-md-3 m-2"><label>연락처</label></div>
                  <div class = "col-md-8"> 
                     <input type="text" id="phone" onchange="signupcheck();" name = "phone" class = "form-control" placeholder = "000-0000-0000">
                  </div>
               </div>
               	<div>
                     <span id = "phoneresult"></span>
                </div>
               
               
               <div class = "row">
                  <div class = "col-md-3 m-2">
                     <label>주소</label>
                  </div>
                  <div class="col-md-8">
                     <div class = "row">
                        <div class = "col-md-6"><input type="text" name = "address1" id="sample4_postcode" placeholder="우편번호" class="form-control">          </div>
                        <div class = "col-md-6"><input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="form-control"><br>         </div>
                     </div>
                     <div class = "row">
                        <div class = "col-md-6"><input type="text" name = "address2" id="sample4_roadAddress" placeholder="도로명주소" class="form-control">   </div>
                        <div class = "col-md-6"><input type="text" name = "address3" id="sample4_jibunAddress" placeholder="지번주소" class="form-control">   </div>
                     </div>
                     <input type="text" id="sample4_detailAddress" name = "address4" placeholder="상세주소" class="form-control">
                  </div>
               </div>
               <div>
                  <input type="submit" value = "가입하기 " class = "form-control p-3 m-3">
               </div>
            </form>
         </div>
      </div>
   </div>
   
   
</body>
</html>