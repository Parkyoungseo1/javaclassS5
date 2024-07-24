<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품등록 - dbProduct.jsp</title>
    <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .custom-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
            margin-bottom: 50px;
        }
        .form-group label {
            font-weight: bold;
            color: #495057;
        }
        .btn-custom {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 30px;
            font-size: 18px;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .form-control:focus, .custom-select:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .custom-file-label::after {
            content: "파일 선택";
        }
    </style>
    <script>
    'use strict';
    
    // 상품 등록하기전에 체크후 전송...
    function fCheck() {
    	let categoryMainCode = myform.categoryMainCode.value;
    	let categoryMiddleCode = myform.categoryMiddleCode.value;
    	let categorySubCode = myform.categorySubCode.value;
    	let productName = myform.productName.value;
			let mainPrice = myform.mainPrice.value;
			let detail = myform.detail.value;
			let file = myform.file.value;	
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();
			let regExpPrice = /^[0-9|_]*$/;
			
			if(categorySubCode == "") {
				alert("상품 소분류(세분류)를 입력하세요!");
				return false;
			}
			else if(product == "") {
				alert("상품명(모델명)을 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 메인 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(detail == "") {
				alert("상품의 초기 설명을 입력하세요");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
    }
    
    // 상품 입력창에서 대분류 선택(onChange)시 중분류를 가져와서 중분류 선택박스에 뿌리기
    function categoryMainChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categoryMiddleName",
				data : {categoryMainCode : categoryMainCode},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categoryMiddleCode+"'>"+data[i].categoryMiddleName+"</option>";
					}
					$("#categoryMiddleCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 중분류 선택시 소분류항목 가져오기
    function categoryMiddleChange() {
    	var categoryMainCode = myform.categoryMainCode.value;
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/dbShop/categorySubName",
				data : {
					categoryMainCode : categoryMainCode,
					categoryMiddleCode : categoryMiddleCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
					}
					$("#categorySubCode").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
  </script>
</head>
<body>
    <div class="container custom-container">
        <h2 class="text-center mb-5">상품 등록</h2>
        <form name="myform" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <div class="form-group">
                        <label for="categoryMainCode">대분류</label>
                        <select id="categoryMainCode" name="categoryMainCode" class="custom-select" onchange="categoryMainChange()">
                            <option value="">대분류를 선택하세요</option>
                            <c:forEach var="mainVo" items="${mainVos}">
                                <option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="form-group">
                        <label for="categoryMiddleCode">중분류</label>
                        <select id="categoryMiddleCode" name="categoryMiddleCode" class="custom-select" onchange="categoryMiddleChange()">
                            <option value="">중분류명</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="form-group">
                        <label for="categorySubCode">소분류</label>
                        <select id="categorySubCode" name="categorySubCode" class="custom-select">
                            <option value="">소분류명</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="productName">상품(모델)명</label>
                <input type="text" name="productName" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요" required />
            </div>
            <div class="form-group">
                <label for="file">메인이미지</label>
                <div class="custom-file">
                    <input type="file" name="file" id="file" class="custom-file-input" accept=".jpg,.gif,.png,.jpeg" required />
                    <label class="custom-file-label" for="file">파일 선택</label>
                </div>
                <small class="form-text text-muted">업로드 가능파일: jpg, jpeg, gif, png</small>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="form-group">
                        <label for="mainPrice">상품기본가격</label>
                        <input type="text" name="mainPrice" id="mainPrice" class="form-control" required />
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div class="form-group">
                        <label for="detail">상품기본설명</label>
                        <input type="text" name="detail" id="detail" class="form-control" required />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="content">상품상세설명</label>
                <textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
            </div>
            <script>
                CKEDITOR.replace("content", {
                    uploadUrl: "${ctp}/imageUpload",
                    filebrowserUploadUrl: "${ctp}/imageUpload",
                    height: 400
                });
            </script>
            <div class="text-center mt-5">
                <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-custom btn-lg"/>
            </div>
        </form>
    </div>
    <script>
        // 파일 입력 필드의 레이블 업데이트
        $(".custom-file-input").on("change", function() {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>
</body>
</html>