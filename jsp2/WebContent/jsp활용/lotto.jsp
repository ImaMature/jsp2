<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file = "header.jsp" %>
	<%!
		ArrayList<Integer> number = new ArrayList<>();
		int randnum [] = new int [6];
	%>
	<h3>로또 판별기</h3>
	<form action = "lotto.jsp">
		<input type="text" name="txt1" placeholder="번호입력">
		<button type="submit" name="lottobtn">쏘세요</button><br>
	</form>	
	
		<%
		if(request.getParameter("txt1")!=null){
			number.add(Integer.parseInt(request.getParameter("txt1")));
		}
		for(int i =0; i<number.size();i++){
			out.print(number.get(i) + " ");
		}
		
			for(int i =0; i<6; i++) {
				Random random =new Random();
				int num = random.nextInt(45)+1;
				
				if(num >45 || num<1) {
					i--;
				}
				boolean s = true;
				for(int j=0; j<6; j++) {
					if(num == randnum[j]){
						j--;
						s = false;
						break;
					}
				}
				if(s) randnum[i] = num;
			} 
			if(number.size()==6){
				int count=0;
				for(int i =0; i<6; i++) {
					for(int j=0; j<6; j++) {
						if( number.get(i)==randnum[j]){
							count++;
						}
					}
				}
			out.print("추첨결과 : " + count);
			}
			
				
				//중복체크와 45 이상 1미만의 숫자 입력받기가 안됩니다.
			
		%>
		
	
</body>
</html>