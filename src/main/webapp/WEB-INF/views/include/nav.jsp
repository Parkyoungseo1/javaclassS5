<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/your-kit-code.js" crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script>
  function userDelCheck() {
	  let ans = confirm("회원 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은 아이디로 다시 가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
		  if(ans) {
			  $.ajax({
				  type : "post",
				  url  : "${ctp}/member/userDel",
				  success:function(res) {
					  if(res == "1") {
						  alert("회원에서 탈퇴 되셨습니다.");
						  location.href = '${ctp}/member/memberLogin';
					  }
					  else {
						  alert("회원 탈퇴신청 실패~~");
					  }
				  },
				  error : function() {
					  alert("전송오류!");
				  }
			  });
		  }
	  }
  }
  
  // 카카오 로그아웃
  window.Kakao.init("139e8724c659adc1b30906ee4d7a5767");
  function kakaoLogout() {
	  const accessToken = Kakao.Auth.getAccessToken();
	  if(accessToken) {
		  Kakao.Auth.logout(function() {
			  window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=139e8724c659adc1b30906ee4d7a5767&logout_redirect_uri=http://localhost:9090/javaclassS/member/memberLogout";
		  });
	  }
  }
  
	//Script to open and close sidebar
	  function w3_open() {
	     document.getElementById("mySidebar").style.display = "block";
	     document.getElementById("myOverlay").style.display = "block";
	  }
	
	  function w3_close() {
	     document.getElementById("mySidebar").style.display = "none";
	     document.getElementById("myOverlay").style.display = "none";
	  }
	  
		// Accordion 
	  function myAccFunc() {
	    var x = document.getElementById("demoAcc");
	    if (x.className.indexOf("w3-show") == -1) {
	      x.className += " w3-show";
	    } else {
	      x.className = x.className.replace(" w3-show", "");
	    }
	  }
		// Accordion 
	  function myAccFunc1() {
	    var x = document.getElementById("demoAcc1");
	    if (x.className.indexOf("w3-show") == -1) {
	      x.className += " w3-show";
	    } else {
	      x.className = x.className.replace(" w3-show", "");
	    }
	  }
		// Accordion 
	  function myAccFunc2() {
	    var x = document.getElementById("demoAcc2");
	    if (x.className.indexOf("w3-show") == -1) {
	      x.className += " w3-show";
	    } else {
	      x.className = x.className.replace(" w3-show", "");
	    }
	  }
		// Accordion 
	  function myAccFunc3() {
	    var x = document.getElementById("demoAcc3");
	    if (x.className.indexOf("w3-show") == -1) {
	      x.className += " w3-show";
	    } else {
	      x.className = x.className.replace(" w3-show", "");
	    }
	  }
		// Accordion 
	  function myAccFunc4() {
	    var x = document.getElementById("demoAcc4");
	    if (x.className.indexOf("w3-show") == -1) {
	      x.className += " w3-show";
	    } else {
	      x.className = x.className.replace(" w3-show", "");
	    }
	  }

