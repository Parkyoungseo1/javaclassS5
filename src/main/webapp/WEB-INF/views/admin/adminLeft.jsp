<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #ffffff;
    }
    .admin-menu {
      width: 300px;
      margin: 20px auto;
      padding: 0 15px;
    }
    .admin-menu h5 {
      color: #3498db;
      border-bottom: 2px solid #3498db;
      padding-bottom: 10px;
      margin-bottom: 20px;
    }
    .admin-menu a {
      color: #3498db;
      text-decoration: none;
      transition: color 0.3s;
    }
    .admin-menu a:hover {
      color: #2980b9;
    }
    .accordion {
      background-color: transparent;
      color: #333;
      cursor: pointer;
      padding: 15px 0;
      width: 100%;
      border: none;
      text-align: left;
      outline: none;
      font-size: 15px;
      transition: 0.4s;
      border-bottom: 1px solid #e0e0e0;
    }
    .active, .accordion:hover {
      background-color: #f8f8f8;
    }
    .panel {
      background-color: #ffffff;
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.2s ease-out;
    }
    .panel p {
      margin: 10px 0;
      padding-left: 15px;
    }
    .accordion:after {
      content: '\002B';
      color: #777;
      font-weight: bold;
      float: right;
      margin-left: 5px;
    }
    .active:after {
      content: "\2212";
    }
    .fa-solid {
      margin-right: 10px;
    }
  </style>
</head>
<body>
<div class="admin-menu">
  <h5 class="text-center">관리자메뉴</h5>
  <p class="text-center"><a href="${ctp}/" target="_top"><i class="fa-solid fa-home"></i> 홈으로</a></p>
  <hr/>
  <div>
    <button class="accordion"><i class="fa-solid fa-clipboard-list"></i> 게시글관리</button>
    <div class="panel">
      <p><a href="${ctp}/${ctp}/admin/guest/guestList" target="adminContent">방명록리스트</a></p>
      <p><a href="${ctp}/admin/alcohol/alcoholList" target="adminContent">Alcohol리스트</a></p>
      <p><a href="${ctp}/admin/userboard/userboardList" target="adminContent">Userboard리스트</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><i class="fa-solid fa-users"></i> 회원관리</button>
    <div class="panel">
      <p><a href="${ctp}/admin/member/memberList" target="adminContent">회원리스트</a></p>
      <p><a href="#" target="adminContent">신고리스트</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><i class="fa-solid fa-calendar-alt"></i> 일정관리</button>
    <div class="panel">
      <p><a href="${ctp}/admin/schedule/scheduleList" target="adminContent">일정</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><i class="fa-solid fa-cogs"></i> 기타관리</button>
    <div class="panel">
      <p><a href="${ctp}/admin/file/fileList" target="adminContent">파일관리</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><i class="fa-solid fa-shopping-cart"></i> 상품관리</button>
    <div class="panel">
      <p><a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a></p>
      <p><a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a></p>
      <p><a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록조회</a></p>
      <p><a href="${ctp}/dbShop/dbOption" target="adminContent">옵션등록관리</a></p>
      <p><a href="${ctp}/dbShop/adminOrder" target="adminContent">주문관리</a></p>
      <p><a href="${ctp}/" target="adminContent">1:1문의</a></p>
      <p><a href="${ctp}/dbShop/" target="adminContent">메인이미지관리</a></p>
    </div>
  </div>
</div>
<script>
  var acc = document.getElementsByClassName("accordion");
  var i;
  
  for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
      this.classList.toggle("active");
      var panel = this.nextElementSibling;
      if (panel.style.maxHeight) {
        panel.style.maxHeight = null;
      } else {
        panel.style.maxHeight = panel.scrollHeight + "px";
      } 
    });
  }
</script>
</body>
</html>