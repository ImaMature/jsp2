<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@page import="DTO.Porderdetail"%>
<%@page import="DAO.PorderDao"%>
<%@page import="DTO.Porder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%int item =Integer.parseInt(request.getParameter("item")); //ajax���� ��û%>    
<%Login login = (Login) session.getAttribute("login"); //�α��� �� ȸ�� ���� ������ header include ������%>
<%ArrayList <Porder> porders = PorderDao.getporderDao().getporderlist(login.getM_num()); 
//System.out.print(login.getM_num());
//System.out.print( porders.get(0).getM_num());%>
<%for (int i = item; i<item+1; i++){ //�ֹ����� �ֹ� ��� �ε����� item���� ��� item ũ��+1��ŭ%>
<div class="row mt-5">
	<div class="col-md-4 border rounded p-3 d-flex align-content-center flex-wrap"> <!-- �ֹ� ���� --> <!-- d-flex align-content-center flex-wrap : ���� -->
		<p>�ֹ���ȣ : <%=porders.get(i).getOrder_num() %></p>
		<p>�ֹ��� : <%=porders.get(i).getOrder_date() %></p>
		<button class="form-control">�ֹ���</button>
	</div>
	<div class="col-md-8 border rounded p-3"> <!-- �ֹ� �� -->
		<!-- 2. �ֹ� ���â�� �ֹ��� �߰� -->
		<%ArrayList<Porderdetail> porderdetails = 
							PorderDao.getporderDao().getpPorderdetails(porders.get(i).getOrder_num()); %>
		<%for (int j = 0; j<porderdetails.size(); j++){ %>
		<!-- 3. �ֹ� ���â�� �ֹ��� �߰� -->
		<% Product product = ProductDao.getproductDao().getproduct(porderdetails.get(j).getP_num()); %>
		<p>�ֹ� ��ǰ ����</p><hr>
		<div class="row">
			<div class="col-md-3 d-flex align-items-center"> <!-- d-flex align-items-center : �������� -->
				<img alt="" src="../../upload/<%=product.getP_img()%>" style="width: 100%;">
			</div>
			<div class="col-md-9 row">
				<div class="col-md-8">
					<p class="pview" > ��ǰ�� : <%=product.getP_name()%>  </p>
					<p> �ɼ� : <%=product.getP_size()%> ���� : <%=porderdetails.get(j).getP_count()%> </p>
					<p> ��ۻ��� : <%=porderdetails.get(j).getDelivery_state()%> </p>
				</div>
				<div class="col-md-2">
					<button class="btn btn-outline-danger my-3">��� ��ȸ</button>
					<button class="btn btn-outline-danger my-3">�ֹ� ����</button>
				</div>
			</div>
		</div>
		<%} %>
	</div>
</div>
<%
} 
%>