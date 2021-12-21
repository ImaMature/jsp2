<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.URL"%>

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
	
	<div class="container">
		<table class="table">
		<%
			//1. 요청 url 가져오기
			try{
				URL url = new URL("https://api.odcloud.kr/api/15077586/v1/centers?page=1&perPage=300&serviceKey=hm1u3zRV0ba96YTa5BqV4zu0jYFV2LGfPe2aRk0NyJVQsoX5FCSjuVth8RKvBvQzOW8ApIHwaxmajW9%2FRaYR5A%3D%3D");
				
				//2. 스트림 버퍼를 통한 URL 내 HTML 읽어오기
				BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				//BufferedReader : 외부 [이클립스 외] 입출력 버퍼 [ 통신데이터 저장소 ]
							//InputStreamReader : 입출력 스트림
								//url.openStream() : 바이트 단위로 url 내용 읽기
				
				//3. 읽어온 내용 문자열에 담기
				String result = bf.readLine();
								//readLine() : 모든 줄 한번에 읽어오기
				//System.out.println("url내 문서 스트림 이용한 읽어오기 : " + result);
								
				//4. 읽어온 내용을 json으로 파싱하기
				JSONParser jsonParser = new JSONParser();
				//JSONParser : json데이터 넣어서 파싱 
				JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
				//JSONObject로 형변환
				//System.out.println("url내용을 json으로 형변환 : " +jsonObject);
				
				//5. array에 담기
				JSONArray vaccineArray = (JSONArray)jsonObject.get("data");
				//data라는 키 요청해서 리스트에 담기
				//System.out.println("vaccineArray : " +vaccineArray);
				
				//6. 반복문으로 키를 하나씩 빼오기%>
				<thead class="thead-dark">
					<tr>
						<th>시설이름</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>지역센터이름</th>
					</tr>				
				</thead>
		<%		for(int i =0; i<vaccineArray.size(); i++){
					JSONObject contents = (JSONObject) vaccineArray.get(i);
					//System.out.println("contents : " +contents);
		%>
				<tbody>
					<tr>
						<td><%=contents.get("facilityName") %></td>
						<td><%=contents.get("address") %></td>
						<td><%=contents.get("phoneNumber") %></td>
						<td><%=contents.get("centerName") %></td>
					</tr>
				</tbody>
				
		<%		}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
		%>
		</table>
	</div>
</body>
</html>