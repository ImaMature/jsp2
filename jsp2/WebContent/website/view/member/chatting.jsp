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
		<!-- 채팅방 만들기-->  <!-- 로그인 성공시 해당 id로 숨기기 -->
		<div class="row my-3" id="startdiv">
			<button class="form-control col-md-3" onclick="start('<%=loginid%>', 1);">채팅방1</button> 
			<button class="form-control col-md-3" onclick="start('<%=loginid%>', 2);">채팅방2</button>
			<button class="form-control col-md-3" onclick="start('<%=loginid%>', 3);">채팅방3</button>
			<button class="form-control col-md-3" onclick="start('<%=loginid%>', 4);">채팅방4</button>
		</div>
		
		<div class="row col-md-6 offset-5 y-3">
			<input type="hidden" id="roomnum"> <!-- 스크립트에다가 변수 만들기 -->
			<!-- 나가기 버튼 -->
			<button class="outchat form-control col-md-4 offfset-4" onclick="exit();" id="btnexit" style="display: none;">채팅방 나가기</button>
		</div>	
		
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
						<input id="msginput" class="form-control" type="text" placeholder="내용입력">
																							<!-- onkeyup = 키가 눌렸을때 이벤트 -->
																			<!-- 이거 하면 send메소드가 계속 실행됨 그래서 다른 조치를 취해야함 -->
					</div>
					<div class="col-md-2"> <!-- 버튼 -->
						<button class="form-control" onclick="send();">전송</button>
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
		
		//채팅방 접속 버튼을 눌렀을 때[인수는 로그인아이디, 채팅방번호]
		function start(id, num) {
		
		if(id == "null") {//로그인 안되어있을때 //큰따옴표 붙여주기 
			alert("로그인 후 입장가능합니다."); //접속 불가
			return;
		}else{ //로그인이 되어있을때
				//alert(id);
				//alert("로그인완료")
				
				//1. 숨기고 보이기
					//css를 기본 div 설정으로 변경 ( 로그인시 채팅창, 방정보(방넘버, 나가기버튼) 보이고, 채팅방선택버튼 숨기기 )
				document.getElementById("chattingDiv").style="display:block"; 	//채팅창 보이기
				document.getElementById("startdiv").style="display:none";		//채팅방 목록 숨기기
				document.getElementById("btnexit").style="display:block";		//채팅방 나가기 버튼 누르기
				//2. 현재 회원 아이디 가져오기
					//var loginid = document.getElementById("loginid").value; //value속성이 있는 태그만(div제외) 값 이렇게 가져올 수 있음
				loginid = id; //위에서 인수로 받아와서 getEById어쩌구 안써도 됨
				
				//3. 채팅창 가져오기
					//var msgbox = document.getElementById("msgbox");
				msgbox = document.getElementById("msgbox");
				msgbox.innerHTML += "<div class='text-center roomstart'>"+ num +"번째 방 입장</div>"; //채팅방 입장 내용을 채팅창에 추가
				roomnum = num; //방번호 인수를 방번호 변수에 저장
				//방번호 저장 스크립트 외 div에
				document.getElementById("chattingDiv").value = num;
				//4. 웹소켓 [웹 소켓 메로리 할당 [서버 소켓과 연결] 만들어져 있는 거임 만드는게 아님]
					//var webSocket = new WebSocket("ws://웹ip:http 포트번호/프로젝트명/경로"); //웹 ip : localhost
					//접속 객체
					//자바 명령어는 jsp2/dto/chatting.java로 이동(그곳이 엔드포인트(@ServerEndpoint임)
				webSocket = new WebSocket("ws://localhost:8085/jsp2/chatting/"+roomnum+"/"+loginid);
														//경로(path)에 마지막에 '/'를 넣으면 변수 전달 가능 js변수 전달 방법
				
				//5. 웹소켓 메소드 (평션 값 따로 없이 그냥 이벤트) 각자 어노테이션을 찾아감 (위치는 dto/Chatting.java)
						//현재 접속한 세션 주소값이 자동으로 event로 넘어감
				webSocket.onopen = function(event) {onOpen(event)}; //웹소켓 실행시 메소드
				webSocket.onclose = function(event) {onClose(event)}; //웹소켓 종료시 메소드
				webSocket.onmessage = function(event) {onMessage(event)}; //웹소켓 메시지 전송 메소드
				webSocket.onerror = function(event) {onError(event)}; //웹소켓 에러 발생시 메소드
				
			}
		}
		
		//방으로 가기 [1.채팅창 숨기기 2. 채팅방 초기화 3. 소켓 닫기 4. 채팅방 목록]
		function exit() {
			alert("방나가기");
			document.getElementById("chattingDiv").style="display:none"; 	//1. 채팅창 숨기기
			document.getElementById("msgbox").innerHTML=""; 				//2. 채팅창 내용 초기화
			document.getElementById("startdiv").style="display:block";		//3. 채팅창 목록 보이기
			document.getElementById("startdiv").className="row";			//4. class row 풀리는 거 다시 지정
			document.getElementById("btnexit").style="display:none"; 		//5. 나가기버튼 숨기기
			WebSocket.close();												//6. 소켓닫기
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
			//방번호 인덱스 [0]을 제외한 나머지를 받은 메시지에서 분리		//로그인 아이디[1] , 받는 사람[2], 시간[3], 입력한 메시지[4] -> vvar msg = loginid + "," + toid + "," + time + "," + msginput ;
			var from = event.data.split(",")[1]; //쉼표를 기준으로 문자열 분리해서 첫번째 문자열	
			var to = event.data.split(",")[2];	//쉼표를 기준으로 문자열 분리해서 두번째 문자열
			var time = event.data.split(",")[3]; //쉼표를 기준으로 문자열 분리해서 세번째 문자열
			var msg = event.data.split(",")[4]; //쉼표를 기준으로 문자열 분리해서 네번째 문자열
			
			//현재 로그인된 아이디와 to와 동일할 경우
			if( to == loginid ){ // 특정 아이디만 받기
				alert("로그인된 아이디와 from 동일할 경우 : " + event.data);
				msgbox.innerHTML += "<div class='profile mx-2 my-2'>"+from+"</div>";
				msgbox.innerHTML += "<div class='d-flex justify-content-start mx-2 my-2'><span class='to mx-1'>"+msg+"</span><span class='msgtime d-flex align-items-end'>"+time+"</span></div>";
				msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치 = 스크롤 전체 높이, 현 스크롤의 위치를 바닥에 둠
				
			}else if(to == "all"){// 공개 메시지 [ 모든 사람이 받는 메시지 ]
				alert("공개메시지 : " + event.data);
				msgbox.innerHTML += "<div class='profile mx-2 my-2'>"+from+"</div>";
				msgbox.innerHTML += "<div class='d-flex justify-content-start mx-2 my-2'><span class='to mx-1'>"+msg+"</span><span class='msgtime d-flex align-items-end'>"+time+"</span></div>";
				msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치 = 스크롤 전체 높이, 현 스크롤의 위치를 바닥에 둠
			}
		}
		/*이벤트 메소드 정의 끝*/
		
		
		//7. 버튼 클릭시 보내는 메소드 (엔터키눌렀을때랑 합칠거임)
		function send() {
			
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
			roomnum = document.getElementById("chattingDiv").value;
			
			//4.누가 보냈는지 메시지에 포함하기(방번호, 로그인 아이디(보내는 사람), 받는 사람, 시간, 입력한 메시지)
			var msg = roomnum + "," + loginid + "," + toid + "," + time + "," + msginput ;
			//alert(msg);
			 
			//전체 -> 큰따옴표 / class -> 작은따옴표
			//5. 입력된 문자 와 날짜를 채팅방 div 에 추가
			msgbox.innerHTML += "<div class='d-flex justify-content-end mx-2 my-2'>	<span class='msgtime d-flex align-items-end'>"+time+"</span><span class='from mx-1'>"+msginput+"</span>	</div>"		
			
			webSocket.send(msg); //!!!중요 그자체 서버로 입력한 메시지 전송 
			//msg의 내용(메시지 내용, 보낸 사람 아이디)이 onMessage로 이동하는거임(만들어진 메소드임)
			//send()메소드 -> onMessage() //onMessage()->send()
			
			//7. 전송 후 입력한 내용을 지우기 [초기화]
			document.getElementById("msginput").value = "";
			
			//6. 스크롤이 있을 경우 스크롤 위치를 가장 아래로 이동
				//채팅창(박스권)의 스크롤 윗부분의 위치 =  채팅창(박스권)의 스크롤의 전체 높이 (스크롤을 높이만큼 내림)
			msgbox.scrollTop = msgbox.scrollHeight;	//현 스크롤의 위치를 바닥에 둠 //css에서 스크롤 바 숨기기 해놓음
			
			
			
		}/*버튼 클릭시 보내는 메소드 끝*/
		
	
		
		/* //9. 엔터 쳤을 때 보내는 메소드 btnsent()랑 합쳐버림
		function entersend() {
			
			
		} */
		
		
		
	</script>
</body>
</html>