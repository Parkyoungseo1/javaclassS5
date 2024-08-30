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
            background-color: #f0f2f5;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .custom-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 50px;
            margin-bottom: 50px;
        }
        h2 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-group label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 10px;
        }
        .form-control, .custom-select {
            border-radius: 8px;
            border: 1px solid #bdc3c7;
            padding: 12px 15px;
            height: auto;
            font-size: 16px;
        }
        .form-control:focus, .custom-select:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        .btn-custom {
            background-color: #3498db;
            border-color: #3498db;
            padding: 12px 30px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s;
        }
        .btn-custom:hover {
            background-color: #2980b9;
            border-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .custom-file-label {
            border-radius: 8px;
            height: auto;
            padding: 12px 15px;
            line-height: 1.5;
        }
        .custom-file-label::after {
            height: 100%;
            padding: 12px 15px;
            line-height: 1.5;
            content: "파일 선택";
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            background-color: #f8f9fa;
        }
        .card-header {
            background-color: #e9ecef;
            border-bottom: none;
            font-weight: 600;
            padding: 15px 20px;
            border-radius: 15px 15px 0 0;
        }
        .card-body {
            padding: 20px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        textarea.form-control {
            min-height: 120px;
        }
    </style>
    <script>
    'use strict';
    
    function fCheck() {
    	let categoryMainCode = myform.categoryMainCode.value;
    	let productName = myform.productName.value;
		let mainPrice = myform.mainPrice.value;
		let detail = myform.detail.value;
		let file = myform.file.value;	
		let ext = file.substring(file.lastIndexOf(".")+1);
		let uExt = ext.toUpperCase();
		let regExpPrice = /^[0-9|_]*$/;
		
		if(productName == "") {
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
    </script>
</head>
<body>
    <div class="container custom-container">
        <h2>상품 등록</h2>
        <form name="myform" method="post" enctype="multipart/form-data">
            <div class="card">
                <div class="card-header">카테고리 선택</div>
                <div class="card-body">
                    <div class="form-group">
                        <label for="categoryMainCode">술 분류</label>
                        <select id="categoryMainCode" name="categoryMainCode" class="custom-select">
                            <option value="">술 종류를 선택하세요</option>
                            <c:forEach var="mainVo" items="${mainVos}">
                            	<option value="${mainVo.categoryMainCode}">${mainVo.categoryMainName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">상품 정보</div>
                <div class="card-body">
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
                        <%-- <small class="form-text text-muted">업로드 가능파일: jpg, jpeg, gif, png</small> --%>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="mainPrice">상품기본가격</label>
                                <input type="text" name="mainPrice" id="mainPrice" class="form-control" required />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="detail">상품기본설명</label>
                                <input type="text" name="detail" id="detail" class="form-control" required />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">상품 상세 설명</div>
                <div class="card-body">
                    <div class="form-group">
                        <textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
                    </div>
                </div>
            </div>
            <script>
                CKEDITOR.replace("content", {
                    uploadUrl: "${ctp}/imageUpload",
                    filebrowserUploadUrl: "${ctp}/imageUpload",
                    height: 400
                });
            </script>
            <div class="text-center mt-4">
                <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-custom btn-lg"/>
            </div>
        </form>
    </div>
    <script>
        $(".custom-file-input").on("change", function() {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>
</body>
</html>