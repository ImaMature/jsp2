/* 다음 api 시작 */
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample4_extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
            } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
/* 다음 api 끝*/

/* 회원 탈퇴 [ajax] */

	//$(function(){실행문}); :함수
	$(function(){
		
		$("#delete").click(function(){
			//ajax : 비동기식 통신 [ 페이지 전환 없이 통신 ]
			//$.ajax({속성명:값, 속성명:값, 속성명:값})
			$.ajax({
				url: "../../controller/m_deletecontroller.jsp",
				/* url : 통신 경로 */
				data : {password:document.getElementById("deleteform").password.value},
				/* data : {변수명:.password(id가 password).값(입력한값)}*/
				success : function(result){
					
					if(result == 1 ) {
						alert("회원탈퇴 되었습니다.");
						location.href='../../controller/logoutcontroller.jsp';
					}
					else{
						
						document.getElementById("deleteresult").innerHTML = "회원정보가 다릅니다.";
					}
				}
			})
			
		}); //버튼 클릭했을 때 함수 끝
		
	}); // 전체 함수 끝
	
	
/* 회원 탈퇴 끝*/

/* 	아이디 중복체크 [ajax] */
	/*js의 ajax 비동기식 통신
	페이지 전환이 없어도 중복체크 가능
	면접 때 자주 물어봄 게시판 만드는 거 
	어떻게든 혼자 만들 줄 알아야됨 암기를 해서라도 */ 
	
	$(function() {
		
		//$("#id").click(function(){alert("제이쿼리 실행");}); //회원가입에서 id창 누르면 알림창 뜸
		//$("#id").click(function(){실행문});
		//태그의 id가 id인걸 불러오는거 
		$("#id").change(function(){
			//태그의 id가 id인걸 불러와서 새로운 기능으로 바꾼다.
		//alert("id 클릭![ajax 사용전]");
		//알림출력해보기
		
		//비동기식 : $.ajax({속성명:"값", 속성명:"값", 속성명:"값";});
			$.ajax({
				url : "idcheck.jsp",	/* 통신할 경로 페이지 */ 
				data : {userid:document.getElementById("signupform").id.value}, /* 이동할 데이터 */
				//해당페이지로 입력한 id의 값이 (userid)라는 변수로 idcheck.jsp에 전달되어서 가입하기 안눌러도(페이지전환 없이도) 통신이됨)
				
				success : function(result){//통신이 성공했을때 //결과를 실행한다.
					/*if(result == 1)  // 자바스크립트(js)의 자료형은 없다.
						{alert("1입니다.[ajax 통신후] 중복입니다.")}
					else
						{alert("0입니다.[ajax 통신전] 미중복입니다.")}*/ //이게 되면 밑에껄로 바꾸기 중복체크임
					if(result == 1) {
						document.getElementById("idresult").innerHTML = "현재 사용중인 아이디 입니다.";
												//태그명
						document.getElementById("idresult").style.color = "red";		
										
					}else{
						document.getElementById("idresult").innerHTML = "사용가능한 아이디입니다.";
						document.getElementById("idresult").style.color = "green";
					}
				} 
			});
		});
	});
	

/* 아이디 중복체크 end*/

/*1. 회원 수정 */


//이름 변경
function namechange(){ 
	alert("이름 수정하기");
	//Id가 tdname인걸 찾기
	document.getElementById("tdname").innerHTML = "<input type='text' id='name' class='form-control mb-2'> <button id='namechangebtn' class='form-control btn btn-success'>확인</button>"
										//innerHTML = > <td id="tdname"> <%=member.getM_name() %> </td>
	
	$(function() {
		$("#namechangebtn").click(function(){
			$.ajax({
				url : "../../controller/renamecontroller.jsp",
				data : {newname:document.getElementById("name").value},
											//위에 innerHTML의 id값 넣고 속성 찾아서 값을 바로 저장
				success : function(result){
					
					if(result){
						document.getElementById("tdname").innerHTML = document.getElementById("name").value;
					}else {
						alert("false입니다.");
					}
				}
			});
		});
	});													 								
}

//패스워드 변경
function passwordchange(){
	alert("패스워드 변경하기");
	document.getElementById("tdpassword").innerHTML = "<input type='password' id='pw' class='form-control mb-2'> <button id='pwchangebtn' class='form-control btn btn-success'>확인</button>"
	$(function(){
		$("#pwchangebtn").click(function(){
			$.ajax({
				url:"../../controller//renamecontroller.jsp",
				data:{newpw : document.getElementById("pw").value},
				success:function(result){
					alert(result);
				}
			})
		});
	});
}


