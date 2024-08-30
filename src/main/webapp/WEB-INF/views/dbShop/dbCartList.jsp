<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>dbCartList.jsp(장바구니)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';
    
    // 주문할 총 가격 계산하기
    function onTotal(){
      let total = 0;
      let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  	// 장바구니에 들어있는 체크된 항목만을 총계를 구한다.
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      // 배송비결정(5000원 이상이면 배송비는 0원으로 처리)
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=3000;	// 배송비 3000원처리
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);
    }

		// 상품 체크박스에 상품을 구매하기위해 체크했을때 처리하는 함수
    function onCheck(){
      let minIdx = parseInt(document.getElementById("minIdx").value);				// 출력되어있는 상품중에서 가장 작은 idx값이 minIdx변수에 저장된다.
      let maxIdx = parseInt(document.getElementById("maxIdx").value);				// 출력되어있는 상품중에서 가장 큰  idx값이 maxIdx변수에 저장된다.
      
      // 상품 주문을 위한 체크박스에 체크가 되어있는것에 대한 처리루틴이다.
      // 상품주문 체크박스가 체크되어 있지 않은것에 대한 개수를 emptyCnt에 누적처리하고 있다. 즉, emptyCnt가 0이면 모든 상품이 체크되어 있다는 것으로 '전체체크버튼'을 true로 처리해준다.
      let emptyCnt=0;
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          emptyCnt++;
          break;
        }
      }
      if(emptyCnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// allCheck 체크박스를 체크/해제할때 수행하는 함수
    function allCheck(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      if(document.getElementById("allcheck").checked){
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// 장바구니에서 구매한 상품에 대한 '삭제'처리...
    function cartDelete(idx){
      let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/dbShop/dbCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    
		// 장바구니에서 선택한 상품만 '주문'처리하기
    function order(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){	// 해당 상품이 존재하면서, 구배한다고 체크가 되어있다면...
          document.getElementById("checkItem"+i).value="1";		// 주문을 선택한상품은 'checkItem고유번호'의 값을 1로 셋팅한다.
        }
      }

      document.myform.baesong.value = document.getElementById("baesong").value;		// 배송비
      
      // 장바구니에서 주문품목을 선택하지 않았을때는 메세지 띄우고 다시 장바구니창으로, 주문품목 선택시는 '배송지 입력'창으로 보내준다.
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
    
		// 천단위마다 쉼표처리
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  </script>
  
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f4f4;
      color: #333;
    }
    .container {
      background-color: #ffffff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-top: 20px;
    }
    h2 {
      color: #2c3e50;
      margin-bottom: 30px;
    }
    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 15px;
    }
    .table-dark {
      background-color: #34495e;
      color: #ecf0f1;
    }
    .table-dark th {
      padding: 15px;
      font-size: 16px;
    }
    td {
      background-color: #fff;
      border: 1px solid #e0e0e0;
      border-radius: 4px;
      padding: 15px !important;
    }
    .product-img {
      max-width: 120px;
      border-radius: 4px;
    }
    .product-name {
      color: #e67e22;
      font-weight: bold;
      text-decoration: none;
    }
    .product-name:hover {
      text-decoration: underline;
    }
    .price {
      font-size: 18px;
      color: #2980b9;
    }
    .btn-danger {
      background-color: #e74c3c;
      border: none;
    }
    .btn-danger:hover {
      background-color: #c0392b;
    }
    .totSubBox {
      background-color: #fff;
      border: 1px solid #bdc3c7;
      border-radius: 4px;
      width: 120px;
      text-align: center;
      font-weight: bold;
      padding: 10px 0;
      color: #2c3e50;
      font-size: 16px;
    }
    .order-summary {
      background-color: #34495e;
      color: #ecf0f1;
      padding: 20px;
      border-radius: 8px;
      margin-top: 30px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .order-summary table {
      margin: auto;
    }
    .order-summary th {
      padding: 10px;
      font-size: 18px;
      color: #ffffff;
      background-color: #2c3e50;
      border-radius: 4px;
    }
    .order-summary td {
      vertical-align: middle;
      font-size: 16px;
      color: #ecf0f1;
      padding: 10px;
    }
    .btn-primary, .btn-info {
      padding: 10px 20px;
      font-size: 16px;
      margin: 10px;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container" style="margin-left: 420px;">
  <h2 class="text-center">장바구니</h2>
  <form name="myform" method="post">
    <table>
      <tr class="table-dark">
        <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
        <th colspan="2">상품</th>
        <th colspan="2">총상품금액</th>
      </tr>
      
      <!-- 장바구니 목록출력 -->
      <c:forEach var="listVO" items="${cartListVOS}">
        <tr>
          <td><input type="checkbox" name="idxChecked" id="idx${listVO.idx}" value="${listVO.idx}" onClick="onCheck()" /></td>
          <td><a href="${ctp}/dbShop/dbProductContent?idx=${listVO.productIdx}"><img src="${ctp}/product/${listVO.thumbImg}" class="product-img"/></a></td>
          <td>
            <p>
              모델명 : <a href="${ctp}/dbShop/dbProductContent?idx=${listVO.productIdx}" class="product-name">${listVO.productName}</a><br/>
              <span class="price"><fmt:formatNumber value="${listVO.mainPrice}"/>원</span>
            </p>
            <c:set var="optionNames" value="${fn:split(listVO.optionName,',')}"/>
            <c:set var="optionPrices" value="${fn:split(listVO.optionPrice,',')}"/>
            <c:set var="optionNums" value="${fn:split(listVO.optionNum,',')}"/>
            <p>
              - 주문 내역
              <c:if test="${fn:length(optionNames) > 1}">(기타품목 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
              <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
                ㆍ${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원 / ${optionNums[i]}개<br/>
              </c:forEach> 
            </p>
          </td>
          <td>
            <div class="text-center">
              <b>총 : <fmt:formatNumber value="${listVO.totalPrice}" pattern='#,###원'/></b><br/>
              <span style="color:#270;font-size:12px">주문일자 : ${fn:substring(listVO.cartDate,0,10)}</span>
              <input type="hidden" id="totalPrice${listVO.idx}" value="${listVO.totalPrice}"/>
            </div>
          </td>
          <td>
            <button type="button" onClick="cartDelete(${listVO.idx})" class="btn btn-danger btn-sm">구매취소</button>
            <input type="hidden" name="checkItem" value="0" id="checkItem${listVO.idx}"/>
            <input type="hidden" name="idx" value="${listVO.idx }"/>
            <input type="hidden" name="thumbImg" value="${listVO.thumbImg}"/>
            <input type="hidden" name="productName" value="${listVO.productName}"/>
            <input type="hidden" name="mainPrice" value="${listVO.mainPrice}"/>
            <input type="hidden" name="optionName" value="${optionNames}"/>
            <input type="hidden" name="optionPrice" value="${optionPrices}"/>
            <input type="hidden" name="optionNum" value="${optionNums}"/>
            <input type="hidden" name="totalPrice" value="${listVO.totalPrice}"/>
            <input type="hidden" name="mid" value="${sMid}"/>
          </td>
        </tr>
      </c:forEach>
    </table>
    <c:set var="minIdx" value="${cartListVOS[0].idx}"/>
    <c:set var="maxSize" value="${fn:length(cartListVOS)-1}"/>		
    <c:set var="maxIdx" value="${cartListVOS[maxSize].idx}"/>
    <input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
    <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
    <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
    <input type="hidden" name="baesong"/>
  </form>
  <div class="order-summary">
    <p class="text-center">
      <b>실제 주문총금액</b><br/>
      (구매하실 상품에 체크해 주세요. 총주문금액이 산출됩니다.)<br/>
      5만원 이상 구매하시면 배송비가 면제됩니다.
    </p>
    <table>
      <tr>
        <th>구매상품금액</th>
        <th></th>
        <th>배송비</th>
        <th></th>
        <th>총주문금액</th>
      </tr>
      <tr>
        <td><input type="text" id="total" value="0" class="totSubBox" readonly/></td>
        <td>+</td>
        <td><input type="text" id="baesong" value="0" class="totSubBox" readonly/></td>
        <td>=</td>
        <td><input type="text" id="lastPrice" value="0" class="totSubBox" readonly/></td>
      </tr>
    </table>
  </div>
  <div class="text-center mt-4">
    <button class="btn btn-primary" onClick="order()">주문하기</button>
    <button class="btn btn-info" onClick="location.href='${ctp}/dbShop/dbProductList';">계속 쇼핑하기</button>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>