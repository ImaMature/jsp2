package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {

	//1. 자주 사용하는 인터페이스 
			protected Connection con;
			protected ResultSet rs;
			protected PreparedStatement ps;
			
			//public : 모든 접근을 허용합니다. 어떠한 클래스가 접근을 하든 모두 허용됩니다.
			//default : 같은 패키지내에 접근 가능
			//protected : 상속받은 클래스 또는 같은 패키지에서만 접근이 가능합니다.
			//private : 외부에서 접근이 불가능합니다. 즉, 같은 클래스 내에서만 접근이 가능합니다.
			
			// 2. 생성자 
			public DB() {
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3307/jsp?serverTimezone=UTC" , "root","1234");
					//con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jsp?serverTimezone=UTC" , "root","dhkfeh!!12");
				}
				catch (Exception e) {System.out.println("[연동 실패]");}
			}
			
}
