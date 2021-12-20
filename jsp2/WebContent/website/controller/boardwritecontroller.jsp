<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="DAO.BoardDao"%>
<%@page import="DTO.Board"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

//위 html 태그들은 지웠음 필요없는거라서

//첨부파일은 request.getParameter로 하면 null값만 뜸
//1. servlet 홈페이지에서 COS파일 라이브러리 클릭해서 cos20.08 다운
//2. buildpath 에 추가 cos.jar
//3. cos.jar web-info폴더 lib에 넣기
//4. MultipartRequest쓰기 (자동완성 돼야됨)
//5. 그래도 빨간 줄 뜨면 라이브러리에 javaSe 를 1.8로 변경 

//1. MultipartRequest 객체명 = new MultipartRequest(요청방식[request], 업로드파일 폴더경로, 용량[바이트단위], 인코딩타입, 보안 )
// 1) 요청방식 : request
// 2) 업로드할 폴더 경로
// 3) 용량 : 바이트단위
// 4) 인코딩 타입 : "UTF-8" [기본]
// 5) 보안 : 	new DefaultFileRenamePolicy()
//    DefaultFileRenamePolicy : 파일 명이 동일할 경우 자동으로 파일 명 뒤에 번호 부여 [식별] 
	
/* 업로드(파일첨부) 하는 방법*/

//1. 현재 작업폴더 업로드 (서버 refresh 필요) //서버 여러개일때 (작업할 때는 이거 쓰다가 배포할 때는 서버 실제 경로로 변경)
String folderpath = "C:/Users/505/git/html2/jsp2/WebContent/website/upload";

//2. 서버 폴더로 업로드

//2-1) 서버 실제 경로 찾기
//String folderpath = request.getSession().getServletContext().getRealPath("website/upload");

//2-2) 경로 확인해보기 (DB처리만 주석처리하고 확인가능)
//System.out.print("folderpath : " + folderpath);

//3. 업로드하는 양식 객체화
 MultipartRequest multi = new MultipartRequest(request, folderpath, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());


//요청 [첨부파일 등 다양한 파일]
request.setCharacterEncoding("UTF-8"); //요청시 한글 인코딩 값
String title = multi.getParameter("title");
String contents = multi.getParameter("contents");

//내용에 엔터친것도 DB에 들어가게 만들기
//contents = contents.replace("\r\n", "<br>");

//프론트 <  >태그 제거 (입력상자 사용시)
//입력상자가 있는 모든 곳에 다 태그 못쓰게 막아야함
contents = contents.replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");
									//왼쪽					//오른쪽
title = title.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?", "");


String file = multi.getFilesystemName("file"); 
String file2 = multi.getFilesystemName("file2");


/* 요청 [일반 form]
request.setCharacterEncoding("UTF-8"); //한글 인코딩 값
String title = request.getParameter("title");
String contents = request.getParameter("contents");
String file = request.getParameter("file"); 
		//객체명.getParameter("필드명")  */

/* out.print(contents + "<br>");
out.print(file + "<br>"); */

//작성자의 아이디 회원번호
Login login = (Login)session.getAttribute("login"); 

int m_num = login.getM_num();

//객체화
Board board = new Board(title, contents, m_num, file, file2);

//DB처리
BoardDao.getBoardDao().boardwrite(board); 

response.sendRedirect("../view/board/boardlist.jsp");//페이지 이동


%>
