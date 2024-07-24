<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>alcoholUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center"> 글 수 정 하 기</h2>
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>글쓴이</th>
        <td><input type="text" name="mid" id="mid" value="${sMid}" readonly class="form-control" /></td>
      </tr>
      <tr>
        <th>술 이름</th>
        <td><input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
      	<th>술 종류</th>
      		<td>
			      <select name="part" id="part" class="form-control">
			        <option>Whiskey</option>
			        <option ${part=="Liqueur" ? "selected" : ""}>Liqueur</option>
			        <option ${part=="Wine" ? "selected" : ""}>Wine</option>
			        <option ${part=="Makgeolli" ? "selected" : ""}>Makgeolli</option>
			        <option ${part=="Highball" ? "selected" : ""}>Highball</option>
			        <option ${part=="Cocktail" ? "selected" : ""}>Cocktail</option>
			        <option ${part=="etc" ? "selected" : ""}>etc</option>
			      </select>
			     </td>
      </tr>
      <tr>
      	<th>가격</th>
      	<td><input type="text" name="price" id="price" value="${vo.price}" autofocus required class="form-control" /></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea name="content" id="CKEDITOR" rows="6" class="form-control" required>${vo.content}</textarea></td>
				<script>
          CKEDITOR.replace("content",{
        	  height:480,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) */
        	  uploadUrl : "${ctp}/imageUpload"						/* uploadUrl : 여러개의 그림파일을 드래그&드롭해서 올릴수 있다. */
          });
        </script>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="수정하기" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='alcoholContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-info"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="idx" value="${vo.idx}"/>
    <%-- <input type="hidden" name="mid" value="${sMid}"/> --%>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>