//성별 수정하는 function함수
function sexchange(){
	alert("성별선택");
	document.getElementById("trsexradio").style.display="";
	 var sex  ;
	$('input[id="sex"]:radio').change(function () {
        sex= this.value; 
    });
	  $(function(){
	      $("#sexchangebtn").click(function(){
	         alert("클릭");
	         $.ajax({
				url: "../../controller/renamecontroller.jsp",
				data:{newsex:sex},
				success:function(result){
					alert(result);
					if(result){
						document.getElementById("tdsexradio").style.display="none";
						document.getElementById("tdsex").innerHTML = sex;
						alert("됐습니다.");
					}else{
						alert("no");
					}
				}
	         })
	      });
	   });
}
// 성별 수정하는 함수 끝				


//생년월일 수정하기
function birthchange(){
	alert("생년월일 선택");

	document.getElementById("tdbirth").innerHTML="<input type='date' id='birth'  class = 'form-control mb-2'> <button id='birthchangebtn' class='form-control btn btn-success'>확인</button>"
	
	$(function(){
		$("#birthchangebtn").click(function(){
			$.ajax({
				url:"../../controller/renamecontroller.jsp",
				data:{newbirth:document.getElementById("tdbirth").innerHTML=document.getElementById("birth").value},
				success:function(result){
					if(result){
						document.getElementById("tdbirth").innerHTML = document.getElementById("birth").value;
					}else{
						alert("잘못된 생년월일 입력입니다.");
					}
				}
			})
		});
	});
}

//연락처 수정하기
function phonechange(){
	alert("연락처 선택");
	document.getElementById("tdphone").innerHTML="<input type='text' id='phone' class = 'form-control mb-2' placeholder = '000-0000-0000'><button id='phonechangebtn' class='form-control btn btn-success'>확인</button>"
	
	$(function(){
		$("#phonechangebtn").click(function(){
			$.ajax({
				url:"../../controller/renamecontroller.jsp",
				data:{newphone:document.getElementById("tdphone").innerHTML = document.getElementById("phone").value},
				success:function(result){
					if(result){
						document.getElementById("tdphone").innerHTML = document.getElementById("phone").value;
					}else{
						alert("잘못된 연락처 입력입니다.");
					}
				}
			})
		});
	});
}

//주소 수정하기
function addresschange(){
	alert("주소 선택");
	document.getElementById("trAddress").style.display="";
	
	$(function(){
		$("#addresschangebtn").click(function(){
			$.ajax({
				url:"../../controller/renamecontroller.jsp",
				data:{newAddress:document.getElementById("tdAddress").innerHTML = document.getElementById("sample4_postcode").value+","+		
																					document.getElementById("sample4_roadAddress").value+","+
																					document.getElementById("sample4_jibunAddress").value+","+
																					document.getElementById("sample4_detailAddress").value},
				success:function(result){
					if(result){
						document.getElementById("tdAddress").innerHTML = document.getElementById("sample4_postcode").value+","+		
																					document.getElementById("sample4_roadAddress").value+","+
																					document.getElementById("sample4_jibunAddress").value+","+
																					document.getElementById("sample4_detailAddress").value;
					}else{
						alert("다시 주소를 선택해 주세요.");
					}
				}
			})
		});
	});
}

														 
/*2. 회원 수정 버튼 눌렀을 때*/									 
/* 회원 수정 end */



