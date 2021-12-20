package DTO;

public class Member {
	
	private int m_num;
	private String m_id;
	private String m_password;
	private String m_passwordconfirm;
	private String m_name;
	private String m_birth;
	private String m_sex;
	private String m_phone;
	private String m_address;
	private int m_point;
	private String m_sdate;
	
	
	//빈 생성자
	public Member() {
		// TODO Auto-generated constructor stub
	}
	
	//풀 생성자
	public Member(int m_num, String m_id, String m_password, String m_passwordconfirm, String m_name, String m_birth,
			String m_sex, String m_phone, String m_address, int m_point, String m_sdate) {
		this.m_num = m_num;
		this.m_id = m_id;
		this.m_password = m_password;
		this.m_passwordconfirm = m_passwordconfirm;
		this.m_name = m_name;
		this.m_birth = m_birth;
		this.m_sex = m_sex;
		this.m_phone = m_phone;
		this.m_address = m_address;
		this.m_point = m_point;
		this.m_sdate = m_sdate;
	}
	
	//회원 가입 생성자 (포인트와 회원 넘버가 필요 X / 회원넘버 -> DB오토)
	public Member(String m_id, String m_password, String m_name, String m_birth, String m_sex,
			String m_phone, String m_address) {
		super();
		this.m_id = m_id;
		this.m_password = m_password;
		this.m_name = m_name;
		this.m_birth = m_birth;
		this.m_sex = m_sex;
		this.m_phone = m_phone;
		this.m_address = m_address;
	}
	
	//m_id, m_name, m_birth, m_sex, m_phone, m_address, m_point
	//회원 수정
	public Member(String m_id, String m_name, String m_birth, String m_sex, String m_phone, String m_address,
			int m_point) {
		super();
		this.m_id = m_id;
		this.m_name = m_name;
		this.m_birth = m_birth;
		this.m_sex = m_sex;
		this.m_phone = m_phone;
		this.m_address = m_address;
		this.m_point = m_point;
	}
	
	
	//로그인 생성자
	public Member(String m_id, String m_password) {
		super();
		this.m_id = m_id;
		this.m_password = m_password;
	}
	
	//회원 검색
	public Member(int m_num, String m_id,  String m_password, String m_name, String m_birth,
			String m_sex, String m_phone, String m_address, int m_point, String m_sdate) {
		super();
		this.m_num = m_num;
		this.m_id = m_id;
		
		this.m_password = m_password;
		this.m_name = m_name;
		this.m_birth = m_birth;
		this.m_sex = m_sex;
		this.m_phone = m_phone;
		this.m_address = m_address;
		this.m_point = m_point;
		this.m_sdate = m_sdate;
	}
	


	//getter setter
	public int getM_num() {
		return m_num;
	}


	public void setM_num(int m_num) {
		this.m_num = m_num;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_password() {
		return m_password;
	}

	public void setM_password(String m_password) {
		this.m_password = m_password;
	}

	public String getM_passwordconfirm() {
		return m_passwordconfirm;
	}

	public void setM_passwordconfirm(String m_passwordconfirm) {
		this.m_passwordconfirm = m_passwordconfirm;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_birth() {
		return m_birth;
	}

	public void setM_birth(String m_birth) {
		this.m_birth = m_birth;
	}

	public String getM_sex() {
		return m_sex;
	}

	public void setM_sex(String m_sex) {
		this.m_sex = m_sex;
	}

	public String getM_phone() {
		return m_phone;
	}

	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}

	public String getM_address() {
		return m_address;
	}

	public void setM_address(String m_address) {
		this.m_address = m_address;
	}

	public int getM_point() {
		return m_point;
	}

	public void setM_point(int m_point) {
		this.m_point = m_point;
	}

	public String getM_sdate() {
		return m_sdate;
	}

	public void setM_sdate(String m_sdate) {
		this.m_sdate = m_sdate;
	}
	
	
	
	
	
	
}
