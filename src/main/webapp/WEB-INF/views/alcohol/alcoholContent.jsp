<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>술 정보 상세보기</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
    }
    .container {
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 2rem;
      margin-top: 2rem;
    }
    h2 {
      color: #343a40;
      margin-bottom: 1.5rem;
    }
    .card {
      border: none;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .card-header {
      background-color: #f1f3f5;
      font-weight: bold;
    }
    .btn-icon {
      font-size: 1.2rem;
      margin-right: 0.5rem;
    }
    .content-area {
      min-height: 200px;
      white-space: pre-wrap;
    }
    .nav-link {
      color: #495057;
    }
    .nav-link:hover {
      color: #228be6;
    }
  </style>
  <script>
    'use strict';
    
    function alcoholDelete() {
      let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
      if(ans) location.href = "alcoholDelete?idx=${vo.idx}";
    }
    
    function goodCheck() {
      $.ajax({
        url  : "AlcoholGoodCheck",
        type : "post",
        data : {idx : ${vo.idx}},
        success:function(res) {
          if(res != "0") location.reload();
        },
        error : function() {
          alert("전송오류");
        }
      });
    }
    
    function goodCheck2() {
      $.ajax({
        url  : "AlcoholGoodCheck2",
        type : "post",
        data : {idx : ${vo.idx}},
        success:function(res) {
          if(res != "0") location.reload();
          else alert("이미 좋아요 버튼을 클릭하셨습니다.");
        },
        error : function() {
          alert("전송오류");
        }
      });
    }
    
    function goodCheckPlus() {
      updateGoodCount(1);
    }
    
    function goodCheckMinus() {
      updateGoodCount(-1);
    }
    
    function updateGoodCount(change) {
      $.ajax({
        url  : "AlcoholGoodCheckPlusMinus",
        type : "post",
        data : {
          idx : ${vo.idx},
          goodCnt : change
        },
        success:function(res) {
          if(res != "0" || change > 0) location.reload();
        },
        error : function() {
          alert("전송오류");
        }
      });
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container my-5">
  <h2 class="text-center mb-4">술 정보 상세보기</h2>
  
  <div class="card mb-4">
    <div class="card-header d-flex justify-content-between align-items-center">
      <span>${vo.title}</span>
      <div>
        <button onclick="goodCheck()" class="btn btn-sm btn-outline-danger mr-2">
          <i class="fas fa-heart"></i> ${vo.good}
        </button>
        <button onclick="goodCheck2()" class="btn btn-sm btn-outline-primary">
          <i class="fas fa-thumbs-up"></i> ${vo.good}
        </button>
      </div>
    </div>
    <div class="card-body">
      <div class="row mb-3">
        <div class="col-md-3"><strong>글쓴이:</strong> ${vo.mid}</div>
        <div class="col-md-3"><strong>작성일:</strong> ${fn:substring(vo.WDate, 0, 16)}</div>
        <div class="col-md-3"><strong>조회수:</strong> ${vo.readNum}</div>
        <div class="col-md-3"><strong>가격:</strong> ${vo.price}원</div>
      </div>
      <div class="row mb-3">
        <div class="col-md-3"><strong>술 종류:</strong> ${vo.part}</div>
      </div>
      <hr>
      <div class="content-area">
        ${fn:replace(vo.content, newLine, "<br/>")}
      </div>
    </div>
    <div class="card-footer d-flex justify-content-between">
      <div>
        <c:if test="${empty flag}">
          <a href="alcoholList?pag=${pag}&pageSize=${pageSize}" class="btn btn-secondary">
            <i class="fas fa-list btn-icon"></i>목록으로
          </a>
        </c:if>
        <c:if test="${!empty flag}">
          <a href="alcoholSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}" class="btn btn-secondary">
            <i class="fas fa-list btn-icon"></i>검색 목록으로
          </a>
        </c:if>
      </div>
      <div>
        <a href="alcoholUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}" class="btn btn-primary mr-2">
          <i class="fas fa-edit btn-icon"></i>수정
        </a>
        <button onclick="alcoholDelete()" class="btn btn-danger">
          <i class="fas fa-trash-alt btn-icon"></i>삭제
        </button>
      </div>
    </div>
  </div>
  
  <nav>
    <ul class="pagination justify-content-center">
      <c:if test="${!empty preVo.title}">
        <li class="page-item">
          <a class="page-link" href="alcoholContent?idx=${preVo.idx}">
            <i class="fas fa-chevron-left"></i> 이전글: ${preVo.title}
          </a>
        </li>
      </c:if>
      <c:if test="${!empty nextVo.title}">
        <li class="page-item">
          <a class="page-link" href="alcoholContent?idx=${nextVo.idx}">
            다음글: ${nextVo.title} <i class="fas fa-chevron-right"></i>
          </a>
        </li>
      </c:if>
    </ul>
  </nav>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>