<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
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

</script>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container">
    <a href="#" onclick="w3_close()" class="w3-hide-large w3-right w3-jumbo w3-padding w3-hover-grey" title="close menu">
      <i class="fa fa-remove"></i>
    </a>
    <img src="${ctp}/images/avatar_g2.jpg" style="width:45%;" class="w3-round"><br><br>
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
    <h4><b>ALCOHOL LOVER를 방문해 주셔서 감사합니다.</b></h4>
    <p class="w3-text-grey">MADE BY 빵서</p>
  </div>
  <div class="w3-bar-block">
    <a href="${ctp}/" onclick="w3_close()" class="w3-bar-item w3-button w3-padding w3-text-teal"><i class="fa fa-th-large fa-fw w3-margin-right"></i>Main</a> 
    <a href="${ctp}/member/memberMain" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-user fa-fw w3-margin-right"></i>MEMBER</a>
    <a onclick="myAccFunc()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn">
      Alcohol <i class="fa fa-caret-down"></i>
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
       User <i class="fa fa-caret-down"></i>
    </a>
    <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
      <a href="#" class="w3-bar-item w3-button w3-light-grey"><i class="fa fa-caret-right w3-margin-right"></i>나만의 레시피</a>
      <a href="#" class="w3-bar-item w3-button">양주</a>
      <a href="#" class="w3-bar-item w3-button">위스키</a>
      <a href="#" class="w3-bar-item w3-button">와인</a>
      <a href="#" class="w3-bar-item w3-button">막걸리</a> 
      <a href="#" class="w3-bar-item w3-button">하이볼</a> 
      <a href="#" class="w3-bar-item w3-button">칵테일</a> 
  </div>
  </div>
    <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button w3-padding"><i class="fa fa-envelope fa-fw w3-margin-right"></i>CONTACT</a>
  <div class="w3-panel w3-large">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
</nav>