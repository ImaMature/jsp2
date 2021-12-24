package DTO;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Map;
import java.util.Vector;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

//@ 어노테이션 [ 메타데이터, 
//Chatting.jsp와 관련 있음
@ServerEndpoint("/chatting/{roomnum}") //1. 서버 소켓의 엔드포인트[경로설정](어노테이션(@) 사용)
				// "/" + "주소"/{전달 받은변수}

public class Chatting {
	
	private Integer roomnum = 0;//방 초기화
	
	//*!! 접속된 세션을 저장하는 리스트 [Arraylist vs Vector(동기화)] //동기화 지원하는 Vector사용했음
	
	//방과 접속자들을 구분해야함 [ 2개일 경우 Map이 편함 ] -> 3개 이상이면 클래스를 설계
	
	//1. 방은 Key 2. 접속자는 Value
	
	//[방 번호 : 접속자] 엔트리
	
	//Map : Key와 Value의 한 쌍으로 이루어지는 데이터의 집합. [키(set) 중복 x / 값 : 중복O]
			//Map 저장 : Map 객체명.put(키, 값)
			//Map 삭제 : Map 객체명.remove(키)
			//Map 값 호출 : map.객체명.get(키)

	//Hashtable (동기화) HashMap (비동기화)
	//동기화 지원해야 하는 이유 : 다수 클라이언트들의 요청 순서 [ 대기 ]
	//Hastable 사용 이유? Map에 접속자들을 지정하기 위해서
	
	//Key == roomnum == int / Value == loginid(접속자) == session
	private static Map<Session, Integer> clients= new Hashtable<Session,Integer>();
	
	//2. 클라이언트가 서버로부터 접속 요청
	@OnOpen		//소켓 접속하는 어노테이션
	public void onOpen(Session session, @PathParam("roomnum") int roomnum) { //path(경로)값을 통한 변수 전달
		
		this.roomnum = roomnum; //전달 받은 인수를 방 번호 변수에 저장
		clients.put(session,this.roomnum) ; //리스트에 추가 put사용!~!~!!
		//서버소켓으로 부터 클라이언트 연결요청했을때 (onOpen) map 키(방번호), 접속자(세션) 저장
		
		//System.out.println(session.getId()); //세션 번호 확인
		//System.out.println("현재 접속한 세션들 : " + clients); //현재 접속한 세션 주소값
		System.out.println(roomnum); //로그인 하고 방 선택하고 입장하면 숫자가 방 숫자가 뜨는지 확인
	}
	
	//3. 클라이언트가 서버로부터 접속 해지
	@OnClose	//소켓 닫는 어노테이션
	public void onClose(Session session) {
		clients.remove(session); //방 번호 map에서 제거(방 나가기)
	}
	
	//4. 서버가 클라이언트로부터 메시지 받는 메소드 session -> import 할때?
	//import javax.websocket.Session;import javax.websocket.server.ServerEndpoint;
	@OnMessage	//메시지 받는 어노테이션
	public void onMessage(String msg, Session session) throws IOException {
		//메시지 받을 때 인수는 뭘까요? -> 메시지, 보낸세션(회원)이요
		for(Session key : clients.keySet()) {//모든 키 가져오기
			//split으로 나누기
			if(clients.get(key) == Integer.parseInt(msg.split(",")[0])) { //해당 키 외 값이 방번호이면
				System.out.println(key);
				//모든 리스트에 저장된[접속된] 세션으로부터 메시지를 보내기
				if(!key.equals(session)) {
					//본인을 제외한 모든 사람에게 메시지 보내기
					key.getBasicRemote().sendText(msg); //예외처리
				}
			}
		}
	}
	
	//있으니까 에러만 뜸
	/*
	 * //5. 서버가 클라잉언트로부터 오류
	 * 
	 * @OnError //클라이언트 오류 어노테이션 public void onError(Session session) {
	 * 
	 * }
	 */
}
