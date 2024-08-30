<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>술 목록</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f4f4f4;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }
    h2 {
      color: #333;
      text-align: center;
      margin-bottom: 30px;
    }
    .item-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 20px;
    }
    .item {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease;
    }
    .item:hover {
      transform: translateY(-5px);
    }
    .item img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
    }
    .item-content {
      padding: 15px;
    }
    .item .title {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #333;
    }
    .item .price {
      font-size: 18px;
      color: #e74c3c;
      margin-bottom: 5px;
    }
    .item .WDate, .item .part {
      font-size: 14px;
      color: #777;
      margin-bottom: 5px;
    }
    .item .actions {
      display: flex;
      justify-content: space-between;
      margin-top: 10px;
    }
    .item .actions .like, .item .actions .view {
      font-size: 14px;
      color: #555;
    }
    .pagination {
      margin-top: 30px;
    }
    .search-form {
      margin-top: 30px;
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
  </style>
  <script>
    'use strict';
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      location.href = "alcoholList?pageSize="+pageSize;
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container" style="margin-left: 300px;">
  <h2>술 목록</h2>
  
  <div class="d-flex justify-content-between align-items-center mb-4">
    <c:if test="${sLevel != 3}"><a href="alcoholInput" class="btn btn-primary">새 술 추가</a></c:if>
    <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-control" style="width: auto;">
      <option ${pageVO.pageSize==5  ? "selected" : ""}>5</option>
      <option ${pageVO.pageSize==10 ? "selected" : ""}>10</option>
      <option ${pageVO.pageSize==15 ? "selected" : ""}>15</option>
      <option ${pageVO.pageSize==20 ? "selected" : ""}>20</option>
      <option ${pageVO.pageSize==30 ? "selected" : ""}>30</option>
    </select>
  </div>

  <div class="item-grid">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <div class="item">
        <img src="${ctp}/thumbnail/${vo.thumbnail}" alt="${vo.title}">
        <div class="item-content">
          <a href="${ctp}/alcohol/alcoholContent?idx=${vo.idx}" class="title">${vo.title}</a>
          <div class="price">${vo.price}원</div>
          <div class="WDate">${vo.WDate}</div>
          <div class="part">${vo.part}</div>
          <div class="actions">
            <div class="like">❤️ ${vo.good}</div>
            <div class="view">👁️ ${vo.readNum}</div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- 페이지네이션 -->
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link" href="alcoholList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link" href="alcoholList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
    <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="alcoholList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="alcoholList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
    </c:forEach>
    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="alcoholList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="alcoholList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
  </ul>

  <!-- 검색 폼 -->
  <div class="search-form">
    <form name="searchForm" method="post" action="alcoholSearch" class="form-inline justify-content-center">
      <select name="search" id="search" class="form-control mr-2">
        <option value="title">제목</option>
        <option value="part">종류</option>
        <option value="content">내용</option>
      </select>
      <input type="text" name="searchString" id="searchString" required class="form-control mr-2" />
      <input type="submit" value="검색" class="btn btn-primary"/>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>