/*회원가입 유효성 검사 */


   function signupcheck(){
      
      // 1.폼 가져오기 [폼에 id 존재]
      //document.getElementById("signupform")
      
      // 2. 폼 내 아이디 입력 input 가져오기 (value값 빼오기)
      var id = document.getElementById("signupform").id.value; //signupform이라는 id값의 id가 id인 값을 가져와서 var id에 저장해라
      var password = document.getElementById("signupform").password.value; //signupform이라는 id값의 id가 password인 값을 가져와서 var password에 저장해라
      var passwordconfirm = document.getElementById("signupform").passwordconfirm.value;
	  var name = document.getElementById("signupform").name.value;
		var birth = document.getElementById("signupform").birth.value;
		var phone = document.getElementById("signupform").phone.value;
		var sex1 = document.getElementById("signupform").sex1.checked; //checked 유무 가져오기
		var sex2 = document.getElementById("signupform").sex2.checked;
		/*alert(birth);
		alert(sex1);
		alert(sex2);
		alert(name); 값 나오는지 확인용*/
         //alert(id);
         
      // 3. 유효성 검사 [ 정규표현식 ]
         // 정규 표현식 : 텍스트 패턴 검사
         var idj = /^[a-z0-9]{5,15}$/;      // 아이디 정규표현식 [소문자 숫자 5~15]

         var pwj = /^[A-Za-z0-9]{5,15}$/;   // 비밀번호 정규표현식 [대,소문자 숫자 5~15]

        var phonej = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; //연락처 표현식

		var namej = /^[A-Za-z0-9가-힣]{1,5}$/; //이름 정규 표현식

            /*
               /^ : 정규 표현식 시작
               $/ : 정규 표현식 끝
               [] : 문자 패턴 
                  [a - z] : 소문자만 가능
                  [A - Z] : 대문자 A-Z 만 가능
                  [0 - 9] : 숫자 0-9 만 가능
                  [가-힣] : 한글 만 가능 
               {} : 문자 개수
                  {최소길이 , 최대길이}
                  {5 , 15} : 5~12 길이만 가능
				() : 문자하나로 인식
				01([0|1|6|7|8|9]?) : 01 0,1,6,7,8,9 중 하나
					? : 문자가 있거나 혹은 자리가(하나) 있음 [? 당 문자 1개]
					* : 문자 있거나 여러개 존재
					-? : 회원가입시 "-"을 입력하도록 만들기
             */
         
	      // 아이디 
	      if( !idj.test(id) ){
	     
	        document.getElementById("idresult").innerHTML = "아이디는 소문자와 숫자 조합 5~15 사이만 가능 합니다.";
	        document.getElementById("idresult").style.color = "red";
			return false; // form submit 막기
	      }else{
	        document.getElementById("idresult").innerHTML = "사용 가능한 아이디 입니다.";
	        
	      }
	      
	      // 패스워드 [두 패스워드 동일한지 검사]
	      if(!pwj.test(password) || !pwj.test(passwordconfirm) ){
	        document.getElementById("pwresult").innerHTML = "대소문자 조합 5~15사이만 가능합니다.";
			document.getElementById("pwresult").style.color= "red";
			return false; // form submit 막기
	      }
	      else if( password != passwordconfirm ){
	        document.getElementById("pwresult").innerHTML = "패스워드가 동일하지 않습니다.";
			document.getElementById("pwresult").style.color= "red";
			return false; // form submit 막기
	      }
	      else{
	        document.getElementById("pwresult").innerHTML = "사용가능한 패스워드 입니다.";
			document.getElementById("pwresult").style.color= "green";
	      }
	      
			// 이름
			if( !namej.test(name) ){
				document.getElementById("nameresult").innerHTML="이름을 입력해주세요.[특수문자는 제외]";
				document.getElementById("nameresult").style.color= "red";
				 return false;
				
			}else{
				document.getElementById("nameresult").innerHTML="";
			}
			
	      //생년월일
			if( birth == ""){
				document.getElementById("birthresult").innerHTML="생년월일 선택해주세요"; 
				document.getElementById("birthresult").style.color= "red";
				return false;
			}else{
				document.getElementById("birthresult").innerHTML="";
			}
	      
	      // 성별
			if( !sex1 && !sex2 ){  // 둘다 false 이면 // 둘다 체크를 안했으면
				document.getElementById("sexresult").innerHTML="성별을 선택해주세요";
				document.getElementById("sexresult").style.color= "red";
				 return false;
			}else{
				document.getElementById("sexresult").innerHTML="";
			}
			// 전화번호 
			if( !phonej.test( phone ) ){
				document.getElementById("phoneresult").innerHTML="전화번호 형식으로 입력해주세요.";
				document.getElementById("phoneresult").style.color= "red";
				 return false;
			}else{
				document.getElementById("phoneresult").innerHTML="가능한 전화번호입니다";
				document.getElementById("phoneresult").style.color= "green";
			}
   }
   
   
   
/*회원가입 유효성 검사 end */

