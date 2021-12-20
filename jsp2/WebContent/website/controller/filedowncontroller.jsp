<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//컨트롤러는 윗줄에 있는 필수 HTML 제외하고는 HTML 노필요

	//1. 파일 이름 요청 
	// boardview.jsp에서 [조건 : "../../controller/filedowncontroller.jsp?file=<%=board.getB_file()" ]이 있어야함
	request.setCharacterEncoding("UTF-8");
	String filename = request.getParameter("file");
	
	
	//2. 경로 찾기 (서버 내 업로드 폴더 찾기)
	//String folderpath = request.getSession().getServletContext().getRealPath("website/upload/"+filename);
							//request.getSession().getServletContext().getRealPath : 서버 내 경로 찾기					
	
	String folderpath = "C:/Users/505/git/html2/jsp2/WebContent/website/upload/"+filename;
							
	//3.  파일 객체화 (서버 내 업로드 폴더 내의 해당 파일을 찾아서 객체화)
	File file = new File (folderpath);
	
	//4. 다운로드 형식 변경						
	//클라이언트에게 응답하기
	response.setHeader("Content-Disposition", "attachment;filename=" + filename +";");
											//attachment로 파일 이름을 그대로 넣어주기
	
	
	//내보내기 [스트림 사용]
		//1) 바이트 배열 선언
		byte [] bytes = new byte[(int)file.length()];	//file.length : 파일내 바이트 길이 메소드
		
		//2) 파일 존재 여부 확인
		if(file.isFile()) {	//file.isFile() : 파일이 존재하는지 유무 확인
			//true면 실행
			
			//입력 스트림 [ 해당 경로에서 파일 읽어오기 [ 바이트로 읽어오기 ]]
			BufferedInputStream inputStream = new BufferedInputStream(new FileInputStream(file));
		
			//출력 스트림 [ 읽어온 바이트형 파일을 내보내기]  //response.getOutputStream() : 클라이언트에게 파일 전송
			BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
			
			int count; //임시변수 count 선언
			
			while((count = inputStream.read(bytes)) != -1) { // -1은 바이트가 없다 [읽어올 게 없음]
				//count에 읽어온 걸 저장한뒤 count 가 -1인지 아닌지	
				
				outputStream.write(bytes, 0, count); //0부터 count까지
			}
			inputStream.close();	//스트림 닫기
			outputStream.close();	//스트림 닫기
			
		}//false면 실행 X
		
			
%>