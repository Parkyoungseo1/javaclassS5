<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    $(document).ready(function(){
      $(".nav-tabs a").click(function(){
        $(this).tab('show');
      });
      $('.nav-tabs a').on('shown.bs.tab', function(event){
        var x = $(event.target).text();
        var y = $(event.relatedTarget).text();
      });
    });

    function order() {
      var paymentCard = document.getElementById("paymentCard").value;
      var payMethodCard = document.getElementById("payMethodCard").value;
      var paymentBank = document.getElementById("paymentBank").value;
      var payMethodBank = document.getElementById("payMethodBank").value;
      if(paymentCard == "" && paymentBank == "") {
        alert("결제방식과 결제번호를 입력하세요.");
        return false;
      }
      if(paymentCard != "" && payMethodCard == "") {
        alert("카드번호를 입력하세요.");
        document.getElementById("payMethodCard").focus();
        return false;
      }
      else if(paymentBank != "" && payMethodBank == "") {
        alert("입금자명을 입력하세요.");
        return false;
      }
      var ans = confirm("결재하시겠습니까?");
      if(ans) {
        if(paymentCard != "" && payMethodCard != "") {
          document.getElementById("payment").value = "C"+paymentCard;
          document.getElementById("payMethod").value = payMethodCard;
        }
        else {
          document.getElementById("payment").value = "B"+paymentBank;
          document.getElementById("payMethod").value = payMethodBank;
        }
        myform.action = "${ctp}/dbShop/payment";
        myform.submit();
      }
    }
  </script>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f4f4;
      color: #333;
    }
    .container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 20px;
      margin-top: 20px;
    }
    h2 {
      color: #2c3e50;
      margin-bottom: 20px;
    }
    .table {
      background-color: #fff;
    }
    .table-dark {
      background-color: #34495e;
      color: #ecf0f1;
    }
    .table-bordered {
      border-color: #bdc3c7;
    }
    .text-center {
      text-align: center;
    }
    .btn {
      margin: 5px;
      transition: all 0.3s;
    }
    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    }
    .form-control {
      border-radius: 4px;
    }
    .nav-tabs {
      border-bottom: 2px solid #3498db;
    }
    .nav-tabs .nav-link {
      border: none;
      color: #3498db;
      font-weight: bold;
    }
    .nav-tabs .nav-link.active {
      border-bottom: 2px solid #3498db;
      color: #2c3e50;
    }
    .tab-content {
      padding: 20px;
      background-color: #fff;
      border-radius: 0 0 8px 8px;
    }
    select, input[type="text"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #bdc3c7;
      border-radius: 4px;
    }
    img {
      border-radius: 4px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">주문 / 결제</h2>
  <div class="text-center">(배송지 정보를 확인후 결제처리합니다.)</div>
  <br/>
  <table class="table table-bordered text-center">
    <tr class="table-dark">
      <th colspan="2">상 품</th>
      <th>총상품금액</th>
    </tr>

    <c:set var="orderTotalPrice" value="0"/>
    <c:forEach var="vo" items="${sOrderVOS}">
      <tr>
        <td><img src="${ctp}/product/${vo.thumbImg}" width="150px"/></td>
        <td class="text-left">
          <p><br/>주문번호 : ${vo.orderIdx}</p>
          <p class="text-center"><br/>
            모델명 : <span style="color:#e67e22;font-weight:bold;">${vo.productName}</span><br/>
            &nbsp; <b><fmt:formatNumber value="${vo.mainPrice}"/>원</b>
          </p><br/>
          <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
          <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
          <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
          <p>
            - 주문 옵션 내역 : 총 ${fn:length(optionNames)}개<br/>
            <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
              &nbsp; &nbsp;ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
            </c:forEach>
          </p>
        </td>
        <td>
          <b>총 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/></b><br/><br/>
        </td>
      </tr>
      <c:set var="orderTotalPrice" value="${orderTotalPrice + vo.totalPrice}"/>
    </c:forEach>
  </table>
  <div class="alert alert-info text-center">
    <b>총 주문(결재) 금액</b> : 상품가격(<fmt:formatNumber value="${orderTotalPrice}" pattern='#,###원'/>) +
                    배송비(<fmt:formatNumber value="${sOrderVOS[0].baesong}" pattern='#,###원'/>) =
                    총 <font size="5" color="#e74c3c"><b><fmt:formatNumber value="${orderTotalPrice + sOrderVOS[0].baesong}" pattern='#,###'/></b></font>원
  </div>
  <p><br/></p>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr class="table-primary">
        <th colspan="2" class="text-center">
          <h3>배송지 정보 / 결재수단</h3>
        </th>
      </tr>
      <tr>
        <th width="40%">구매자이름</th>
        <td><input type="text" name="buyer_name" value="${memberVO.name}" readonly class="form-control"/></td>
      </tr>
      <tr>
        <th>구매자메일주소(결제결과받는곳)</th>
        <td><input type="text" name="buyer_email" value="${memberVO.email}" class="form-control"/></td>
      </tr>
      <tr>
        <th>구매자전화번호</th>
        <td><input type="text" name="buyer_tel" value="${memberVO.tel}" class="form-control"/></td>
      </tr>
      <tr>
        <th>구매자주소</th>
        <c:set var="addr" value="${fn:split(memberVO.address,'/')}"/>
        <td>
          <input type="text" name="buyer_postcode" value="${addr[0]}" class="form-control mb-2"/>
          <input type="text" name="buyer_addr" value="${addr[1]} ${addr[2]} ${addr[3]}" class="form-control"/>
        </td>
      </tr>
      <tr>
        <th>배송시요청사항</th>
        <td>
          <select name="message" class="form-control">
            <option>부재중 경비실에 맡겨주세요.</option>
            <option>빠른 배송부탁합니다.</option>
            <option>부재중 현관문 앞에 놓아주세요.</option>
            <option>부재중 전달해주지 마세요.</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>처리될 총 결제금액(테스트자료 10원)</th>
        <td><input type="text" name="amount" value="10" class="form-control" readonly /></td>
      </tr>
    </table>
    <hr/>

    <ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결제</a></li>
      <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결제</a></li>
      <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
    </ul>

    <div class="tab-content">
      <div id="card" class="container tab-pane active"><br>
        <h3>카드결제</h3>
        <p>
          <select name="paymentCard" id="paymentCard" class="form-control">
            <option value="">카드선택</option>
            <option>국민카드</option>
            <option selected>현대카드</option>
            <option>신한카드</option>
            <option>농협카드</option>
            <option>BC카드</option>
            <option>롯데카드</option>
            <option>삼성카드</option>
            <option>LG카드</option>
          </select>
        </p>
        <p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard" value="1234-1234-1234" class="form-control"/></p>
      </div>
      <div id="bank" class="container tab-pane fade"><br>
        <h3>은행결재(무통장입금)</h3>
        <p>
          <select name="paymentBank" id="paymentBank" class="form-control">
            <option value="">은행선택</option>
            <option value="국민은행">국민(111-111-111)</option>
            <option value="신한은행">신한(222-222-222)</option>
            <option value="우리은행">우리(333-333-333)</option>
            <option value="농협">농협(444-444-444)</option>
            <option value="신협">신협(555-555-555)</option>
          </select>
        </p>
        <p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank" class="form-control"/></p>
      </div>
      <div id="telCheck" class="container tab-pane fade"><br>
        <h3>전화상담</h3>
        <p>콜센터(☎) : 02-1234-1234</p>
      </div>
    </div>
    <hr/>
    <div class="text-center">
      <button type="button" class="btn btn-primary" onClick="order()">결제하기</button>
      <button type="button" class="btn btn-info" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보기</button>
      <button type="button" class="btn btn-success" onClick="location.href='${ctp}/dbShop/dbProductList';">계속 쇼핑하기</button>
    </div>
    <input type="hidden" name="orderVos" value="${orderVos}"/>
    <input type="hidden" name="orderIdx" value="${orderIdx}"/>
    <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="payment" id="payment"/>
    <input type="hidden" name="payMethod" id="payMethod"/>
    <input type="hidden" name="name" value="${sOrderVOS[0].productName}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>