/*제품 상태 변경 start */
//dashboard.jsp(관리자페이지)에서 넘어옴
function activeupdate(p_num){
	
	if(confirm("제품의 상태를 변경하시겠습니까?") == true){
		//alert(p_num); //넘어오는지 확인하기
		
		//동기식 (서버가 꺼지면 삭제되어서 조심해야됨)
		//location.href('../../controller/productdeletecontroller.jsp?p_num='+p_num);
		
		//비동기식
			//ajax 통신으로 상태를 다음 상태로 변경
			//$(function(){실행문}); : jquery
			
		$(function(){
			//alert(p_num);  //넘어오는지 확인하기
			$.ajax({
					
				url:"../../controller/productA_updatecontroller.jsp",
				data:{p_num : p_num}, //get방식하고 같음 {변수명 : 인수1, 인수2, 인수3} or {변수1 : 인수1, 변수2:인수2}
											//url로 넘어감
				success : function(result){
					if(result == 1){ //js는 자료형이 없다.
						
						//현재 페이지 초기화 = html refresh하기
						location.reload();
						alert("상태 변경 완료");
					}else{
						alert("상태 변경 실패[관리자에게 문의]");
					}
				}
			})
		});
	}else{
		
	}
}

/*제품 상태 변경 end */


/*제품 수량 변경 시작 */
//productview에서 수량 변경할때 onclick=pchange으로 인수(type, <%=product.getP_stock()%>, <%=product.getP_price()%>) 받아옴
							//타입 재고 가격 
//자료형이 없어서 그냥 인수만 입력
function pchange(type, stock, price){
	//alert(type) 확인용도
	
	
	//현재 수량 가져오기						//문자열 숫자열로 바꾸기 (값(문자열)에 *1하기)
	var pcount = document.getElementById("pcount").value*1;
	
	//-를 눌렀을때
	if(type=='m'){
		pcount -= 1;	//현재 수량 -1
		if(pcount < 1){		//만약에 1보다 작아지면 
			alert("수량은 1개 이상만 가능합니다.")	//메시지 출력
			pcount=1; 	//1로 설정
		}	
		
	//+를 눌렀을때	
	}else if(type=='p'){
		pcount += 1;		//현재 수량 +1
		if(pcount>stock){	//만약에 재고보다 커지면 
			alert("해당 상품의 재고가 없습니다.")	//메시지
			pcount=stock; 	//최대재고량으로 설정
		}
	//입력에 직접 수량을 입력해서 변경하려 했을 때
	}else{
		pcount += 0;
		if(pcount>stock){	//만약에 재고보다 커지면 
			alert("해당 상품의 재고가 없습니다.")	//메시지
			pcount = stock;	//최대재고량으로 설정
		}
		if(pcount < 1){		//만약에 1보다 작아지면 
			alert("수량은 1개 이상만 가능합니다.")	//메시지 출력
			pcount = 1; 	//1로 설정
		}	
	}
	//변경된 값으로 다시 세팅 		//.value속성태그 [ 입력상자 ]
	document.getElementById("pcount").value = pcount;	

	//천단위 쉼표 만들기
	//totalprie = 총가격 (제품수 * 제품가격)
	var totalprice = pcount*price;
	
	//총 가격 정규표현식 만들기
			//가격표시	(현재수량 * 가격)	//.innerHTML 속성 태그 [ div ]	
	document.getElementById("total").innerHTML = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
													//총가격.toString() : 문자열 변환
														//.replace(기존문자, 새로운 문자);
															//정규 표현식 [문자 패턴 찾기] : /\B(?=(\d{3})+(?!\d))/g, ','
																//1. / : 시작
																//2. \b : 시작, 끝 문자 [ 예 : 1234일 경우 1, 4]
																//3. {3} : 문자 길이 [ 예 : {3} -> 3글자 / 예2 : \d{3} -> 정수 3글자] 
																//4. \d : 정수(숫자)
																//5. !\d : 뒤에 숫자가 없는 경우
																//6. /g : 전역 검색
}

/*제품 수량 변경 끝*/


/* 찜하기 시작 */
function plike(p_num, m_num){
	//alert("버튼눌림")
	//alert(p_num);
	//alert(m_num);
	if(m_num==0){
		alert("로그인 후 찜하기를 할 수 있습니다.");
		return;
	}
	
	//비동기식 통신용
	$(function(){
		$.ajax({
			url : "../../controller/p_likecontroller.jsp",
			data:{p_num : p_num, m_num : m_num }, //인수 담아서 넘기기
			
			//p_likecontroller.jsp 에서 out.print로 넘어온 값 result에 저장
			success:function(result){
				if(result == 1){
					//alert(result);
					document.getElementById("btnPlike").innerHTML="찜하기♡";
				}else if(result==2){
					//alert(result);
					document.getElementById("btnPlike").innerHTML="찜하기♥";
				}
			}
		})
	});
}

