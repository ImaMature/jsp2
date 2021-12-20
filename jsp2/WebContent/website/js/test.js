/**
 * 
 */

	var price = 5;	//변수 선언
	var num1 = 14;	//변수 선언
	var total = price * num1; //변수 연산
	
	//현재 문서의 html의 태그 id 가져오기 [ span을 객체로 가져오기 ]
	var elem = document.getElementById("number"); //주어진 문자열과 일치하는 id 속성을 가진 요소 찾기
	elem.textContent = total; //연산한 값을 저장해서
	//elem.textContent //해당하는 콘텐츠를 조회하거나 설정한다.
	
	var minus = price - num1;
	var plus = price + num1;
	var elem1 = document.getElementById("number1");
	
	if(price == num1) {
		elem1.textContent = minus;
	}else {
		elem1.textContent = plus;
	}
	
function start(){ // 함수 선언 [function 메소드명(){ 실행문 }]

	//배열 선언 : var 변수명 [ 요소1, 요소2, 요소3 ~~] []가 앞에 없다는 게 자바와의 차이점
		var color = ['red','white', 'black'];
		var colorName = document.getElementById("color"); //해당 id값과 일치하는 요소 찾아서 colorName에 저장
		colorName.textContent = color[0]; //color배열의 0번째 인덱스의 값을 colorName에 저장해서 설정
		colorName.style.color = color[0];
		//태그명.style.속성
		//해당하는 색으로 설정 가능
		
		var colors = color.length;
		var colorLength = document.getElementById("colors");
		colorLength.textContent = colors;
		
		document.body.style.backgroundColor = "blue";
		//배경 색 설정
}		

function start2(){
	
	var text = "";	//변수 선언 [ 자료형 없음 ] 
	var count = 1;	//변수 선언
	
	//while문
	while(count < 10) { //반복문
		text += "<li> 여기는 숫자 " + count + "</li>"; 
		// js에서 html 태그는 문자처리
		// 변수는 "" 처리불가
		count++;
	} 
	
	document.getElementById("list").innerHTML = text;
	//alert(document.getElementById("list").innerHTML);
	//알림창 띄우기
	
	//if문
	if(document.getElementById("list").innerHTML != text){
		document.getElementById("list").innerHTML = "";
	}
	
	//for문
	var text1 = "";
	for(var i = 1; i<6; i++){
		text1 += "<li> 여기는 숫자 : " + i + "</li>";
		// HTML의 list가 i만큼 생성되고 text1에 ""와 함께 String형식으로 저장된다.
	}
	document.getElementById("list1").innerHTML = text1;
	
	//for 배열
	var text2 = "";
	var phone = ["아이폰", "갤럭시폰", "모토로라폰"];
	for(var i = 0; i<phone.length; i++) {
		text2 += "<li>" + phone[i] + "</li>";
	}
	document.getElementById("list2").innerHTML = text2;
}

function cancel(){ // 공백으로 만들어버리기
	alert("지우실 건가요?")
	document.getElementById("list").innerHTML = "";
	document.getElementById("list1").innerHTML = "";
	document.getElementById("list2").innerHTML = "";
}

function start3(){
	
	// 기존 리스트 가져오기 
	var text = document.getElementById("list").innerHTML;
	var product = "콜라";	// 변수 
	text +="<li>"+product+"</li>"; // 콜라변수 추가 
	document.getElementById("list").innerHTML = text;
	
}
function start4( num1 , num2 ){	// 변수를 인수로 받음
	
	var total = num1 * num2;	// 인수 연산
	document.getElementById("result").textContent = total;
	
}
	