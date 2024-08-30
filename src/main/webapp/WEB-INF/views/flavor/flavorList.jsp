<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>나만의 리스트 - 노트북 스타일</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      background-color: #f0f0f0;
      font-family: 'Courier New', monospace;
    }
    .container {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-top: 20px;
    }
    h2 {
      color: #333;
      border-bottom: 2px solid #333;
      padding-bottom: 10px;
    }
    .note-item {
      background-color: #ffffa5;
      border: 1px solid #e6e6a5;
      border-radius: 0 0 5px 5px;
      margin-bottom: 15px;
      padding: 10px;
      position: relative;
    }
    .note-item::before {
      content: '';
      position: absolute;
      top: -5px;
      left: 50%;
      width: 30%;
      height: 5px;
      background-color: #e6e6a5;
      transform: translateX(-50%);
    }
    .note-title {
      font-weight: bold;
      margin-bottom: 5px;
    }
    .note-meta {
      font-size: 0.8em;
      color: #666;
    }
    .pagination {
      justify-content: center;
    }
    .pagination .page-link {
      background-color: #ffffa5;
      border-color: #e6e6a5;
      color: #333;
    }
    .pagination .page-item.active .page-link {
      background-color: #e6e6a5;
      border-color: #cccc85;
    }
  </style>
  <script>
    'use strict';
    
    function pageSizeCheck() {
      let pageSize = $("#pageSize").val();
      location.href = "flavorList?pageSize="+pageSize;
    }
    
    function modalCheck(idx, hostIp, mid, nickName) {
      $("#myModal #modalHostIp").text(hostIp);
      $("#myModal #modalMid").text(mid);
      $("#myModal #modalNickName").text(nickName);
      $("#myModal #modalIdx").text(idx);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center mb-4">나만의 리스트</h2>
  <div class="d-flex justify-content-between mb-3">
    <div>
      <c:if test="${sLevel != 3}"><a href="flavorInput" class="btn btn-success btn-sm">글쓰기</a></c:if>
    </div>
    <div>
      <select name="pageSize" id="pageSize" onchange="pageSizeCheck()" class="form-control form-control-sm">
        <option ${pageSize==5  ? "selected" : ""}>5</option>
        <option ${pageSize==10 ? "selected" : ""}>10</option>
        <option ${pageSize==15 ? "selected" : ""}>15</option>
        <option ${pageSize==20 ? "selected" : ""}>20</option>
        <option ${pageSize==30 ? "selected" : ""}>30</option>
      </select>
    </div>
  </div>

  <c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sNickName == vo.nickName}">
      <c:if test="${vo.complaint == 'NO' || sLevel == 0 || sNickName == vo.nickName}">
        <div class="note-item">
          <div class="note-title">
            <a href="flavorContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">${vo.title}</a>
            <c:if test="${vo.hour_diff <= 24}"><span class="badge badge-warning ml-2">New</span></c:if>
          </div>
          <div class="note-meta">
            <span>${vo.nickName}</span> |
            <span>${vo.part}</span> |
            <span>${vo.date_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,10)}</span> |
            <span>조회수: ${vo.readNum}</span> |
            <span>좋아요: ${vo.good}</span>
            <c:if test="${sLevel == 0}">
              <a href="#" onclick="modalCheck('${vo.idx}','${vo.hostIp}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal" class="btn btn-outline-secondary btn-sm ml-2">상세정보</a>
            </c:if>
          </div>
        </div>
      </c:if>
    </c:if>
  </c:forEach>

  <!-- 페이지네이션 -->
  <ul class="pagination mt-4">
    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link" href="${ctp}/FlavorList?pag=1&pageSize=${pageSize}">처음</a></li></c:if>
    <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link" href="${ctp}/FlavorList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전</a></li></c:if>
    <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
      <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link" href="${ctp}/FlavorList?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
      <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link" href="${ctp}/FlavorList?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/FlavorList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음</a></li></c:if>
    <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link" href="${ctp}/FlavorList?pag=${totPage}&pageSize=${pageSize}">마지막</a></li></c:if>
  </ul>
</div>

<!-- 모달 (변경 없음) -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">상세 정보</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        고유번호 : <span id="modalIdx"></span><br/>
        아이디 : <span id="modalMid"></span><br/>
        호스트IP : <span id="modalHostIp"></span><br/>
        닉네임 : <span id="modalNickName"></span><br/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>