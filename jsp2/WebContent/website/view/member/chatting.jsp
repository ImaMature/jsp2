<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../header.jsp" %>
	<h3 class="text-center">실시간 채팅</h3>
	<div class="container">
		<div class="row">
			<button class="inchat form-control col-md-3 mr-3 offset-3" onclick="start('<%=loginid%>');">채팅방 들어가기</button>
			<button class="outchat form-control col-md-3" onclick="exit();">채팅방 나가기</button>
		</div>
		
		<!-- 채팅방 만들기-->
		<div id ="roomnum"></div>
		<ul style="list-style-type: none;">
			<li><button class="form-control" onclick="roomselect(1)">채팅방1</button></li>
			<li><button class="form-control" onclick="roomselect(2)">채팅방2</button></li>
			<li><button class="form-control" onclick="roomselect(3)">채팅방3</button></li>  
		</ul>	
		<div class="row" style="display:none;" id="chattingDiv"> <!-- div는 기본적으로 block -->
			<div class="col-md-6 px-1 offset-3">
				<!-- 채팅창 -->
				<div id="msgbox">  
				 	
				
				</div> 
				<div class="row no-gutters">	<!-- 채팅 입력 창, 버튼 -->
					<div class="col-md-2">
						<input id="toid" type="text" class="form-control" placeholder="공개"> <!-- 특정 사람 아이디로 귓말 보내는거 -->
					</div>
					<div class="col-md-8"> <!-- 채팅입력창 -->
						<input id="msginput" class="form-control" type="text" placeholder="내용입력" onkeyup="entersend();">
																							<!-- onkeyup = 키가 눌렸을때 이벤트 -->
																			<!-- 이거 하면 send메소드가 계속 실행됨 그래서 다른 조치를 취해야함 -->
					</div>
					<div class="col-md-2"> <!-- 버튼 -->
						<button class="form-control" onclick="btnsend();">전송</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 채팅 프론트 끝 -->
	
	<script type="text/javascript">
		//jsp는 예외처리가 다 만들어져 있어서 입출력할때 예외 처리 딱히 할필요 없음	
		
		/* //1. 입력창에 입력된 데이터를 가져온다.
		var msginput = document.getElementById("msginput").value;
		//값 끌고 오는지 확인
		//alert(msginput); */
		//alert(loginid);
		
		
		//채팅 입장 버튼 퇴장버튼 추가되면서 내용이 바뀜
		/* 전역변수들 : 모든 function 에서 사용되는 변수들 !!!!초기화가 필수 */
		// 로그인된아이디 // 메시지창 // 웹소켓 
		var loginid = null;  var msgbox =  null; var webSocket = null;
		
		// 채팅방 번호
		var roomnum = 0;
		
		//10. 채팅방 입장하기
		function roomselect(num) {
			alert(num+"번째 방 선택했습니다.")	
			roomnum = num; //클릭한 인수를 방번호에 대입
			document.getElementById("roomnum").innerHTML="접속된 방 : "+roomnum; //id roomnum인 div 안에 몇번 방 입장인지 출력 확인차 넣어놓기
		}
		
		//메소드 시작시 로그인된 아이디값을 인수로 받아옴
		function start(id) {
		
		//로그인 안되어있을때
		if(id == null) {
			alert("로그인 후 입장가능합니다.");
			return;
		}else{
				alert("로그인완료")
				
				roomnum = document.getElementById("roomnum").innerHTML;
				
				//css를 기본 div 설정으로 변경 ( 로그인시 채팅창 보이게 하기 )
				document.getElementById("chattingDiv").style="display:block";
				
				//2. 현재 회원 아이디 가져오기
				//var loginid = document.getElementById("loginid").value; //value속성이 있는 태그만(div제외) 값 이렇게 가져올 수 있음
				loginid = id; //위에서 인수로 받아와서 getEById어쩌구 안써도 됨
				
				//3. 채팅창 가져오기
				//var msgbox = document.getElementById("msgbox");
				msgbox = document.getElementById("msgbox");
				
				//4. 웹소켓 : var webSocket = new WebSocket("ws://웹ip:http 포트번호/프로젝트명/경로"); //웹 ip : localhost
				//접속 객체
				//자바 명령어는 jsp2/dto/chatting.java로 이동(그곳이 엔드포인트(@ServerEndpoint임)
				webSocket = new WebSocket("ws://localhost:8085/jsp2/chatting/"+roomnum);
														//경로(path)에 마지막에 '/'를 넣으면 변수 전달 가능 js변수 전달 방법
				
				//5. 웹소켓 메소드 (평션 값 따로 없이 그냥 이벤트) 각자 어노테이션을 찾아감 (위치는 dto/Chatting.java)
						//현재 접속한 세션 주소값이 자동으로 event로 넘어감
				webSocket.onopen = function(event) {onOpen(event)}; //웹소켓 실행시 메소드
				webSocket.onClose = function(event) {onClose(event)}; //웹소켓 종료시 메소드
				webSocket.onmessage = function(event) {onMessage(event)}; //웹소켓 메시지 전송 메소드
				webSocket.onerror = function(event) {onError(event)}; //웹소켓 에러 발생시 메소드
				
			}
		}
		
		//나가기
		function exit() {
			document.getElementById("chattingDiv").style="display:none"; //css변경
			WebSocket.close();
		}
		
		
		//6. 이벤트 메소드 정의
		function onOpen(event) {
			alert("접속되었습니다.");
		}
		
		function onClose(event) {
			alert("퇴장했습니다.");
		}
		
		/* function onMessage(event) {
			alert("메시지가 도착했습니다.");
		} */
		
		function onError(event) {
			alert("오류가 발생했습니다. 사유"+event.data+" [관리자에게 문의]");
		}
		
		
		//8. 받는 메소드
		function onMessage(event) {
			//alert("메시지가 왔습니다." + event.data); //메시지 받는지 확인하기
			var roomnum = event.data.split(",")[0];//쉼표를 기준으로 문자열 분리해서 첫번째 문자열		//로그인 아이디[0] , 받는 사람[1], 시간[2], 입력한 메시지[3] -> vvar msg = loginid + "," + toid + "," + time + "," + msginput ;
			var from = event.data.split(",")[1]; 
			var to = event.data.split(",")[2];	//쉼표를 기준으로 문자열 분리해서 두번째 문자열
			var time = event.data.split(",")[3]; //쉼표를 기준으로 문자열 분리해서 세번째 문자열
			var msg = event.data.split(",")[4]; //쉼표를 기준으로 문자열 분리해서 네번째 문자열
			
			//현재 로그인된 아이디와 to와 동일할 경우
			if( to == loginid ){ // 특정 아이디만 받기
				alert("로그인된 아이디와 from 동일할 경우 : " + event.data);
				msgbox.innerHTML += "<div class='profile'>"+from+"</div>";
				msgbox.innerHTML += "<div class='d-flex justify-content-start mx-2 my-2'><span class='to mx-1'>"+msg+"</span><span class='msgtime d-flex align-items-end'>"+time+"</span></div>";
				msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치 = 스크롤 전체 높이, 현 스크롤의 위치를 바닥에 둠
				
			}else if(to == "all"){// 공개 메시지 [ 모든 사람이 받는 메시지 ]
				alert("공개메시지 : " + event.data);
				msgbox.innerHTML += "<div class='profile'>"+from+"</div>";
				msgbox.innerHTML += "<div class='d-flex justify-content-start mx-2 my-2'><span class='to mx-1'>"+msg+"</span><span class='msgtime d-flex align-items-end'>"+time+"</span></div>";
				msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치 = 스크롤 전체 높이, 현 스크롤의 위치를 바닥에 둠
			}
		}
		/*이벤트 메소드 정의 끝*/
		
		
		//7. 버튼 클릭시 보내는 메소드
		function btnsend() {
			
			//1. 입력창에 입력된 데이터를 가져온다.
			var msginput = document.getElementById("msginput").value;
			//2.값 끌고 오는지 확인
			//alert(msginput);
			
				//공백 막기 입력이 없을때 유효성 검사 [ 전송 막기 ]
				if(msginput == "") {return;} 
			
			//3.입력된 문자와 날짜를 채팅별 div에 추가
			let today = new Date(); //js에서 현재 날짜/시간 객체
			var time = today.toLocaleTimeString(); //시간만 가져오기
			
			//8. 받는 사람에게 귓말 보내기 위해 아이디 값 받아오고 설정하기
			var toid = document.getElementById("toid").value;
			
			if(toid == ""){//귓속말할 아이디가 공백이면 
				toid="all"; //모두에게 보내기
			}
			//방번호 추가
			roomnum = document.getElementById("roomnum").innerHTML;
			
			//4.누가 보냈는지 메시지에 포함하기(방번호, 로그인 아이디(보내는 사람), 받는 사람, 시간, 입력한 메시지)
			var msg = roomnum + "," + loginid + "," + toid + "," + time + "," + msginput ;
			alert(msg);
			 
			//전체 -> 큰따옴표 / class -> 작은따옴표
			//5. 입력된 문자 와 날짜를 채팅방 div 에 추가
			msgbox.innerHTML += "<div class='d-flex justify-content-end mx-2 my-2'>	<span class='msgtime d-flex align-items-end'>"+time+"</span><span class='from mx-1'>"+msginput+"</span>	</div>"		
			
			webSocket.send(msg); //!!!중요 그자체 서버로 입력한 메시지 전송 
			//msg의 내용(메시지 내용, 보낸 사람 아이디)이 onMessage로 이동하는거임(만들어진 메소드임)
			
			//7. 전송 후 입력한 내용을 지우기 [초기화]
			document.getElementById("msginput").value = "";
			
			//6. 스크롤이 있을 경우 스크롤 위치를 가장 아래로 이동
				//채팅창(박스권)의 스크롤 윗부분의 위치 =  채팅창(박스권)의 스크롤의 전체 높이 (스크롤을 높이만큼 내림)
			msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치를 바닥에 둠 //css에서 스크롤 바 숨기기 해놓음
			
		}/*버튼 클릭시 보내는 메소드 끝*/
		
	
		
		//9. 엔터 쳤을 때 보내는 메소드
		function entersend() {
			
			//10. 엔터를 눌렀을 때 (!!!!!아스키코드 이용, enter가 13)
			if(window.event.keyCode == 13){
				alert("엔터 눌렀엉");
			
			//1. 입력창에 입력된 데이터를 가져온다.
			var msginput = document.getElementById("msginput").value;
			//2.값 끌고 오는지 확인
			//alert(msginput);
			
			//공백 막기
			if(msginput == "") {return;}
			
			//시간 객체
			let today = new Date(); 
			var time = today.toLocaleTimeString(); 
			
			var toid = document.getElementById("toid").value;
			if(toid == ""){//귓속말할 아이디가 공백이면 
				toid="all"; //모두에게 보내기
			}
			//방번호 추가
			roomnum = document.getElementById("roomnum").innerHTML;
			
			//4.누가 보냈는지 메시지에 포함하기(로그인 아이디, 시간, 입력한 메시지)
			var msg = roomnum + "," + loginid + "," + toid + "," + time + "," + msginput ;
			alert(msg);
			 
			//채팅창에 채팅 넣기
			msgbox.innerHTML += "<div class='d-flex justify-content-end mx-2 my-2'>	<span class='msgtime d-flex align-items-end'>"+time+"</span><span class='from mx-1'>"+msginput+"</span>	</div>"		
			
			//메시지 보내기
			webSocket.send(msg); 
			//초기화
			document.getElementById("msginput").value = "";
			
			//6. 스크롤이 있을 경우 스크롤 위치를 가장 아래로 이동
			msgbox.scrollTop = msgbox.scrollHeight;
			}//엔터를 눌렀을 때 포함
		}
		
		
		
	</script>
</body>
</html>