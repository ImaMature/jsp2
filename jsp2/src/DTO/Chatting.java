package DTO;

import java.io.IOException;
import java.util.Vector;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

//@ 어노테이션 [ 메타데이터, 
//Chatting.jsp와 관련 있음
@ServerEndpoint("/chatting") //1. 서버 소켓의 엔드포인트[경로설정](어노테이션(@) 사용)
				// "/" + "주소"

public class Chatting {
	
	//*!! 접속된 세션을 저장하는 리스트 [Arraylist vs Vector(동기화)] //동기화 지원하는 Vector사용했음
	private static Vector<Session> clients= new Vector<Session>();
	
	//2. 클라이언트가 서버로부터 접속 요청
	@OnOpen		//소켓 접속하는 어노테이션
	public void onOpen(Session session) {
		clients.add(session); //리스트에 추가
	}
	
	//3. 클라이언트가 서버로부터 접속 해지
	@OnClose	//소켓 닫는 어노테이션
	public void onClose(Session session) {
		clients.remove(session); //리스트에서 제거
	}
	
	//4. 서버가 클라이언트로부터 메시지 받는 메소드 session -> import 할때?
	//import javax.websocket.Session;import javax.websocket.server.ServerEndpoint;
	@OnMessage	//메시지 받는 어노테이션
	public void onMessage(String msg, Session session) throws IOException {
		//메시지 받을 때 인수는 뭘까요? -> 메시지, 보낸세션(회원)이요
		for(Session client : clients) {
			//모든 리스트에 저장된[접속된] 세션으로부터 메시지를 보내기
			if(client.equals(session)) {
				//본인을 제외한 모든 사람에게 메시지 보내기
				client.getBasicRemote().sendText(msg); //예외처리
			}
		}
		
	}
	
	
	//5. 서버가 클라잉언트로부터 오류
	@OnError	//클라이언트 오류 어노테이션
	public void onError(Session session) {
		
	}
}
