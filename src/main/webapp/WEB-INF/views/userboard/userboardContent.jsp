<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>userboardContent.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
      padding: 30px;
      margin-top: 30px;
    }
    h2 {
      color: #343a40;
      margin-bottom: 30px;
    }
    .table {
      border: none;
    }
    .table th {
      background-color: #e9ecef;
      color: #495057;
      font-weight: 600;
    }
    .table td {
      vertical-align: middle;
    }
    .btn {
      border-radius: 20px;
      padding: 8px 20px;
    }
    .comment-section {
      background-color: #f1f3f5;
      border-radius: 8px;
      padding: 20px;
      margin-top: 30px;
    }
    .comment-form {
      background-color: #fff;
      border-radius: 8px;
      padding: 20px;
      margin-top: 20px;
    }
    .modal-content {
      border-radius: 8px;
    }
    .modal-header {
      background-color: #e9ecef;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }
  </style>
  <script>
    'use strict';
    
    function userboardDelete() {
    	let ans = confirm("현재 게시글을 삭제 하시겠습니까?");
    	if(ans) location.href = "userboardDelete?idx=${vo.idx}";
    }
    
    // 좋아요 처리(중복허용)
    function goodCheck() {
    	$.ajax({
    		url  : "BoardGoodCheck.bo",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 좋아요 처리(중복불허)
    function goodCheck2() {
    	$.ajax({
    		url  : "BoardGoodCheck2.bo",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success:function(res) {
    			if(res != "0") location.reload();
    			else alert("이미 좋아요 버튼을 클릭하셨습니다.");
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 좋아요(따봉)수 증가 처리(중복허용)
    function goodCheckPlus() {
    	$.ajax({
    		url  : "BoardGoodCheckPlusMinus.bo",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : +1
    		},
    		success:function(res) {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 좋아요(따봉)수 감소 처리(중복허용)
    function goodCheckMinus() {
    	$.ajax({
    		url  : "BoardGoodCheckPlusMinus.bo",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			goodCnt : -1
    		},
    		success:function(res) {
    			if(res != "0") location.reload();
    		},
    		error : function() {
    			alert("전송오류");
    		}
    	});
    }
    
    // 신고시 '기타'항목 선택시에 textarea 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
    
    // 신고화면 선택후 신고사항 전송하기
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
    		alert("신고항목을 선택하세요");
    		return false;
    	}
    	//if($("input[type=radio][id=complaint7]:checked") && $("#complaintTxt").val() == "")
    	if($("input[type=radio]:checked").val() == '기타' && $("#complaintTxt").val() == "") {
    		alert("기타 사유를 입력해 주세요.");
    		return false;
    	}
    	
    	let cpContent = modalForm.complaint.value;
    	if(cpContent == '기타') cpContent += '/' + $("#complaintTxt").val();
    	
    	//alert("신고내용 : " + cpContent);
    	let query = {
    			part   : 'userboard',
    			partIdx: ${vo.idx},
    			cpMid  : '${sMid}',
    			cpContent : cpContent
    	}
    	
    	$.ajax({
    		url  : "userboardComplaintInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("신고 되었습니다.");
    				location.reload();
    			}
    			else alert("신고 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
   		});
    }
    
    // 원본글에 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			userboardIdx 	: ${vo.idx},
    			mid				: '${sMid}',
    			nickName	: '${sNickName}',
    			hostIp    : '${pageContext.request.remoteAddr}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/userboard/userboardReplyInput",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    // 댓글 삭제하기
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "UserboardReplyDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
    
    
    // 처음에는 대댓글 '닫기'버튼은 보여주지 않는다.
    $(function(){
    	$(".replyCloseBtn").hide();
    });
    
    // 대댓글 입력버튼 클릭시 입력박스 보여주기
    function replyShow(idx) {
    	$("#replyShowBtn"+idx).hide();
    	$("#replyCloseBtn"+idx).show();
    	$("#replyDemo"+idx).slideDown(100);
    }
    
    // 대댓글 박스 감추기
    function replyClose(idx) {
    	$("#replyShowBtn"+idx).show();
    	$("#replyCloseBtn"+idx).hide();
    	$("#replyDemo"+idx).slideUp(300);
    }
    
    // 대댓글(부모댓글의 답변글)의 입력처리
    function replyCheckRe(idx, re_step, re_order) {
    	let content = $("#contentRe"+idx).val();
    	if(content.trim() == "") {
    		alert("답변글을 입력하세요");
    		$("#contentRe"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    			userboardIdx : ${vo.idx},
    			re_step : re_step,
    			re_order : re_order,
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			hostIp   : '${pageContext.request.remoteAddr}',
    			content  : content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/userboard/userboardReplyInputRe",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("답변글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert("답변글 입력 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center">게시글 내용</h2>
  <table class="table">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>분류</th>
      <td>${vo.part}</td>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
  </table>
  <div class="d-flex justify-content-between mt-4">
    <div>
      <c:if test="${empty flag}"><button onclick="location.href='userboardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning">돌아가기</button></c:if>
      <c:if test="${!empty flag}"><button onclick="location.href='userboardSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning">돌아가기</button></c:if>
    </div>
    <div>
      <c:if test="${sNickName == vo.nickName || sLevel == 0}">
        <c:if test="${complaint == 'OK'}"><span class="text-danger font-weight-bold mr-2">현재 이글은 신고중입니다.</span></c:if>
        <button onclick="location.href='userboardUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary mr-2">수정</button>
        <button onclick="userboardDelete()" class="btn btn-danger">삭제</button>
      </c:if>
      <c:if test="${sNickName != vo.nickName}">
        <c:if test="${report == 'OK'}"><span class="text-danger font-weight-bold mr-2">현재 이글은 신고중입니다.</span></c:if>
        <c:if test="${report != 'OK'}"><button data-toggle="modal" data-target="#myModal" class="btn btn-danger">신고하기</button></c:if>
      </c:if>
    </div>
   </div>
</div>

<div class="container comment-section">
  <h4 class="mb-4">댓글</h4>
  <!-- 댓글 리스트 -->
  <table class="table table-hover text-center">
	  <tr>
	    <th>작성자</th>
	    <th>댓글내용</th>
	    <th>댓글일자</th>
	    <th>접속IP</th>
	    <th>답글</th>
	  </tr>
	  <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	    <tr>
	      <td class="text-left">
	        <c:if test="${replyVo.re_step >= 1}">
	          <c:forEach var="i" begin="1" end="${replyVo.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
	        </c:if>
	        ${replyVo.nickName}
	        <c:if test="${sMid == replyVo.mid || sLevel == 0}">
	          (<a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제">x</a>)
	        </c:if>
	      </td>
	      <td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
	      <td>${fn:substring(replyVo.WDate, 0, 10)}</td>
	      <td>${replyVo.hostIp}</td>
	      <td>
	        <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-success">답글</a>
	        <a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge badge-warning replyCloseBtn">닫기</a>
	      </td>
	    </tr>
	    <tr>
	      <td colspan="5" class="m-0 p-0">
	        <div id="replyDemo${replyVo.idx}" style="display:none">
	          <table class="table table-center">
	            <tr>
	              <td style="85%" class="text-left">답글내용 :
	                <textarea rows="4" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.nickName}</textarea>
	              </td>
	              <td style="15%">
	                <br/>
	                <p>작성자 : ${sNickName}</p>
	                <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-secondary btn-sm"/>
	              </td>
	            </tr>
	          </table>
	        </div>
	      </td>
	    </tr>
	  </c:forEach>
	  <tr><td colspan="4" class='m-0 p-0'></td></tr>
	</table>
  
  <div class="comment-form">
    <h5 class="mb-3">댓글 작성</h5>
    <form name="replyForm">
      <div class="form-group">
        <textarea rows="4" name="content" id="content" class="form-control" placeholder="댓글을 입력하세요..."></textarea>
      </div>
      <div class="text-right">
        <p>작성자: ${sNickName}</p>
        <button type="button" onclick="replyCheck()" class="btn btn-primary">댓글달기</button>
      </div>
    </form>
  </div>
</div>

<!-- 신고하기 모달 -->
<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">현재 게시글을 신고합니다.</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <b>신고사유 선택</b>
          <hr/>
          <form name="modalForm">
            <div><input type="radio" name="complaint" id="complaint1" value="광고,홍보,영리목적"/> 광고,홍보,영리목적</div>
            <div><input type="radio" name="complaint" id="complaint2" value="욕설,비방,차별,혐오"/> 설,비방,차별,혐오</div>
            <div><input type="radio" name="complaint" id="complaint3" value="불법정보"/> 불법정보</div>
            <div><input type="radio" name="complaint" id="complaint4" value="음란,청소년유해"/> 음란,청소년유해</div>
            <div><input type="radio" name="complaint" id="complaint5" value="개인정보노출,유포,거래"/> 개인정보노출,유포,거래</div>
            <div><input type="radio" name="complaint" id="complaint6" value="도배,스팸"/> 도배,스팸</div>
            <div><input type="radio" name="complaint" id="complaint7" value="기타" onclick="etcShow()"/> 기타</div>
            <div id="etc"><textarea rows="2" id="complaintTxt" class="form-control" style="display:none"></textarea></div>
            <hr/>
            <input type="button" value="확인" onclick="complaintCheck()" class="btn btn-success form-control" />
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>