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
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
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
    
    // 중분류 등록하기
    function categoryMiddleCheck() {
    	let categoryMainCode = categoryMiddleForm.categoryMainCode.value;
    	let categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
    	let categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
    	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categoryMiddleName.trim() == "") {
    		alert("대분류명(코드)를 입력하세요");
    		categoryMiddleForm.categoryMiddleName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categoryMiddleName : categoryMiddleName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("중분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 중분류 삭제
    function categoryMiddleDelete(categoryMiddleCode) {
    	let ans = confirm("중분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleDelete",
    		data : {categoryMiddleCode : categoryMiddleCode},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("중분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 입력창에서 대분류 선택시에 중분류 자동 조회하기
    function categoryMainChange() {
    	let categoryMainCode = categorySubForm.categoryMainCode.value;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleName",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(vos) {
    			let str = '';
    			str += '<option value="">중분류선택</option>'
    			for(let i=0; i<vos.length; i++) {
    				str += '<option value="'+vos[i].categoryMiddleCode+'">'+vos[i].categoryMiddleName+'</option>';
    			}
    			$("#categoryMiddleCode").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 등록하기
    function categorySubCheck() {
    	let categoryMainCode = categorySubForm.categoryMainCode.value;
    	let categoryMiddleCode = categorySubForm.categoryMiddleCode.value;
    	let categorySubCode = categorySubForm.categorySubCode.value;
    	let categorySubName = categorySubForm.categorySubName.value;
    	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categorySubCode.trim() == "" || categorySubName.trim() == "") {
    		alert("소분류명(코드)를 입력하세요");
    		categorySubForm.categorySubName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categorySubInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode,
    			categorySubName : categorySubName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("소분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 소분류 삭제하기
    function categorySubDelete(categoryMainCode, categoryMiddleCode, categorySubCode) {
    	let ans = confirm("소분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categorySubDelete",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode
    		},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("소분류 항목이 삭제 되었습니다.");
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
      <h4 class="category-title"><i class="fas fa-layer-group mr-2"></i>대분류(제조사) 관리</h4>
      <div class="form-row align-items-center">
        <div class="col-sm-3 my-1">
          <input type="text" class="form-control" name="categoryMainCode" maxlength="1" placeholder="대분류 코드">
        </div>
        <div class="col-sm-6 my-1">
          <input type="text" class="form-control" name="categoryMainName" placeholder="대분류명">
        </div>
        <div class="col-auto my-1">
          <button type="button" class="btn btn-category" onclick="categoryMainCheck()">대분류 등록</button>
        </div>
      </div>
      <div class="table-responsive mt-3">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>코드</th>
              <th>대분류명</th>
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
  
  <div class="category-card" style="opacity: 0;">
    <form name="categoryMiddleForm">
      <h4 class="category-title"><i class="fas fa-sitemap mr-2"></i>중분류(상품분류) 관리</h4>
      <div class="form-row align-items-center">
        <div class="col-sm-3 my-1">
          <select name="categoryMainCode" class="form-control">
            <option value="">대분류 선택</option>
            <c:forEach var="mainVO" items="${mainVOS}">
              <option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-sm-2 my-1">
          <input type="text" class="form-control" name="categoryMiddleCode" maxlength="2" placeholder="중분류 코드">
        </div>
        <div class="col-sm-4 my-1">
          <input type="text" class="form-control" name="categoryMiddleName" placeholder="중분류명">
        </div>
        <div class="col-auto my-1">
          <button type="button" class="btn btn-category" onclick="categoryMiddleCheck()">중분류 등록</button>
        </div>
      </div>
      <div class="table-responsive mt-3">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>코드</th>
              <th>중분류명</th>
              <th>대분류명</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="middleVO" items="${middleVOS}">
              <tr>
                <td>${middleVO.categoryMiddleCode}</td>
                <td>${middleVO.categoryMiddleName}</td>
                <td>${middleVO.categoryMainName}</td>
                <td>
                  <button type="button" class="btn btn-delete btn-sm" onclick="categoryMiddleDelete('${middleVO.categoryMiddleCode}')">
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
  
  <div class="category-card" style="opacity: 0;">
    <form name="categorySubForm">
      <h4 class="category-title"><i class="fas fa-list mr-2"></i>소분류(상품군) 관리</h4>
      <div class="form-row align-items-center">
        <div class="col-sm-3 my-1">
          <select name="categoryMainCode" class="form-control" onchange="categoryMainChange()">
            <option value="">대분류 선택</option>
            <c:forEach var="mainVO" items="${mainVOS}">
              <option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-sm-3 my-1">
          <select name="categoryMiddleCode" id="categoryMiddleCode" class="form-control">
            <option value="">중분류 선택</option>
          </select>
        </div>
        <div class="col-sm-2 my-1">
          <input type="text" class="form-control" name="categorySubCode" maxlength="3" placeholder="소분류 코드">
        </div>
        <div class="col-sm-2 my-1">
          <input type="text" class="form-control" name="categorySubName" placeholder="소분류명">
        </div>
        <div class="col-auto my-1">
          <button type="button" class="btn btn-category" onclick="categorySubCheck()">소분류 등록</button>
        </div>
      </div>
      <div class="table-responsive mt-3">
        <table class="table table-hover">
          <thead>
            <tr>
              <th>코드</th>
              <th>소분류명</th>
              <th>중분류명</th>
              <th>대분류명</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="subVO" items="${subVOS}">
              <tr>
                <td>${subVO.categorySubCode}</td>
                <td>${subVO.categorySubName}</td>
                <td>${subVO.categoryMiddleName}</td>
                <td>${subVO.categoryMainName}</td>
                <td>
                  <button type="button" class="btn btn-delete btn-sm" onclick="categorySubDelete('${subVO.categoryMainCode}','${subVO.categoryMiddleCode}','${subVO.categorySubCode}')">
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