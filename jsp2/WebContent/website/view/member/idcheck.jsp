<%@page import="DAO.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% //jsp 태그 //탭 누르면 공백들어감 //그래서 안됐네

	//alert창에 HTML내용들이 안나오도록 필요없는 부분 지우기
	
	//!!!중요 : jsp태그는 통신 결과로 반환 X HTML태그들만 통신 결과로 반환O
	
	//1.ajax와 통신된 데이터를 요청 (main.js에서 userid라는 변수를 입력받아와서)
	String userid = request.getParameter("userid");
	//System.out.print(userid); //아이디가 들어오는지 콘솔에 확인하기
	
	
	//2. Dao 아이디 체크
	boolean result = MemberDao.getmemberDao().idcheck(userid);
	if(result){
		
		out.print("1"); //중복 시 (여기서 html로 나가서 그 값이 main.js의 success result에 들어간다.) 
		//out.print = jsp태그 -> html태그로 나가서 html에 작성하기
	}else{
		out.print("0"); //미중복 (여기서 html로 나가서 그 값이 main.js의 success result에 들어간다.)
	}
%>
