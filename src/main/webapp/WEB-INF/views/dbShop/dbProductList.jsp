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
  <title>dbProductList.jsp</title>
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
      location.href = "dbProductList?mainPrice="+mainPrice;
    }
  </script>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
    }
    .container {
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-top: 20px;
    }
    h4 {
      color: #333;
      border-bottom: 2px solid #007bff;
      padding-bottom: 10px;
    }
    .category-nav {
      margin-bottom: 20px;
    }
    .category-nav a {
      display: inline-block;
      margin: 5px;
      padding: 5px 10px;
      background-color: #007bff;
      color: #fff;
      text-decoration: none;
      border-radius: 5px;
      transition: background-color 0.3s;
    }
    .category-nav a:hover {
      background-color: #0056b3;
    }
    .slider {
      -webkit-appearance: none;
      width: 100%;
      height: 15px;
      border-radius: 5px;
      background: #d3d3d3;
      outline: none;
      opacity: 0.7;
      transition: opacity .2s;
    }
    .slider::-webkit-slider-thumb {
      -webkit-appearance: none;
      appearance: none;
      width: 25px;
      height: 25px;
      border-radius: 50%;
      background: #007bff;
      cursor: pointer;
    }
    .slider::-moz-range-thumb {
      width: 25px;
      height: 25px;
      border-radius: 50%;
      background: #007bff;
      cursor: pointer;
    }
    .product-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      transition: transform 0.3s;
    }
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .product-card img {
      width: 100%;
      height: 300px;
      object-fit: cover;
      border-radius: 8px;
    }
    .product-info {
      margin-top: 10px;
    }
    .product-name {
      font-weight: bold;
      color: #333;
    }
    .product-price {
      color: #e74c3c;
      font-weight: bold;
    }
    .btn-primary {
      background-color: #007bff;
      border: none;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container" style="margin-left: 400px;">
  <div class="category-nav">
    <span>[<a href="${ctp}/dbShop/dbProductList">전체보기</a>]</span> /
    <c:forEach var="subTitle" items="${subTitleVOS}" varStatus="st">
      <span>[<a href="${ctp}/dbShop/dbProductList?part=${subTitle.categorySubName}">${subTitle.categorySubName}</a>]</span>
      <c:if test="${!st.last}"> / </c:if>
    </c:forEach>
  </div>
  <hr/>
  <div>
    <input type="range" min="0" max="3000000" step="300000" value="${price}" class="slider" id="price" onchange="slideCheck()" style="width:100%">
    <div class="row text-center mt-2">
      <div class="col"><fmt:formatNumber value="300000" /></div>
      <div class="col"><fmt:formatNumber value="900000" /></div>
      <div class="col"><fmt:formatNumber value="1500000" /></div>
      <div class="col"><fmt:formatNumber value="2100000" /></div>
      <div class="col"><fmt:formatNumber value="2700000" /></div>
    </div>
  </div>
  <br/>
  <p class="text-center">선택금액: <c:if test="${price == 0}">전체보기</c:if><c:if test="${price != 0}">0 ~ <span id="demo"></span>원</c:if></p>
  <hr/>
  <div class="row">
    <div class="col">
      <h4>상품 리스트 : <font color="brown"><b>${part}</b></font></h4>
    </div>
    <div class="col text-right">
      <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보러가기</button>
    </div>
  </div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVOS}">
      <div class="col-md-4">
        <div class="product-card">
          <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
            <img src="${ctp}/product/${vo.FSName}" alt="${vo.productName}"/>
            <div class="product-info">
              <div class="product-name">${vo.productName}</div>
              <div class="product-price"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</div>
              <div>${vo.detail}</div>
            </div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(productVOS) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
  <div class="text-right">
    <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보러가기</button>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>