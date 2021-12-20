<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@page import="DTO.Porderdetail"%>
<%@page import="DAO.PorderDao"%>
<%@page import="DTO.Porder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%int item =Integer.parseInt(request.getParameter("item")); //ajax변수 요청%>    
<%Login login = (Login) session.getAttribute("login"); //로그인 된 회원 정보 빼오기 header include 안했음%>
<%ArrayList <Porder> porders = PorderDao.getporderDao().getporderlist(login.getM_num()); 
//System.out.print(login.getM_num());
//System.out.print( porders.get(0).getM_num());%>
<%for (int i = item; i<item+1; i++){ //주문자의 주문 목록 인덱스는 item으로 사용 item 크기+1만큼%>
<div class="row mt-5">
	<div class="col-md-4 border rounded p-3 d-flex align-content-center flex-wrap"> <!-- 주문 정보 --> <!-- d-flex align-content-center flex-wrap : 정렬 -->
		<p>주문번호 : <%=porders.get(i).getOrder_num() %></p>
		<p>주문일 : <%=porders.get(i).getOrder_date() %></p>
		<button class="form-control">주문상세</button>
	</div>
	<div class="col-md-8 border rounded p-3"> <!-- 주문 상세 -->
		<!-- 2. 주문 목록창에 주문상세 추가 -->
		<%ArrayList<Porderdetail> porderdetails = 
							PorderDao.getporderDao().getpPorderdetails(porders.get(i).getOrder_num()); %>
		<%for (int j = 0; j<porderdetails.size(); j++){ %>
		<!-- 3. 주문 목록창에 주문상세 추가 -->
		<% Product product = ProductDao.getproductDao().getproduct(porderdetails.get(j).getP_num()); %>
		<p>주문 제품 내역</p><hr>
		<div class="row">
			<div class="col-md-3 d-flex align-items-center"> <!-- d-flex align-items-center : 수직정렬 -->
				<img alt="" src="../../upload/<%=product.getP_img()%>" style="width: 100%;">
			</div>
			<div class="col-md-9 row">
				<div class="col-md-8">
					<p class="pview" > 상품명 : <%=product.getP_name()%>  </p>
					<p> 옵션 : <%=product.getP_size()%> 수량 : <%=porderdetails.get(j).getP_count()%> </p>
					<p> 배송상태 : <%=porderdetails.get(j).getDelivery_state()%> </p>
				</div>
				<div class="col-md-2">
					<button class="btn btn-outline-danger my-3">배송 조회</button>
					<button class="btn btn-outline-danger my-3">주문 변경</button>
				</div>
			</div>
		</div>
		<%} %>
	</div>
</div>
<%
} 
%>