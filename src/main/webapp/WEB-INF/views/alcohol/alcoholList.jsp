<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>alcoholList.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
     body {
         font-family: Arial, sans-serif;
     }
     .container {
         display: flex;
         flex-wrap: wrap;
         gap: 20px;
         justify-content: center;
     }
     .item {
         border: 1px solid #ddd;
         border-radius: 8px;
         width: 150px;
         padding: 10px;
         text-align: center;
     }
     .item img {
         max-width: 100%;
         border-radius: 8px;
     }
     .item .title {
         font-size: 14px;
         margin: 10px 0;
     }
     .item .price {
         font-size: 16px;
         color: #e74c3c;
         margin-bottom: 5px;
     }
     .item .time {
         font-size: 12px;
         color: #999;
         margin-bottom: 10px;
     }
     .item .actions {
         display: flex;
         justify-content: space-between;
     }
     .item .actions .like, .item .actions .view {
         font-size: 12px;
         color: #555;
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
<p><br/></p>
<div class="container">
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td colspan="2"><h2 class="text-center">술 목록</h2></td>
    </tr>
    <tr>
      <td><c:if test="${sLevel != 3}"><a href="alcoholInput" class="btn btn-success btn-sm">새 술 추가</a></c:if></td>
      <td class="text-right">
        <select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
          <option ${pageVO.pageSize==5  ? "selected" : ""}>5</option>
          <option ${pageVO.pageSize==10 ? "selected" : ""}>10</option>
          <option ${pageVO.pageSize==15 ? "selected" : ""}>15</option>
          <option ${pageVO.pageSize==20 ? "selected" : ""}>20</option>
          <option ${pageVO.pageSize==30 ? "selected" : ""}>30</option>
        </select>
      </td>
    </tr>
  </table>
   <div class="container">
   		<%-- <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" /> --%>
   		<c:forEach var="vo" items="${vos}" varStatus="st">
        <div class="item">
            <img src="${ctp}/thumbnail/${vo.thumbnail}" alt="Item 1">
            <a href="${ctp}/alcohol/alcoholContent?idx=${vo.idx}"><div class="title">${vo.title}</div></a>
            <div class="price">${vo.price}</div>
            <div class="WDate">${vo.WDate}</div>
            <div class="part">${vo.part}</div>
            <div class="actions">
                <div class="like">❤️ ${vo.good}</div>
                <div class="view">👁️ ${vo.readNum}</div>
            </div>
        </div>
      </c:forEach>
      <!-- Add more items as needed -->
    </div>
  <br/>
	<!-- 블록페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="alcoholList?pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="alcoholList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="alcoholList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="alcoholList?pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="alcoholList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="alcoholList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
	<br/>
	<!-- 검색기 시작 -->
	<div class="container text-center">
	  <form name="searchForm" method="post" action="alcoholSearch">
	    <b>검색 : </b>
	    <select name="search" id="search">
	      <option value="title">제목</option>
	      <option value="mid">작성자</option>
	      <option value="content">내용</option>
	    </select>
	    <input type="text" name="searchString" id="searchString" required />
	    <input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
	    <input type="hidden" name="pag" value="${pageVO.pag}"/>
	    <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
	  </form>
	</div>
	<!-- 검색기 끝 -->
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>