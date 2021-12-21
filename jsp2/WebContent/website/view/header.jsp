<%@page import="DAO.ProductDao"%>
<%@page import="DTO.Login"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<!-- 부트스트랩 설정 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" >
	<!-- 본인 css 설정 -->
	<link rel="stylesheet" href="/jsp2/website/css/main.css?=v3">
</head>
<body>
	<!-- 부트스트랩 jQuery -->
	<!-- jQuery가 있어야 ajax실행 가능 -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script> <!-- slim이 있으면 실행 안됨 -->
	
	<!-- 부트스트랩 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" ></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" ></script>
	
	
	<!-- 다음 우편 주소 API js 호출 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!-- 아임 포트(IMport) 결제 api  -->
	<!-- jQuery는 헤더에 있음 -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
	<!-- 차트 chart api 추가하기 -->
	<!-- [강사] [오후 1:21] https://www.chartjs.org/ 사이트 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	
	<!-- 카카오 지도 api (js?appkey= 에 내 자바스크립트 키 넣기) -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0e5c8f069f28a97af84bf0e74572de71"></script>
		
	
	<!-- 본인 js 호출하기 (본인꺼를 아래에 둬야 다른 api들이 먼저 작동)-->
	<script src="../../js/main.js"></script>
	
	
	<!-- 재고 차감 메소드 -->
	<% ProductDao.getproductDao().stockupdate(); %>
	<%
		//로그인 컨트롤러에서 세션명 가져오기 (타입이 Login이라 강제형변환)
		Login login = (Login)session.getAttribute("login");
		
		String loginid = null;	//초기값 설정해서 연산 가능하도록 만듦
	
		//로그인이 빈 값이 아닌 경우(세션이 있을 경우)에만 실행
		if(login!=null) {
			
		//아이디 값을 loginid에 저장 이렇게 하면 다른 것들 안바꿔도 됨
			loginid = login.getM_id();
		}
	%>
	<!-- 헤더 start -->
	
	<div class = "fixed-top bg-white"> <!-- fixed top : 상단 고정, bg-white : 배경흰색 -->
		<div class = "container"> <!-- 박스권 형성 -->
			<header class = "py-3"> <!-- p : 안쪽여백 // m : 바깥여백 // y : 위아래, x: 왼쪽 오른쪽 -->
				<div class = "row"> <!-- 가로배치 -->
					<div class = "col-md-4 offset-4 text-center"> <!-- 로고 [웹사이트명] / offset-숫자 : 숫자만큼 건너뛰기--> 
						<a href="/jsp2/website/view/main.jsp" class="header_logo"> Ferris Wheel </a>
					</div>
					<div class = "col-md-4 d-flex justify-content-end"> <!-- 상단메뉴 오른쪽으로 붙음--> 
						<ul class = "nav">
						<%
							if(loginid != null ){ // 로그인이 되어 있을 경우
								if(loginid.equals("admin")){ //로그인 되어있으면서 관리자이면
						%>
								
								<li><a href="../view/admin/dashboard.jsp" class="header_menu"> 관리자 </a></li>
						<%
								} 
						%>		
								<li><a class="header_menu"><%=loginid+"님" %></a></li>
								<li><a class="header_menu" href="/jsp2/website/view/member/memberinfo.jsp"> 회원정보 </a></li>
								<li><a class="header_menu" href="/jsp2/website/controller/logoutcontroller.jsp" > 로그아웃 </a></li>
						<%	
								}else { //로그인이 안되었을경우
						%>
								<li><a class="header_menu" href="/jsp2/website/view/member/signup.jsp"> 회원가입 </a>
								<li><a class="header_menu" href="/jsp2/website/view/member/login.jsp"> 로그인 </a>
						<%	
								}
						%>
						</ul>
					</div>
				</div>
			</header>
			<!-- 메인메뉴 -->
			<nav class="navbar navbar-expand-lg navbar-light bg-white"">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-toggle="#main_menu">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="main_menu">
					<ul class="navbar-nav col-md-12 justify-content-between" > <!-- 알아서 수직정렬하기 -->
						<li class="nav-item"><a href="#" class="nav-link">신차</a></li>
						<li class="nav-item"><a href="#" class="nav-link">베스트</a></li>
						<li class="nav-item"><a href="#" class="nav-link">브랜드별</a></li>
						<li class="nav-item"><a href="#" class="nav-link">국산차</a></li>
						<li class="nav-item"><a href="#" class="nav-link">수입차</a></li>
						<li class="nav-item"><a href="#" class="nav-link">이벤트</a></li>
						<li class="nav-item"><a href="/jsp2/website/view/product/productcart.jsp" class="nav-link">장바구니</a></li>
						<li class="nav-item"><a href="/jsp2/website/view/board/boardlist.jsp" class="nav-link">고객센터</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
	
	<!-- 헤더 end -->
	
	

	
		
	 

	
	
</body>
</html>