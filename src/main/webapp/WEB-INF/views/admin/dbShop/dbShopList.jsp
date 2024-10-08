<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShopList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';
    
    $(function(){
			let slider = document.getElementById("price");
			let output = document.getElementById("demo");
			output.innerHTML = slider.value;
			
			slider.oninput = function() {
			  output.innerHTML = this.value;
			}
    });
    
    function slideCheck() {
    	let mainPrice = document.getElementById("price").value;
    	alert(mainPrice);
    	location.href = "dbShopList?mainPrice="+mainPrice;
    }
	</script>
	<style>
		.slider:hover {
		  opacity: 1;
		}
	</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <span>[<a href="${ctp}/dbShop/dbShopList">전체보기</a>]</span> /
  <c:forEach var="subTitle" items="${subTitleVOS}" varStatus="st">
  	<span>[<a href="${ctp}/dbShop/dbShopList?part=${subTitle.categoryMainName}">${subTitle.categoryMainName}</a>]</span>
	  <c:if test="${!st.last}"> / </c:if>
  </c:forEach>
  <hr/>
  <div>
		<input type="range" min="0" max="3000000" step="70000" name="price" id="price" value="${price}" class="slider" onchange="slideCheck()" style="width:550px">
		<div class="row text-center ml-1" style="width:550px">
		  <div class="col"><fmt:formatNumber value="280000" /></div>
		  <div class="col"><fmt:formatNumber value="1000000" /></div>
		  <div class="col"><fmt:formatNumber value="1500000" /></div>
		  <div class="col"><fmt:formatNumber value="2100000" /></div>
		  <div class="col"><fmt:formatNumber value="2700000" /></div>
		</div>
	</div>
	<br/>
	<p class="text-center" style="width:600px">선택금액: <c:if test="${price == 0}">전체보기</c:if><c:if test="${price != 0}">0 ~ <span id="demo"></span>원</c:if></p>
  <hr/>
  <div class="row">
    <div class="col">
	    <h4>상품 리스트 : <font color="brown"><b>${part}</b></font></h4>
    </div>
    <div class="col text-right">
		  <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbProduct';">상품등록하러가기</button>
    </div>
  </div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVOS}">
      <div class="col-md-4">
        <div style="text-align:center" class="mt-1">
          <a href="${ctp}/dbShop/dbShopContent?idx=${vo.idx}">
            <img src="${ctp}/product/${vo.FSName}" width="200px" height="180px"/>
            <div><font size="2">${vo.productName}</font></div>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></div>
            <div><font size="2">${vo.detail}</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>i
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(productVOS) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
  <div class="text-right">
	  <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbProduct';">상품등록하러가기</button>
  </div>
</div>
<p><br/></p>
</body>
</html>