package test;

public class Member {

	//회원의 객체화
	//필드
	private String id;
	private String password;
	private String name;
	
	//생성자
	public Member() {} // 빈 생성자는 객체를 담을 건지 안담을 건지 차이.
	
	public Member(String id, String password, String name) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
	}

	

	public Member(String id, String password) {
		this.id = id;
		this.password = password;
	}

	//메소드
		//1. get, set 메소드
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	//메소드
		//1. getter setter
	
	
}