/*찜하기 끝*/


/* 장바구니 시작 */

function cartadd(){
	//alert("클릭");
	//jQuery를 이용한 값 가져오기
		//1. id속성 이용
		/*var p_num2 = $("#p_num").val(); alert("id속성 이용 : " + p_num2);
		
		//2. class 속성 이용한 값 가져오기
		var p_num3 = $(".p_num").val(); alert("class속성 이용 : " + p_num3);
		
		//3. name 이용한 값 가져오기
		var p_num4 = $("input[name=p_num]").val(); alert("name속성 이용 : " + p_num4);

	//자바스크립트(js)를 통한 값 가져오기
		//1.id속성 이용
		var p_num = document.getElementById("p_num").value; 			alert("js_id속성 : " + p_num);
		
		//2. class 속성 이용 	//class 속성 중복 허용하기 때문에 배열 이용
		var p_num5 = document.getElementsByClassName("p_num")[0].value;	alert("js_class속성 : " + p_num5);
		
		//3.name속성 이용		//name 속성 중복 허용하기 때문에 배열 이용
		var p_num6 = document.getElementsByName("p_num")[0].value;		alert("js_name속성 : " + p_num6);*/
		//--------------------------------------------------------------------------------------------------
		var p_num = document.getElementById("p_num").value; 		//alert("p_num : " + p_num);
		var p_size = document.getElementById("p_size").value; 		//alert("p_size : " + p_size);
		//alert(p_size);
			if(p_size == '옵션 선택'){
				alert("옵션 선택해 주세용"); return;
			}
		var p_count = document.getElementById("pcount").value; 		//alert("p_count : " + p_count);
		
		//컨트롤러 페이지 이동 방법2개
			//1.하이퍼링크 [ 인수 같이 넘기기 ]
			//location.href="../../controller/p_cartcontroller.jsp?p_num="+p_num+"&p_size="+p_size+"&p_count="+p_count;
			
			//2. ajax 이용
			$.ajax({ //페이지 전환이 없음 [ 해당 페이지와 통신 ]
				url : "../../controller/p_cartcontroller.jsp",
				data : {p_num:p_num, p_size:p_size, p_count:p_count},
				success : function(result){
					if(confirm("장바구니에 담았습니다. [ 장바구니로 이동할까요? ]") == true){
						location.href="productcart.jsp";
					}
				}
			});
}

/* 장바구니 끝 */

/* 장바구니 삭제 start*/
function cartdelete(type, p_num, p_size){
	//alert("삭제?")
	//js<-->jsp클래스 호환 X
	$.ajax({ //페이지 전환이 없음 [ 해당 페이지와 통신 ]
	
		url : "../../controller/p_cartdeletecontroller.jsp",
									//필요없는 값 -1로 두기
		data : {type:type, p_num:p_num, p_size:p_size, i:-1, p_count:-1},
		success : function(result){
			if(result){
				location.reload(); //현재 페이지 새로고침
			}
		}
	});
}

/* 장바구니 삭제 end */