</script>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse  w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container" >
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <c:if test="${!empty sMid}">
    	<img src="${ctp}/member/${sPhoto}" style="width:80%;" class="w3-round"><br><br>
    </c:if>
    <c:if test="${empty sLevel}">
	    <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Login</a>
	    <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Join</a>
    </c:if>
    <c:if test="${!empty sLevel}">
	    <div class="w3-dropdown-hover w3-hide-small">
	      <button class="w3-padding-large w3-button" title="More">Logout <i class="fa fa-caret-down"></i></button>     
	      <div class="w3-dropdown-content w3-bar-block w3-card-4">
			    <a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-padding-large w3-hide-small">일반 Logout</a>
			    <a href="javascript:kakaoLogout()" class="w3-bar-item w3-button w3-padding-large w3-hide-small">Kakao Logout</a>
			  </div>
			</div>
    </c:if>
    <c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button"><i class="fa-solid fa-user-tie"></i>관리자메뉴</a></c:if>
    <h4><b>저희 주절주절(을) 방문해 주셔서 감사합니다.</b></h4>
    <p class="w3-text-grey">MADE BY 빵서</p>
  </div>
  <div class="w3-bar-block">
    <a href="${ctp}/" onclick="w3_close()" class="w3-bar-item w3-button w3-padding w3-text-teal"><i class="fa fa-th-large fa-fw w3-margin-right"></i>Main</a> 
    <a href="${ctp}/member/memberMain" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-user fa-fw w3-margin-right"></i>MEMBER</a>
    <a href="${ctp}/member/memberUpdate" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-user fa-fw w3-margin-right"></i>정보수정</a>
    <a href="${ctp}/member/memberPwdCheck" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-user fa-fw w3-margin-right"></i>비밀번호변경</a>
    <a onclick="myAccFunc()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
      <i class="fa-solid fa-whiskey-glass"></i> Alcohol <i class="fa-solid fa-caret-down"></i>
    </a>
    <div id="demoAcc" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${ctp}/alcohol/alcoholList" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>All</a>
      <a href="${ctp}/alcohol/alcoholList?part=Whiskey" class="w3-bar-item w3-button">Whiskey</a>
      <a href="${ctp}/alcohol/alcoholList?part=Liqueur" class="w3-bar-item w3-button">Liqueur</a>
      <a href="${ctp}/alcohol/alcoholList?part=Wine" class="w3-bar-item w3-button">Wine</a>
      <a href="${ctp}/alcohol/alcoholList?part=Makgeolli" class="w3-bar-item w3-button">Makgeolli</a> 
      <a href="${ctp}/alcohol/alcoholList?part=Highball" class="w3-bar-item w3-button">Highball</a> 
      <a href="${ctp}/alcohol/alcoholList?part=Cocktail" class="w3-bar-item w3-button">Cocktail</a> 
      <a href="${ctp}/alcohol/alcoholList?part=etc" class="w3-bar-item w3-button">etc</a> 
  	</div>
  </div>
  <div class="w3-bar-block">
    <a onclick="myAccFunc1()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
       <i class="fa-solid fa-users"></i> User <i class="fa-solid fa-caret-down"></i>
    </a>
    <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${ctp}/userboard/userboardList" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>Recipe&자유게시판</a>
      <a href="${ctp}/userboard/userboardList?part=Whiskey" class="w3-bar-item w3-button">Whiskey</a>
      <a href="${ctp}/userboard/userboardList?part=Liqueur" class="w3-bar-item w3-button">Liqueur</a>
      <a href="${ctp}/userboard/userboardList?part=Wine" class="w3-bar-item w3-button">자유게시판</a>
      <a href="${ctp}/userboard/userboardList?part=Makgeolli" class="w3-bar-item w3-button">Makgeolli</a> 
      <a href="${ctp}/userboard/userboardList?part=Highball" class="w3-bar-item w3-button">Highball</a> 
      <a href="${ctp}/userboard/userboardList?part=Cocktail" class="w3-bar-item w3-button">Cocktail</a> 
      <a href="${ctp}/userboard/userboardList?part=etc" class="w3-bar-item w3-button">etc</a>
  	</div>
  </div>
  <div class="w3-bar-block">
    <a onclick="myAccFunc4()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
       <i class="fa-solid fa-book-open-reader"></i> Tasting Note <i class="fas fa-caret-down"></i>
    </a>
    <div id="demoAcc4" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${ctp}/tastingNote/tastingNoteList" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>ALL</a>
      <a href="${ctp}/tastingNote/tastingNoteList?part=Whiskey" class="w3-bar-item w3-button">Whiskey</a>
      <a href="${ctp}/tastingNote/tastingNoteList?part=Liqueur" class="w3-bar-item w3-button">Liqueur</a>
      <a href="${ctp}/tastingNote/tastingNoteList?part=Wine" class="w3-bar-item w3-button">Wine</a>
      <a href="${ctp}/tastingNote/tastingNoteList?part=Makgeolli" class="w3-bar-item w3-button">Makgeolli</a> 
      <a href="${ctp}/tastingNote/tastingNoteList?part=Highball" class="w3-bar-item w3-button">Highball</a> 
      <a href="${ctp}/tastingNote/tastingNoteList?part=Cocktail" class="w3-bar-item w3-button">Cocktail</a> 
      <a href="${ctp}/tastingNote/tastingNoteList?part=etc" class="w3-bar-item w3-button">etc</a>
  	</div>
  </div>
  <div class="w3-bar-block">
    <a onclick="myAccFunc2()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
       <i class="fas fa-shopping-cart"></i> Shopping Mall <i class="fas fa-caret-down"></i>
    </a>
    <div id="demoAcc2" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${ctp}/dbShop/dbProductList" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>상품리스트</a>
      <a href="${ctp}/dbShop/dbCartList" class="w3-bar-item w3-button">장바구니</a>
      <a href="${ctp}/dbShop/dbProductContent" class="w3-bar-item w3-button">상품정보 상세보기</a>
      <a href="${ctp}/dbShop/dbOrder" class="w3-bar-item w3-button">주문정보</a>
      <a href="${ctp}/dbShop/dbOrderBaesong" class="w3-bar-item w3-button">주문(배송)현황</a>
      <a href="${ctp}/dbShop/dbList" class="w3-bar-item w3-button">결제연습</a>
      <a href="${ctp}/dbShop/dbList" class="w3-bar-item w3-button">QnA</a> 
      <a href="${ctp}/dbShop/dbList" class="w3-bar-item w3-button">1대1문의</a> 
  	</div>
  </div>
  <div class="w3-bar-block">
    <a onclick="myAccFunc3()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
       <i class="fa fa-envelope fa-fw w3-margin-right"></i> 문의사항 <i class="fas fa-caret-down"></i>
    </a>
    <div id="demoAcc3" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="${ctp}/qna/qnaList" class="w3-bar-item w3-button">QnA</a> 
      <a href="${ctp}/webSocket/endPoint" class="w3-bar-item w3-button">1대1문의</a> 
  	</div>
  </div>
  <div class="w3-panel w3-large">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
  
  
</nav>