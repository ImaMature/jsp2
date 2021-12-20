<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String folderpath = "C:/Users/504/git/html2/jsp2/WebContent/website/upload";
	//이 친구만 직접경로 서버가 다운되면 다 사라지기 때문 새로고침 필요X
	MultipartRequest multipartRequest = new MultipartRequest(
												request, 
												folderpath, 
												1024*1024*100, 		//용량(byte단위)제한 1024byte * 1024 = 1mb *100 = 100mb
												"UTF-8", 
												new DefaultFileRenamePolicy() );
	
	
	//제품 등록 하기 위해 product 객체화	
	Product product = new Product(
			//코드의 우선순위 -> 괄호 안의 괄호(파라미터 빼오기), 그다음 형변환하고 그걸 생성자에 대입하고 그다음 product객체에 저장
					multipartRequest.getParameter("p_name"),
					Integer.parseInt( multipartRequest.getParameter("p_price")),
					multipartRequest.getParameter("p_category"),
					multipartRequest.getParameter("p_manufacturer"),
					Integer.parseInt( multipartRequest.getParameter("p_active")),
					multipartRequest.getParameter("p_size"),
					Integer.parseInt( multipartRequest.getParameter("p_stock")),
					multipartRequest.getFilesystemName("p_img"),
					multipartRequest.getParameter("p_contents")
					);
	
	
	boolean rs = ProductDao.getproductDao().productwrite(product);
	if(rs){
		out.print("<script> alert('제품등록 완료.'); </script>");
		out.print("<script> location.href='../view/admin/dashboard.jsp'; </script>");
	}else{
		out.print("<script> alert('제품등록 실패.'); </script>");
		out.print("<script> location.href='../view/admin/dashboard.jsp'; </script>");
	}
	
	
	//DB 처리
	
%>