/* 장바구니 수량 변경 start */
function pchange2(i, type, stock, price){
	//alert(i);		
	
	//1. productcart.jsp에서 id가 pcount인 친구랑 i같이 가져온거임	
	//2. 문자열 취급이기 때문에 숫자 취급하도록 바꿔주기 위해 *1(js는 자신이 임의대로 문자인지 숫자인지 취급함 그렇기 때문에 *1)					
	//3. 가져온 값 p_count 에 저장		
	var p_count = document.getElementById("pcount"+i).value*1;
	//alert(p_count);
	
	//-를 눌렀을때
	if(type=='m'){
		p_count -= 1;	//현재 수량 -1
		if(p_count < 1){		//만약에 1보다 작아지면 
			alert("수량은 1개 이상만 가능합니다.")	//메시지 출력
			p_count=1; 	//1로 설정
		}	
		
	//+를 눌렀을때	
	}else if(type=='p'){
		p_count += 1;		//현재 수량 +1
		if(p_count>stock){	//만약에 재고보다 커지면 
			alert("해당 상품의 재고가 없습니다.")	//메시지
			p_count=stock; 	//최대재고량으로 설정
		}
	//입력에 직접 수량을 입력해서 변경하려 했을 때
	}else{
		p_count += 0;
		if(p_count>stock){	//만약에 재고보다 커지면 
			alert("해당 상품의 재고가 없습니다.")	//메시지
			p_count = stock;	//최대재고량으로 설정
		}
		if(p_count < 1){		//만약에 1보다 작아지면 
			alert("수량은 1개 이상만 가능합니다.")	//메시지 출력
			p_count = 1; 	//1로 설정
		}	
	}
	//변경된 값으로 다시 세팅 		//.value속성태그 [ 입력상자 ]
	document.getElementById("pcount"+i).value = p_count;	

	//천단위 쉼표 만들기
	//totalprie = 총가격 (제품수 * 제품가격)
	var totalprice = p_count*price;
	
	//총 가격 정규표현식 만들기
			//가격표시	(현재수량 * 가격)	//.innerHTML 속성 태그 [ div ]	
	document.getElementById("total"+i).innerHTML = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
													//총가격.toString() : 문자열 변환
														//.replace(기존문자, 새로운 문자);
															
	$.ajax({ //페이지 전환이 없음 [ 해당 페이지와 통신 ]
	
		url : "../../controller/p_cartdeletecontroller.jsp",
									//i값이 추가 i번째 장바구니를 업데이트하는 것
									//사이즈나 제품 넘버를 변경하는게 아니기 때문에 필요없어서 임의의값 -1으로 만들기 -1=없다라는 뜻
		data : {type:type, p_num:-1, p_size:-1, i:i, p_count : p_count},
		success : function(result){
			
			if(result){
				location.reload(); //현재 페이지 새로고침
			}
		}
	});														
}
 
/* 장바구니 수량 변경 end */


/* 결제 api 이용하기 start https://docs.iamport.kr/implementation/payment 참조하기*/
function payment(){
	
	if(document.getElementById("payselect").innerHTML==""){
		alert("결제방식을 선택해주세요.");
		return;
	}
	
	var IMP = window.IMP;
	//관리자 식별코드[본인 관리자 계정으로 사용, 관리자 계정마다 다름]
	IMP.init("imp04043805"); //아임포트 로그인 후 콘솔모드에서 관리자페이지에서 imp코드 복붙
	
	IMP.request_pay({														// 결제 요청 변수
          pg: "html5_inicis",												// pg사 [ 아임포트 관리자페이지에서 선택한 pg사 ]
          pay_method: document.getElementById("payselect").innerHTML,		// 결제 방식
          merchant_uid: "ORD20180131-0000011",								// 주문번호
          name: "ck",														// 결제창에 나오는 결제 상품의 이름
          amount: document.getElementById("totalpay").innerHTML,			// 결제 금액 //span, div는 value가 없으니까 innerHTML사용
          buyer_email: "gildong@gmail.com",
          buyer_name: $("#name").val(),										// 주문자 이름 //밑에 체크박스에서 가져옴
          buyer_tel: $("#phone").val(),										// 주문자 전화번호
          buyer_addr: $("#sample4_roadAddress").val()+","+					// 주문자 주소
          $("#sample4_jibunAddress").val()+","+$("#sample4_detailAddress").val(),
          buyer_postcode: $("#sample4_postcode").val()						// 주문자 우편번호			

      }, function (rsp) { // callback
          if (rsp.success) {
              
              // 결제 성공 시 -> 주문 완료 페이지로 이동
             
          } else {
              // 결제 실패 시 로직,
	            //이곳을 결제 성공했다고 치고 테스트
	              
	              //통신 productpaymentcontroller로 이동
	            $.ajax({
					url : "../../controller/productpaymentcontroller.jsp",
					data : {
						/*order_name: buyer_name,
						order_phone: buyer_tel,
						order_address: buyer_postcode+","+buyer_addr,
						order_pay : amount,
						order_payment : pay_method,
						delivery_pay : 3000*/
						//buyer_name :이런건 속성값이라서 이걸 넣는게 아니라 그 뒤에 걸($("#name").val()) 넣어야됨
						order_name: $("#name").val(),
						order_phone: $("#phone").val(),
						order_address:  $("#sample4_roadAddress").val()+","+ $("#sample4_jibunAddress").val()+","+$("#sample4_detailAddress").val(),
						//총 주문 금액
						order_pay : document.getElementById("totalpay").innerHTML,
						//주문 방식
						order_payment : document.getElementById("payselect").innerHTML,
						delivery_pay : 3000,
						//요청사항
						order_contents : document.getElementById("prequest").value
						},
					success : function(result){
						if(result==1){
			            	//결제 성공과 db처리 성공시 결제 주문 완료 페이지로 이동
			              location.href="../../view/product/productpaymentsuccess.jsp";
						}else{
							alert("오류 발생 관리자에게 문의");
						}
						
						
					}		
				})
          }
     });
}

