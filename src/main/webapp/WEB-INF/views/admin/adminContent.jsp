<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 대시보드</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <!-- Font Awesome CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <style>
    .card {
      transition: transform 0.3s;
    }
    .card:hover {
      transform: translateY(-5px);
    }
    .card-icon {
      font-size: 2rem;
      margin-bottom: 15px;
    }
  </style>
</head>
<body class="bg-light">
<div class="container mt-5">
  <h2 class="text-center mb-4">관리자 대시보드</h2>
  <hr class="mb-4"/>
  
  <div class="row">
    <div class="col-md-4 mb-3">
      <div class="card bg-primary text-white">
        <div class="card-body text-center">
          <i class="fas fa-book-open card-icon"></i>
          <h5 class="card-title">방명록 새글</h5>
          <p class="card-text display-4">???</p>
          <p class="card-text"><small>최근 1주일</small></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <div class="card bg-success text-white">
        <div class="card-body text-center">
          <i class="fas fa-clipboard card-icon"></i>
          <h5 class="card-title">게시글 새글</h5>
          <p class="card-text display-4">???</p>
          <p class="card-text"><small>최근 1주일</small></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 mb-3">
      <div class="card bg-warning text-dark">
        <div class="card-body text-center">
          <i class="fas fa-exclamation-triangle card-icon"></i>
          <h5 class="card-title">신고글</h5>
          <p class="card-text display-4">1건</p>
          <p class="card-text"><small>최근 1주일</small></p>
        </div>
      </div>
    </div>
  </div>

  <div class="row mt-4">
    <div class="col-md-6 mb-3">
      <div class="card bg-info text-white">
        <div class="card-body text-center">
          <i class="fas fa-user-plus card-icon"></i>
          <h5 class="card-title">신규등록회원</h5>
          <p class="card-text display-4"><a href="MemberList?level=1" class="text-white"><b>${newMemberCnt}건</b></a></p>
          <p class="card-text"><small>클릭하여 자세히 보기</small></p>
        </div>
      </div>
    </div>
    <div class="col-md-6 mb-3">
      <div class="card bg-danger text-white">
        <div class="card-body text-center">
          <i class="fas fa-user-minus card-icon"></i>
          <h5 class="card-title">탈퇴신청회원</h5>
          <p class="card-text display-4"><a href="MemberList?level=999" class="text-white"><b>1건</b></a></p>
          <p class="card-text"><small>클릭하여 자세히 보기</small></p>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>