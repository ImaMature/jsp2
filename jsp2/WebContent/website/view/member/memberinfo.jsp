
<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Product"%>
<%@page import="DTO.Porderdetail"%>
<%@page import="DAO.PorderDao"%>
<%@page import="DTO.Porder"%>
<%@page import="java.util.ArrayList"%>
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
	
	<%@include file = "../header.jsp" %>
	
	<div class="container">
	
		<br><br>
		
		<div style="margin: 10px">
			<h3 style="border-bottom: solid 1px #eeeee;"> 회원 정보 </h3>
			<br>
			<p style="color: orange;"> · 공지사항을 참고해주세요 · </p>
		</div>
			<br><br>
		<div class="row">
			<div class="col-md-3">	<!-- 사이드바 -->
				<div class="nav flex-column nav-pills">	<!-- flex-column : 세로 메뉴 	// nav-pills : 액티브[클릭] 색상  -->
					<a class="nav-link active" data-toggle="pill" href="#pills-order"> 주문 목록 </a>	
					<a class="nav-link" data-toggle="pill" href="#pills-memberinfo"> 회원 정보 </a>	
					<a class="nav-link" data-toggle="pill" href="#pills-memberwrite"> 내가 쓴글 </a>	
					<a class="nav-link" data-toggle="pill" href="#pills-memberupdate"> 회원 수정 </a>	
					<a class="nav-link" data-toggle="pill" href="#pills-memberdelete"> 회정 탈퇴 </a>	
				</div>
			</div>
			
			<div class="col-md-9">	<!-- 내용 -->
				<div class="tab-content" id="pills-tabcontent">
				
					<div class="tab-pane fade show active" id="pills-order">	<!-- fade : 숨김  show : 열기   -->
						<h3> 주문 목록 </h3>
						<div class="container">
						<section> <!-- ajax에서 append한거 결과 추가됨 -->
							<%ArrayList <Porder> porders = PorderDao.getporderDao().getporderlist(login.getM_num()); 
							//System.out.print(login.getM_num());
							//System.out.print( porders.get(0).getM_num());%>
							<%//for (int i = 0; i<porders.size(); i++){
									for (int i = 0; i<2; i++){%> <!-- 스크롤 때문에 2개로 제한을 둠 -->
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
						</section>
						</div>
					</div>
					
					<%
						// 로그인된 아이디[세션]의 정보 호출
						Member member = MemberDao.getmemberDao().memberinfo(loginid);
					%>
					<div class="tab-pane fade" id="pills-memberinfo">
						<div class="container">
							<table class="table text-center">	<!-- class="table" : 부트스트랩 테이블 --> 
								<thead>
									<tr>
										<th colspan="3" > 회원 개인 정보 </th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td> 아이디 </td> <td colspan="3"> <%=member.getM_id() %> </td><td></td>
										<%//System.out.print(member.getM_id()); %>
									</tr>
									<tr>
										<td > 패스워드 </td>
										<td id="tdpassword"> ···· </td>  	
										<td > <button onclick="passwordchange();"  class="btn btn-primary">수정</button> </td>	
									<tr>
										<td> 포인트 </td> <td colspan="3"> <%=member.getM_point() %> </td><td></td>
									</tr>
									<tr>
										<td > 회원명 </td> 
										<td id="tdname"> <%=member.getM_name() %> </td>  	
										<td> <button onclick="namechange();" class="btn btn-primary">수정</button> </td>
									</tr>
									<tr>
										<td> 성별 </td> 
										<td id= "tdsex" > <%=member.getM_sex() %> </td>  	
										<td > <button onclick="sexchange();" class="btn btn-primary">수정</button> </td>
										
									</tr>
									<tr id="trsexradio" style="display: none;" >
										<td colspan="3">
											<div class = "row">
							                  <div class = "col-md-3 m-2"><label>성별</label></div>
							                  <div class = "col-md-8 text-center"> 
							                  
							                     <input type="radio" name = "sex" value = "man" id="sex" >남
							                     <input type="radio" name = "sex" value = "woman" id="sex" >여
							                     
							                  </div>
							                  <div>
							                  	<button id = "sexchangebtn" class="btn btn-success" type="submit">수정</button>
							                  </div>
							               </div>
						               </td>
									</tr>
									<tr>
										<td> 생년월일 </td> 
										<td id="tdbirth"> <%=member.getM_birth()%> </td>  	
										<td > <button onclick="birthchange();" class="btn btn-primary">수정</button> </td>
									</tr>
									<tr>
										<td> 연락처 </td>
										<td id="tdphone"> <%=member.getM_phone() %> </td>  	
										<td > <button onclick="phonechange();" class="btn btn-primary">수정</button> </td>
									</tr>
									<tr>
										<td> 주소 </td>
										<td id="tdAddress"> <%=member.getM_address() %> </td>  	
										<td > <button onclick="addresschange();" class="btn btn-primary">수정</button> </td>
									</tr>
									<tr id="trAddress" style="display: none;" >
										<td colspan="3">
											<div class = "row">
							                  <div class = "col-md-3 m-2">
							                  	<label>주소변경</label>
							                 </div>
							                  <div class = "col-md-8 text-center"> 
							                  
							                     <div  class="row">
													<div class="col-md-6"> <input type="text" name="address1" id="sample4_postcode" placeholder="우편번호" class="form-control"> </div>
													<div class="col-md-6"> <input type="button"  onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="form-control"><br> </div>
												</div>
												<div class="row">
													<div class="col-md-6"> <input type="text" name="address2" id="sample4_roadAddress" placeholder="도로명주소" class="form-control"> </div>
													<div class="col-md-6"> <input type="text" name="address3" id="sample4_jibunAddress" placeholder="지번주소" class="form-control"> </div>
												</div>
												<input type="text" id="sample4_detailAddress" name="address4" placeholder="상세주소" class="form-control">
							                     
							                  </div>
							                  <div>
							                  	<button id = "addresschangebtn" class="btn btn-success" type="submit">주소 변경하기</button>
							                  </div>
							               </div>
						               </td>
									</tr>
									<tr>
										<td> 가입일 </td> <td colspan="2">  <%=member.getM_sdate() %> </td> 
									</tr>
								</tbody>
							</table>
							
						</div>
					</div>
					
					<div class="tab-pane fade" id="pills-memberwrite">
						<h3> 내가 쓴글 </h3>
						<div class="container">
							fd
						</div>
					</div>
					
					<div class="tab-pane fade" id="pills-memberupdate">
						<h3> 회원 수정 </h3>
						<div class="container">
							하하하하하하ㅏ하하하하하
						</div>
					</div>
			
			
					<div class="tab-pane fade" id="pills-memberdelete">
						<div class="container">
							<div class="col-md-6 offset-3">
								<h3 id="deleteresult" > 회원탈퇴 하시겠습니까?</h3>
								<form id="deleteform">
									<br>
									<input type="password" id="password"  name="password" class="form-control" placeholder="패스워드"> 
									<br>
									<input type="button" id="delete" value="탈퇴" class="form-control">
								</form>
							</div>
						</div>
					</div>
			
				</div>
				
			</div>
		</div>
	</div>
	
	<%@include file = "../footer.jsp" %>
		
</body>
</html>