/* 결제 api 이용하기 end*/

/* 회원과 동일 체크 */

	
//$(document).ready( function(){ 실행문 });	// 문서내에서 대기상태 이벤트 
$(document).ready( function(){ 
	// 체크 유무 검사 [ jquery ]
	$("#checkbox").change( function(){
		alert("체크박스 불러오나요??")
		// 체크박스가 변경 이벤트 
		if( $("#checkbox").is(":checked")){
			// 체크박스가 체크가 되었는지 확인 = true 
				// is : 해당 태그에 속성 유무 확인 [ ":속성명" ] 메소드 
			$("#name").val(  $("#mname").val()  );
			$("#phone").val(  $("#mphone").val() );
		}else{ // 체크 해제시 공백 채움
			$("#name").val("");
			$("#phone").val("");
		}
	});
	$("#checkbox2").change( function(){

	alert("체크박스2 불러오나요??")
	
		if( $("#checkbox2").is(":checked")){
			$("#sample4_postcode").val(  $("#address1").val() );
			$("#sample4_roadAddress").val(  $("#address2").val() );
			$("#sample4_jibunAddress").val(  $("#address3").val() );
			$("#sample4_detailAddress").val(  $("#address4").val() );
		}else{
			$("#sample4_postcode").val( "" );
			$("#sample4_roadAddress").val( "" );
			$("#sample4_jibunAddress").val( "" );
			$("#sample4_detailAddress").val( "" );
		}
	});
});	

/* 회원과 동일 체크 end */


/* 결제 정보 start */
function pointcheck(mpoint){
	//포인트 = 문자열이라서 숫자 처리 해줘야됨
	var point = document.getElementById("point").value*1;
	
	if(mpoint < point){
		alert("포인트가 부족합니다.");
		point=0;
	}else{
		document.getElementById("userpoint").innerHTML = point
	}
		var totalprice = document.getElementById("totalprice").innerHTML*1;
		var totaldeliverypay = document.getElementById("totaldeliverypay").innerHTML*1;
		document.getElementById("totalpay").innerHTML = totalprice+totaldeliverypay-point;
	
}
/* 결제 정보 end */


/* 결제 방식 선택 start */

function paymentselect(payselect){
	document.getElementById("payselect").innerHTML= payselect;
}

/* 결제 방식 선택 end */



/* 주문 목록 스크롤 start */
// 스크롤 아래로 내려갔을 때 다음 주문 정보 가져오기
// JQuery 사용

var item = 2; //기본 주문 2개를 제외한 3번째 주문부터 

//$(window) : 현재 창
$(window).scroll(function(){ //스크롤 이벤트
	//$(window).scrollTop() : 현재 스크롤의 위치
	//alert("현재 스크롤 위치 : " + $(window).scrollTop());
	//alert("현재 화면의 크기 [보이는 화면] : " + $(window).height());
	//alert("문서의 높이[보이지 않는 화면 포함] : " + $(document).height());
	
	// 스크롤이 바닥에 닿았을때 계산
	if($(window).scrollTop() == $(document).height() - $(window).height()){
		//(문서전체) 현재 스크롤 위치 == 문서 전체 높이 - 현재 문서 높이
		//alert($(document).height() - $(window).height());
		
		$.ajax({
			url:"../../controller/orderlistscrollcontroller.jsp",
			data:{item:item},
			success : function(result){
				//alert(result);
				$("section").append(result);
				//태그명.append(결과) //해당 태그에 결과 추가
			}
		})
	item++; //스크롤이 바닥에 닿았을때 주문 1씩 증가
	//item+2; //스크롤 한번에 아이템 2개씩 나옴
	}
	
});


/* 주문 목록 스크롤 end */

/* 차트 start */

/* 차트 end */


