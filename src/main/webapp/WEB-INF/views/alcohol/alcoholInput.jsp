<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add New Product</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
   <style>
    body {
      background-color: #f8f9fa;
      color: #333;
      font-family: 'Arial', sans-serif;
    }
    .container {
      background-color: #ffffff;
      border-radius: 15px;
      padding: 30px;
      margin-top: 30px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    h2 {
      color: #007bff;
      text-transform: uppercase;
      letter-spacing: 2px;
      margin-bottom: 30px;
    }
    .form-control {
      border-radius: 0;
      border: 1px solid #ced4da;
    }
    .form-control:focus {
      box-shadow: none;
      border-color: #007bff;
    }
    .btn-custom {
      background-color: #007bff;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      transition: background-color 0.3s ease;
    }
    .btn-custom:hover {
      background-color: #0056b3;
    }
    .form-group label {
      font-weight: bold;
      color: #495057;
    }
    
   
  </style>
	<script>
    'use strict';
    
    function fCheck() {
    	let file = document.getElementById("file").value;
    	let ext = file.substring(file.lastIndexOf(".")+1).toLowerCase();
    	let maxSize = 1024 * 1024 * 10;
    	
    	if(file.trim() == "") {
    		alert("업로드할 파일을 선택하세요.");
    		return false;
    	}
    	
    	let fileSize = document.getElementById("file").files[0].size;
    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'tiff') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/tiff'만 가능합니다.");
    		return false;
    	}
    	if(fileSize > maxSize) {
    		alert("업로드 파일의 최대용량은 20MByte입니다.");
    		return false;
    	}
    	
  		myform.submit();
  		
    }
  </script>  
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center">Add New Product</h2>
  <form name="myform" method="post" enctype="multipart/form-data">
    <div class="form-group">
      <label for="mid">글쓴이</label>
      <input type="text" name="mid" id="mid" class="form-control" value="${sMid}" readonly  />
    </div>
    <div class="form-group">
      <label for="title">술 이름</label>
      <input type="text" name="title" id="title" placeholder="Enter product name" autofocus required class="form-control" />
    </div>
    <div class="form-group">
      <label for="part">술 종류</label>
      <select name="part" id="part" class="form-control">
        <option>Whiskey</option>
        <option ${part=="Liqueur" ? "selected" : ""}>Liqueur</option>
        <option ${part=="Wine" ? "selected" : ""}>Wine</option>
        <option ${part=="Makgeolli" ? "selected" : ""}>Makgeolli</option>
        <option ${part=="Highball" ? "selected" : ""}>Highball</option>
        <option ${part=="Cocktail" ? "selected" : ""}>Cocktail</option>
        <option ${part=="etc" ? "selected" : ""}>etc</option>
      </select>
    </div>
    <div class="form-group">
      <label for="price">가격</label>
      <input type="number" name="price" id="price" placeholder="Enter price" required class="form-control" />
    </div>
    <div class="form-group">
      <label for="thumbnail">썸네일</label>
      <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.tiff" />
    </div>
      <div>글내용
        <textarea name="content" id="CKEDITOR" rows="6" class="form-control" required>${vo.content}</textarea>
				<script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
        	  uploadUrl : "${ctp}/imageUpload"						/* uploadUrl : 여러개의 그림파일을 드래그&드롭해서 올릴수 있다. */
          });
        </script>
      </div>
    
    
    <!-- 
    <div class="form-group">
      <label for="CKEDITOR">술 소개</label>
      <textarea name="content" id="CKEDITOR" rows="6" class="form-control" required></textarea>
    </div>
        <script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",
        	  uploadUrl : "${ctp}/imageUpload"
          });
        </script>
     -->
    <div class="form-group">
      <label>Availability</label>
      <div>
        <input type="radio" name="openSw" id="openSw1" value="OK" checked />
        <label for="openSw1">공개</label>
        <input type="radio" name="openSw" id="openSw2" value="NO" />
        <label for="openSw2">비공개</label>
      </div>
    </div>
    <div class="text-center">
      <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-custom mr-2"/>
      <input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
      <input type="button" value="=돌아가기" onclick="location.href='alcoholList';" class="btn btn-info"/>
    </div>
  </form>
</div>
</body>
</html>