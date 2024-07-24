<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원 전용방</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    function chatInput() {
      let chat = $("#chat").val();
      if(chat.trim() != "") {
        $.ajax({
          url  : "MemberChatInput.mem",
          type : "post",
          data : {chat : chat},
          error: function() {
            alert("전송오류!!");
          }
        });
      }
    }
    
    $(function(){
      $("#chat").on("keydown",function(e){
        if(e.keyCode == 13) chatInput();
      });
    });
  </script>
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 30px;
    }
    h2 {
      color: #007bff;
      border-bottom: 2px solid #007bff;
      padding-bottom: 10px;
    }
    .card {
      margin-bottom: 20px;
      border: none;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .card-header {
      background-color: #007bff;
      color: white;
      font-weight: bold;
    }
    .table {
      margin-bottom: 0;
    }
    .profile-img {
      max-width: 200px;
      border-radius: 50%;
      border: 3px solid #007bff;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center mb-4">회원 전용방</h2>
  
  <div class="row">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          회원 정보
        </div>
        <div class="card-body">
          <p>현재 <b><font color="blue">${sNickName}</font>(<font color="red">${strLevel}</font>)</b> 님이 로그인 중이십니다.</p>
          <p>총 방문횟수 : <b>${mVo.visitCnt}</b> 회</p>
          <p>오늘 방문횟수 : <b>${mVo.todayCnt}</b> 회</p>
          <p>총 보유 포인트 : <b>${mVo.point}</b> 점</p>
        </div>
      </div>
    </div>
    <div class="col-md-6 text-center">
      <img src="${ctp}/member/${mVo.photo}" class="profile-img" alt="Profile Picture"/>
    </div>
  </div>

  <div class="row mt-4">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          신규 메세지 (<font color='red'><b>${wmCnt}</b></font>건)
          <span style="font-size:11px">...<a href="WebMessage.wm">more</a></span>
        </div>
        <div class="card-body">
          <c:if test="${wmCnt != 0}">
            <table class="table table-bordered table-hover text-center">
              <tr class="table-primary">
                <th>번호</th>
                <th>아이디</th>
                <th>보낸날짜</th>
              </tr>
              <c:forEach var="vo" items="${wmVos}" varStatus="st">
                <c:if test="${st.count <= 3}">
                  <tr>
                    <td>${st.count}</td>
                    <td>${vo.sendId}</td>
                    <td>${fn:substring(vo.sendDate,0,16)}</td>
                  </tr>
                </c:if>
              </c:forEach>
            </table>
          </c:if>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          오늘의 일정
        </div>
        <div class="card-body">
          오늘의 일정이 <font color='blue'><b><a href="ScheduleMenu.sc?ymd=${ymd}">${scheduleCnt}</a></b></font>건 있습니다.
        </div>
      </div>
    </div>
  </div>

  <div class="card mt-4">
    <div class="card-header">
      활동내역
    </div>
    <div class="card-body">
      <p>방명록에 올린글수 : <b>${guestCnt}</b> 건</p>
      <p>게사판에 올린글수 : <b>${boardCnt}</b> 건</p>
      <p>자료실에 올린글수 : <b>${pdsCnt}</b> 건</p>
    </div>
  </div>

  <c:if test="${!empty sLogin}">
    <div class="alert alert-warning mt-4" role="alert">
      현재 임시비밀번호를 발급하여 메일로 전송처리 되어 있습니다.<br/>
      개인정보를 확인하시고, 비밀번호를 새로 변경해 주세요<br/>
    </div>
  </c:if>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>