<%@page import="DAO.MemberDao"%>
<%@page import="DTO.Member"%>
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
		

		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String passwordconfirm = request.getParameter("passwordconfirm");
		String name = request.getParameter("name");
		String birth = request.getParameter("birth");
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String address = 
				request.getParameter("address1") + "," + request.getParameter("address2") + "," +
				request.getParameter("address3") + "," + request.getParameter("address4");
		
		//프로젝트 규모가 클 때는 상세주소 일반주소 따로 두는게 좋다. DB규모는 커지겠지만 말이다.
		//하지만 여기선 주소들을 한번에 다 받아오는 걸로 했음
		
		//유효성 검사 //최대 길이 제한은 signup.jsp에 maxlength
/*		if(id.equals("") || password.equals("") || passwordconfirm.equals("") || name.equals("") || birth.equals("") || sex.equals("") || address.equals("")){
 			out.print("<script>alert('입력 X된 곳이 있습니다.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		else if(id.length() < 5 ) {
			out.print("<script>alert('아이디는 5~15글자 사이로 입력해주세요.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		else if(name.length() < 2 ) {
			out.print("<script>alert('이름 2글자 이상');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		else if(password.length() < 5 ) {
			out.print("<script>alert('비밀번호는 5~15글자 사이로 입력해주세요.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		else if(!password.equals(passwordconfirm)) {
			out.print("<script>alert('비밀번호가 맞지 않습니다.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		
		//전화번호의 길이가 11이 아니라면 000-0000-0000(여기서 하이픈 뺀거임)
		else if(phone.length() != 11){
			out.print("<script>alert('전화번호는 11자리여야 합니다.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		
		// 쉼표가 0개 초과라면 //.indexof() : 특정 문자의 위치를 찾기
		else if(request.getParameter("address4").indexOf(",") > 0) {
			out.print("<script>alert('사용할 수 없는 문자가 있습니다.');</script>");
			out.println("<script>location.href='../view/member/signup.jsp';</script>");
		}
		else{ */
			//객체화
			
			Member member = new Member(id, password, name, birth, sex, phone, address);
			
			//DB처리
			
			boolean result = MemberDao.getmemberDao().membersignup(member);
			if(result) { //회원가입 성공
				response.sendRedirect("../view/member/signupsuccess.jsp");
				out.print("1");
			}else{ //회원가입 실패
				response.sendRedirect("../view/member/signup.jsp"); 
				out.print("0");
			} 
				/* if(result){
					out.print("1");
					//out.print ->  스크립트 태그 나가기
				}else{
					out.print("0");
				}  */
			//js에서 유효성 검사를 새로 배웠기 때문에 위에 html내에서 유효성 검사하는 문장들을 주석처리했음
		//}
	%>
</body>
</html>