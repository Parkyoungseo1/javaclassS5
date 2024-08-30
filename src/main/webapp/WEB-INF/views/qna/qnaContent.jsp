<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qnaContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
    body {
      background-color: #f0f2f5;
    }
    .container {
      background-color: white;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      padding: 40px;
      margin-top: 50px;
      border: 2px solid #e1e4e8;
    }
    h2 {
      color: #2c3e50;
      margin-bottom: 30px;
      text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
      font-weight: bold;
    }
    .card {
      border: none;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .card-header {
      background: linear-gradient(to right, #3498db, #2980b9);
      color: white;
      font-weight: bold;
      border-top-left-radius: 15px;
      border-top-right-radius: 15px;
    }
    .table {
      margin-bottom: 0;
    }
    .table th {
      background-color: #f8f9fa;
      color: #2c3e50;
      font-weight: 600;
      border-bottom: 2px solid #dee2e6;
    }
    .table td {
      vertical-align: middle;
      border-bottom: 1px solid #dee2e6;
    }
    .btn {
      border-radius: 25px;
      padding: 10px 25px;
      font-weight: bold;
      text-transform: uppercase;
      transition: all 0.3s ease;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 8px rgba(0,0,0,0.15);
    }
    #reply {
      margin-top: 40px;
    }
  </style>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
  <h2 class="text-center">글 내용 보기</h2>
  <div class="card">
    <div class="card-header py-3">
      <h5 class="mb-0">글 정보</h5>
    </div>
    <div class="card-body">
      <table class="table">
        <tr>
          <th width="20%">글쓴이</th>
          <td>${vo.nickName}</td>
          <th width="20%">글쓴날짜</th>
          <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-3)}</td>
        </tr>
        <tr>
          <th>Email</th>
          <td colspan="3">${vo.email}</td>
        </tr>
        <c:if test="${vo.qnaSw == 'a'}">
          <tr>
            <th>원본글제목</th>
            <td colspan="3">${title}</td>
          </tr>
        </c:if>
        <tr>
          <th>글제목</th>
          <td colspan="3">${vo.title}</td>
        </tr>
        <tr>
          <th>글내용</th>
          <td colspan="3" style="height:200px;">${fn:replace(vo.content,newLine,"<br/>")}</td>
        </tr>
      </table>
    </div>
    <div class="card-footer text-center py-3">
      <c:if test="${sLevel == '0' || !fn:contains(vo.title,'현재 삭제된 글입니다.')}">
        <c:if test="${vo.qnaSw == 'q'}">
          <button type="button" onclick="answerCheck()" class="btn btn-success">답변</button>
        </c:if>
        <c:if test="${sNickName eq vo.nickName || sLevel == '0'}">
          <c:if test="${sLevel != '0' && vo.qnaSw == 'q'}">
            <button type="button" onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-primary">수정</button>
          </c:if>
          <button type="button" onclick="delCheck(${vo.idx})" class="btn btn-danger">삭제</button>
        </c:if>
      </c:if>
      <button type="button" onclick="location.href='qnaList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning">돌아가기</button>
    </div>
  </div>
  
  <form name="myform" method="post" action="qnaInput">
    <div id="reply"></div>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <input type="hidden" name="mid" value="${vo.mid}"/>
  </form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>