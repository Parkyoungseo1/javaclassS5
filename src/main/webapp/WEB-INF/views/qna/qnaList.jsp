<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>QnA 게시판</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
  <script>
    function sChange() {
    	searchForm.searchString.focus();
    }
    
    function sCheck() {
    	var searchString = searchForm.searchString.value;
    	if(searchString == "") {
    		alert("검색어를 입력하세요");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
    
    // 비밀번호 처리때 사용하려했는데, 이곳에서는 사용하지 않음.
    function contentCheck(idx, title, pwd) {
    	if(pwd == '') {
    		location.href = "qnaContent?pag=${pageVO.pag}&idx="+idx+"&title="+title;
    	} 
    	else {
    		tempStr = '';
    		tempStr += '비밀번호 : ';
    		tempStr += '<input type="password" name="pwd"/>';
    		tempStr += '<input type="button" value="확인" onclick="movingCheck('+idx+')"/>';
    		tempStr += '<input type="button" value="닫기" onclick="location.reload()"/>';
    		alert("tempStr : " + tempStr);
    		$("#qna"+idx).html(tempStr);
    	}
    }
  </script>
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 30px;
    }
    h2 {
      color: #343a40;
      margin-bottom: 30px;
      text-align: center;
    }
    .table {
      border-radius: 8px;
      overflow: hidden;
    }
    .table-dark {
      background-color: #343a40;
    }
    .btn-secondary {
      background-color: #6c757d;
      border: none;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
    }
    .page-link {
      color: #6c757d;
    }
    .page-item.active .page-link {
      background-color: #6c757d;
      border-color: #6c757d;
    }
    .search-form {
      margin-top: 30px;
    }
    .search-form select, .search-form input[type="text"] {
      margin-right: 10px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
  <h2>QnA 게시판</h2>
  <div class="text-right mb-3">
    <button class="btn btn-secondary" onclick="location.href='qnaInput?qnaFlag=q';">글올리기</button>
  </div>
  <table class="table table-hover">
    <thead class="table-dark text-white">
      <tr>
        <th>글번호</th>
        <th>상태</th>
        <th>글제목</th>
        <th>글쓴이</th>
        <th>글쓴날짜</th>
      </tr>
    </thead>
    <tbody>
      <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
      <c:forEach var="vo" items="${vos}">
        <tr>
          <td>${curScrStartNo}</td>
          <td>
            <c:if test="${vo.qnaAnswer == '답변완료'}"><span class="badge badge-success">${vo.qnaAnswer}</span></c:if>
            <c:if test="${vo.qnaAnswer == '답변대기'}">
              <span class="badge badge-danger">
                <c:if test="${sLevel == 0}"><a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}" class="text-white">${vo.qnaAnswer}</a></c:if>
                <c:if test="${sLevel != 0}">${vo.qnaAnswer}</c:if>
              </span>
            </c:if>
          </td>
          <td class="text-left">
            <c:if test="${vo.qnaSw == 'a'}"> &nbsp;&nbsp; └</c:if>
            <c:if test="${!empty vo.pwd}"><i class="fas fa-lock"></i></c:if>
            <c:choose>
              <c:when test="${empty vo.pwd || sLevel == 0 || sNickName == vo.nickName}">
                <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
              </c:when>
              <c:otherwise>${vo.title}</c:otherwise>
            </c:choose>
            <c:if test="${vo.diffTime <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
          </td>
          <td>${vo.nickName}</td>
          <td>
            <c:choose>
              <c:when test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:when>
              <c:otherwise>${fn:substring(vo.WDate,0,10)}</c:otherwise>
            </c:choose>
          </td>
        </tr>
        <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
      </c:forEach>
    </tbody>
  </table>
  
  <!-- 페이징 -->
  <div class="d-flex justify-content-center">
    <ul class="pagination">
      <!-- 기존 페이징 코드 유지 -->
    </ul>
  </div>
  
  <!-- 검색 폼 -->
  <div class="search-form text-center">
    <form name="searchForm" method="get" action="qnaSearch" class="form-inline justify-content-center">
      <select name="search" class="form-control mr-2" onchange="sChange()">
        <option value="title" selected>글제목</option>
        <option value="nickName">글쓴이</option>
        <option value="content">글내용</option>
      </select>
      <input type="text" name="searchString" class="form-control mr-2"/>
      <button type="button" class="btn btn-secondary" onclick="sCheck()">검색</button>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>