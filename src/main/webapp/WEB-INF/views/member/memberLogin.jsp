<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Old+Standard+TT:wght@400;700&display=swap" rel="stylesheet">
  <link href="${ctp}/css/login.css" rel="stylesheet">
  <%-- <script src="${ctp}/css/login.css"></script> --%>
  <script>
    'use strict';
    
    $(function(){
    	$("#searchPassword").hide();
    });
    
    // 비밀번호 찾기
    function pwdSearch() {
    	$("#searchPassword").show();
    }
    
    // 임시비밀번호 등록시켜주기
    function newPassword() {
    	let mid = $("#midSearch").val().trim();
    	let email = $("#emailSearch2").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
    		$("#midSearch").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/member/memberNewPassword",
    		type : "post",
    		data : {
    			mid   : mid,
    			email : email
    		},
    		success:function(res) {
    			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
  				location.reload();
    		},
    		error : function() {
    			alert("전송오류!!")
    		}
    	});
    }
    
    // 카카오 로그인(자바스크립트 앱키 등록)
    window.Kakao.init("139e8724c659adc1b30906ee4d7a5767");
    
    function kakaoLogin() {
    	window.Kakao.Auth.login({
    		scope: 'profile_nickname, account_email',
    		success:function(autoObj) {
    			console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...");
    			window.Kakao.API.request({
    				url : '/v2/user/me',
    				success:function(res) {
    					const kakao_account = res.kakao_account;
    					console.log(kakao_account);
    					location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
    				}
    			});
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <div class="login-container">
    <h2 class="text-center mb-4">로그인</h2>
    <form name="myform" method="post">
      <div class="form-group">
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
          </div>
          <input type="text" name="mid" value="${mid}" class="form-control" placeholder="아이디" required autofocus>
        </div>
      </div>
      <div class="form-group">
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text"><i class="fas fa-lock"></i></span>
          </div>
          <input type="password" name="pwd" class="form-control" placeholder="비밀번호" required>
        </div>
      </div>
      <div class="form-group">
        <button type="submit" class="btn btn-primary btn-block">로그인</button>
      </div>
      <div class="form-group text-center">
        <div class="custom-control custom-checkbox">
          <input type="checkbox" class="custom-control-input" id="idSave" name="idSave" checked>
          <label class="custom-control-label" for="idSave">아이디 저장</label>
        </div>
      </div>
    </form>
    <div class="text-center mb-3">
      <a href="javascript:midSearch()" class="text-secondary">아이디 찾기</a> |
      <a href="javascript:pwdSearch()" class="text-secondary">비밀번호 찾기</a>
    </div>
    <div class="text-center">
      <p>계정이 없으신가요? <a href="${ctp}/member/memberJoin">회원가입</a></p>
    </div>
    <div class="text-center mt-3">
      <a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakao_login_medium_narrow.png" alt="카카오 로그인" class="img-fluid"></a>
    </div>
  </div>
  
  <div id="searchPassword" class="mt-4" style="display: none;">
    <h3 class="text-center mb-3">비밀번호 찾기</h3>
    <p class="text-center mb-3">가입시 입력한 아이디와 메일주소를 입력하세요</p>
    <div class="form-group">
      <input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디">
    </div>
    <div class="form-group">
      <input type="email" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="이메일">
    </div>
    <div class="form-group">
      <button onclick="newPassword()" class="btn btn-secondary btn-block">새 비밀번호 발급</button>
    </div>
  </div>
</div>
</body>
</html>