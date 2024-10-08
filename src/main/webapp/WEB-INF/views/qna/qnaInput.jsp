<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qnaInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
  
  
    function fCheck() {
	  	CKupdate();
	  	
    	var nickName = myform.nickName.value;
    	var title = myform.title.value;
    	var pwdCheck = document.getElementById("pwdCheck");
    	var pwd = myform.pwd.value;
    	var content = myform.content.value;
    	
    	if(nickName=="") {
    		alert("글올린이 닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(title=="") {
    		alert("글제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(content=="") {
    		alert("글내용을 입력하세요");
    		myform.content.focus();
    	}
    	else {
	    	//if($("#pwdCheck").is(":checked")) myform.pwd.value = '1234';
	    	//else myform.pwd.value = "";
	    	if($("#pwdCheck").is(":checked") && pwd == "") {
	    		alert("비밀번호를 입력하세요");
	    		myform.pwd.focus();
	    	 	return false;
	    	}
    		myform.submit();
    	}
    }

    // ckeditor null값체크하도록 처리하기 함수
    function CKupdate(){
        for (var instance in CKEDITOR.instances )
            CKEDITOR.instances[instance].updateElement();
    }
    
    $(document).ready(function() {
	    $("#pwdCheck").click(function() {
	    	if($("#pwdCheck").is(":checked")) {
		    	$("#pwd").removeAttr("readonly");
		    	$("#pwd").focus();
	    	}
	    	else {
	    		$("#pwd").attr("readonly",true);
	    	}
	    });
    });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="container">
  <p><br/></p>
  <form name="myform" method="post">
    <table class="table table-borderless">
      <tr>
        <td><h2>QnA 글쓰기</h2></td>
      </tr>
    </table>
    <table class="table">
      <tr>
        <th>글쓴이</th>
        <td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>
      </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" placeholder="글제목을 입력하세요." size="60" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
        <script>
          CKEDITOR.replace("content",{
        	  height:500,
        	  filebrowserUploadUrl:"${ctp}/imageUpload",
        	  uploadUrl : "${ctp}/imageUpload"
          });
        </script>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td>
          <input type="checkbox" name="pwdCheck" id="pwdCheck"/>
    			<label for="pwdCheck">비밀글</label> <font size="1">(비밀글로 등록시는 '비밀글'체크후, 아래 비밀번호를 입력해주세요.)</font>
    			<input type="password" name="pwd" id="pwd" class="form-control" />
        </td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center">
          <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-success"/> &nbsp;
          <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
          <%-- 
          <c:if test="${vo.nickName == sNickName}">
          	<input type="button" value="글수정하기" onclick="fCheck()" class="btn btn-primary"/> &nbsp;
          </c:if>
           --%>
          <input type="button" value="돌아가기" onclick="location.href='qnaList';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
    <%-- <input type="hidden" name="qnaSw" value="${qnaSw}"/> --%>  <!-- get방식으로 넘어온 주소값에 'qnaSw=a'가 적혀 있기에 이곳에 다시 기술할필요가 없다. -->
    <c:if test="${qnaFlag == 'q'}"><input type="hidden" name="qnaSw" value="q"/></c:if>
    <c:if test="${qnaFlag != 'q'}">
      <input type="hidden" name="qnaSw" value="a"/>
      <input type="hidden" name="qnaIdx" value="${vo.idx}"/>
    </c:if>
    <input type="hidden" name="mid" value="${sMid}"/>
  </form>
  <p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>