<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>alcoholContent.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function alcoholDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "alcoholDelete?idx=${vo.idx}";
    }
    
    // 좋아요 처리(중복허용)
    function goodCheck() {
    	$.ajax({
    		url  : "AlcoholGoodCheck.bo",
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
    
    // 좋아요 처리(중복불허)
    function goodCheck2() {
    	$.ajax({
    		url  : "AlcoholGoodCheck2.bo",
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
    
    // 좋아요(따봉)수 증가 처리(중복허용)
    function goodCheckPlus() {
    	$.ajax({
    		url  : "AlcoholGoodCheckPlusMinus.bo",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : +1
    		},
    		success:function(res) {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 좋아요(따봉)수 감소 처리(중복허용)
    function goodCheckMinus() {
    	$.ajax({
    		url  : "AlcoholGoodCheckPlusMinus.bo",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : -1
    		},
    		success:function(res) {
    			if(res != "0") location.reload();
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
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">글 내 용 보 기</h2>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.mid}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
      <th>가격</th>
      <td>${vo.price}</td>
    </tr>
    <tr>
    	<th>술 종류</th>
      <td>${vo.part}</td>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title} (<a href="javascript:goodCheck()">❤</a> : ${vo.good}) /
        <a href="javascript:goodCheckPlus()">👍</a> &nbsp;
        <a href="javascript:goodCheckMinus()">👎</a> /
        (<a href="javascript:goodCheck2()"><font color="blue" size="5">♥</font></a> : ${vo.good})
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4">
        <div class="row">
	        <div class="col">
	        	<c:if test="${empty flag}"><input type="button" value="돌아가기" onclick="location.href='alcoholList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning" /></c:if>
	        	<c:if test="${!empty flag}"><input type="button" value="돌아가기" onclick="location.href='alcoholSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning" /></c:if>
	        </div>
	         <div class="col text-right">
			        <input type="button" value="수정" onclick="location.href='alcoholUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary" />
			        <input type="button" value="삭제" onclick="alcoholDelete()" class="btn btn-danger text-right" />
		        </div>
        </div>
      </td>
    </tr>
  </table>
  <hr/>
  <!-- 이전글/ 다음글 출력하기 -->
  <table class="table table-borderless">
    <tr>
      <td>
        <c:if test="${!empty nextVo.title}">
          ☝ <a href="alcoholContent?idx=${nextVo.idx}">다음글 : ${nextVo.title}</a><br/>
        </c:if>
        <c:if test="${!empty preVo.title}">
        	👇 <a href="alcoholContent?idx=${preVo.idx}">이전글 : ${preVo.title}</a><br/>
        </c:if>
      </td>
    </tr>
  </table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>