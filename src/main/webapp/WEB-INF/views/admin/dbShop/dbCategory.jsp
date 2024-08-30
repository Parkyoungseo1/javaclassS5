<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>상품 분류 관리 시스템</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f0f2f5;
    }
    .container {
      max-width: 1200px;
    }
    .category-card {
      background-color: #ffffff;
      border-radius: 15px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 25px;
      margin-bottom: 30px;
      transition: all 0.3s ease;
    }
    .category-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    .category-title {
      color: #3c4858;
      font-weight: 700;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 2px solid #3c4858;
    }
    .btn-category {
      background-color: #3c4858;
      color: #ffffff;
      border: none;
      transition: all 0.3s ease;
    }
    .btn-category:hover {
      background-color: #2c3e50;
      transform: translateY(-2px);
    }
    .table {
      background-color: #ffffff;
      border-radius: 10px;
      overflow: hidden;
    }
    .table thead th {
      background-color: #3c4858;
      color: #ffffff;
      border: none;
    }
    .form-control {
      border-radius: 20px;
    }
    .btn {
      border-radius: 20px;
    }
    .btn-delete {
      background-color: #e74c3c;
      color: #ffffff;
    }
    .btn-delete:hover {
      background-color: #c0392b;
    }
  </style>
  <script>
    'use strict';
    
    // 대분류 등록하기
    function categoryMainCheck() {
    	let categoryMainCode = categoryMainForm.categoryMainCode.value.toUpperCase();
    	let categoryMainName = categoryMainForm.categoryMainName.value;
    	if(categoryMainCode.trim() == "" || categoryMainName.trim() == "") {
    		alert("대분류명(코드)를 입력하세요");
    		categoryMainForm.categoryMainName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMainInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMainName : categoryMainName
    		},
    		success:function(res) {
    			if(res != "0") {
    				alert("대분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 대분류 삭제
    function categoryMainDelete(categoryMainCode) {
    	let ans = confirm("대분류 항복을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/dbShop/categoryMainDelete",
    		type : "post",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(res) {
    			if(res == "0") alert("하위항목이 존재하기에 삭제하실수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			else {
    				alert("대분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  	// 추가: 애니메이션 효과
    $(document).ready(function() {
      $('.category-card').each(function(i) {
        $(this).delay(100 * i).animate({'opacity':'1'}, 500);
      });
    });
  </script>
</head>
<body>
<div class="container mt-5">
  <h1 class="text-center mb-5" style="color: #3c4858;">상품 분류 관리 시스템</h1>
  
  <div class="category-card" style="opacity: 0;">
    <form name="categoryMainForm">
      <h4 class="category-title"><i class="fas fa-layer-group mr-2"></i>술 종류 관리</h4>
      <div class="form-row align-items-center">
        <div class="col-sm-3 my-1">
          <input type="text" class="form-control" name="categoryMainCode" placeholder="알코올">
        </div>
        <div class="col-sm-6 my-1">
          <input type="text" class="form-control" name="categoryMainName" placeholder="종류">
        </div>
        <div class="col-auto my-1">
          <button type="button" class="btn btn-category" onclick="categoryMainCheck()">술 등록</button>
        </div>
      </div>
      <div class="table-responsive mt-3">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>코드</th>
              <th>종류</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="mainVO" items="${mainVOS}">
              <tr>
                <td>${mainVO.categoryMainCode}</td>
                <td>${mainVO.categoryMainName}</td>
                <td>
                  <button type="button" class="btn btn-delete btn-sm" onclick="categoryMainDelete('${mainVO.categoryMainCode}')">
                    <i class="fas fa-trash-alt mr-1"></i>삭제
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </form>
  </div>
</div>
</body>
</html>