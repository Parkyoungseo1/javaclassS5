<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>complaintList.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';

    function complaintCheck(part, partIdx, complaint) {
      $.ajax({
        url: "ComplaintCheck.ad",
        type: "post",
        data: {
          part: part,
          partIdx: partIdx,
          complaint: complaint
        },
        success: function() {
          location.reload();
        },
        error: function() {
          alert("전송오류!");
        }
      });
    }

    function deleteComplaint(idx) {
      if (confirm("정말로 이 신고를 삭제하시겠습니까?")) {
        $.ajax({
          url: "DeleteComplaint.ad",
          type: "post",
          data: { idx : idx},
          success: function(res) {
            if(res != "0") {
               alert("삭제 삭제 되었습니다.");
               location.reload();
            }
            else alert("삭제 실패!");
          },
          error: function() {
            alert("전송오류!");
          }
        });
      }
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">신 고 리 스 트</h2>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>분류</th>
      <th>신고자</th>
      <th>신고내역</th>
      <th>신고날짜</th>
      <!-- <th>표시여부</th> -->
      <th>삭제</th>
    </tr>
    <c:set var="complaintCnt" value="${complaintCnt}" />
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${vo.idx}</td>
        <td>${vo.part}</td>
        <td>${vo.cpMid}</td>
        <td>${vo.cpContent}</td>
        <td>${vo.cpDate}</td>
        <%-- <td>
          <a href="javascript:complaintCheck('${vo.part}','${vo.partIdx}','${vo.complaint}')">${vo.complaint == 'NO' ? '표시중' : '감추기'}</a>
        </td> --%>
        <td>
          <button onclick="deleteComplaint(${vo.idx})" class="btn btn-danger btn-sm">삭제</button>
        </td>
        <c:set var="complaintCnt" value="${complaintCnt - 1}" />
      </tr>
    </c:forEach>
    <tr><td colspan="9" class="m-0 p-0"></td></tr>
  </table>
</div>
<p><br/></p>
</body>
</html>