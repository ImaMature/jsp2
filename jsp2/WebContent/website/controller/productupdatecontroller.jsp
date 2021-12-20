<%@page import="DTO.Product"%>
<%@page import="DAO.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

String folderpath = request.getSession().getServletContext().getRealPath("website/upload");

MultipartRequest multi = new MultipartRequest(request, folderpath, 1024*1024*100, "UTF-8", new DefaultFileRenamePolicy());

request.setCharacterEncoding("UTF-8");

int p_num = Integer.parseInt(multi.getParameter("p_num"));
String p_name = multi.getParameter("p_name");
int p_price = Integer.parseInt(multi.getParameter("p_price"));
String p_manufacturer = multi.getParameter("p_manufacturer");
String p_category = multi.getParameter("p_category");
String p_size = multi.getParameter("p_size");
int p_stock = Integer.parseInt( multi.getParameter("p_stock"));
String p_img = multi.getFilesystemName("p_img");
String p_contents = multi.getParameter("p_contents");
p_contents = p_contents.replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>");

if(p_img == null) {	//새로운 첨부가 없을 경우 기존 첨부를 DB에 저장
	p_img = multi.getParameter("oldfile"); //type이 hidden이라서 getParameter사용
}
Product product = new Product(p_name, p_price, p_category, p_manufacturer, p_size, p_stock, p_img, p_contents);

boolean result = ProductDao.getproductDao().p_Update(product, p_num);

if(result) {
	out.print("<script>alert('제품 정보가 수정되었습니다.');</script>");
	out.print("<script> location.href='../view/admin/dashboard.jsp?p_num="+p_num+"'; </script>");
}else{
	out.print("<script>alert('제품 정보가 수정 실패.');</script>");
	out.print("<script> location.href='../view/admin/dashboard.jsp?p_num="+p_num+"'; </script>");
}

%>