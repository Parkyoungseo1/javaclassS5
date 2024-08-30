<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>tastingNoteContent.jsp</title>
    <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
    <style>
        .carousel-inner img {
            width: 50%;
            height: 50%;
        }
        #topBtn {
            position: fixed;
            right: 1rem;
            bottom: -50px;
            transition: 0.7s ease;
        }
        #topBtn.on {
            opacity: 0.8;
            cursor: pointer;
            bottom: 0;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/include/nav.jsp" />
    
    <div class="container mt-5">
        <h2 class="mb-4">[${vo.part}] ${vo.title}</h2>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>${vo.mid} | ${fn:substring(vo.PDate,0,16)} | ${vo.hostIp}</div>
            <div>
                <i class="far fa-comment" title="댓글수"></i> ${vo.replyCnt} &nbsp;
                <i class="far fa-heart" title="좋아요"></i> ${vo.goodCount} &nbsp;
                <i class="far fa-eye" title="조회수"></i> ${vo.readNum} &nbsp;
                <i class="fas fa-images" title="사진수"></i> ${vo.photoCount}
            </div>
        </div>

        <!-- Carousel -->
        <div id="photoCarousel" class="carousel slide mb-4" data-ride="carousel">
            <ol class="carousel-indicators">
                <c:forEach var="photo" items="${photoList}" varStatus="st">
                    <li data-target="#photoCarousel" data-slide-to="${st.index}" ${st.first ? 'class="active"' : ''}></li>
                </c:forEach>
            </ol>
            <div class="carousel-inner">
                <c:forEach var="photo" items="${photoList}" varStatus="st">
                    <div class="carousel-item ${st.first ? 'active' : ''}">
                        <img src="${ctp}/tastingNote/${photo}" class="d-block w-100" alt="${photo}">
                    </div>
                </c:forEach>
            </div>
            <a class="carousel-control-prev" href="#photoCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#photoCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <!-- Actions -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <button onclick="location.href='tastingNoteList';" class="btn btn-secondary mr-2">목록보기</button>
                <button onclick="replyHide()" id="replyHideBtn" class="btn btn-info mr-2">댓글가리기</button>
                <button onclick="replyShow()" id="replyShowBtn" class="btn btn-warning mr-2" style="display:none;">댓글보이기</button>
                <c:if test="${sMid == vo.mid}">
                    <button onclick="deleteCheck(${vo.idx})" class="btn btn-danger">삭제</button>
                </c:if>
            </div>
            <div>
                <a href="javascript:replyInputShow()" class="mr-3"><i class="far fa-comment"></i> ${vo.replyCnt}</a>
                <a href="javascript:goodCheck()"><i class="far fa-heart text-danger"></i> ${vo.goodCount}</a>
            </div>
        </div>

        <!-- Reply Input -->
        <div id="replyInput" class="mb-4" style="display:none;">
            <form name="replyForm">
                <div class="form-group">
                    <label for="content">댓글 내용:</label>
                    <textarea class="form-control" rows="4" id="content" name="content"></textarea>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span>작성자: ${sMid}</span>
                    <button type="button" onclick="replyCheck()" class="btn btn-primary">댓글달기</button>
                </div>
            </form>
        </div>

        <!-- Reply List -->
        <div id="replyList" class="mb-4">
            <h4 class="mb-3">댓글 목록</h4>
            <table class="table">
                <thead class="thead-light">
                    <tr>
                        <th>작성자</th>
                        <th>댓글내용</th>
                        <th>댓글일자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="replyVo" items="${replyVos}">
                        <tr>
                            <td>
                                ${replyVo.mid}
                                <c:if test="${sMid == replyVo.mid || sLevel == 0}">
                                    <a href="javascript:replyDelete(${replyVo.idx})" class="text-danger ml-2" title="댓글삭제">삭제</a>
                                </c:if>
                            </td>
                            <td>${fn:replace(replyVo.content, newLine, "<br/>")}</td>
                            <td>${fn:substring(replyVo.prDate, 0, 10)}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Full-size Photos -->
        <div class="text-center mb-4">
            <c:forEach var="photo" items="${photoList}">
                <img src="${ctp}/tastingNote/${photo}" class="img-fluid mb-3" alt="${photo}">
            </c:forEach>
        </div>

        <!-- Navigation Buttons -->
        <div class="d-flex justify-content-between mb-4">
            <div>
                <c:choose>
                    <c:when test="${empty flag}">
                        <button onclick="location.href='tastingNoteList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning">돌아가기</button>
                    </c:when>
                    <c:otherwise>
                        <button onclick="location.href='tastingNoteSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning">돌아가기</button>
                    </c:otherwise>
                </c:choose>
            </div>
            <div>
                <c:choose>
                    <c:when test="${sMid == vo.mid || sLevel == 0}">
                        <c:if test="${report == 'OK'}"><span class="text-danger font-weight-bold mr-2">현재 이글은 신고중입니다.</span></c:if>
                        <button onclick="location.href='tastingNoteUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary mr-2">수정</button>
                        <button onclick="tastingNoteDelete()" class="btn btn-danger">삭제</button>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${report == 'OK'}">
                            <span class="text-danger font-weight-bold mr-2">현재 이글은 신고중입니다.</span>
                        </c:if>
                        <c:if test="${report != 'OK'}">
                            <button data-toggle="modal" data-target="#reportModal" class="btn btn-danger">신고하기</button>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Report Modal -->
    <div class="modal fade" id="reportModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">현재 게시글을 신고합니다.</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form name="modalForm">
                        <div class="form-group">
                            <label>신고사유 선택:</label>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" name="complaint" id="complaint1" value="광고,홍보,영리목적">
                                <label class="form-check-label" for="complaint1">광고,홍보,영리목적</label>
                            </div>
                            <!-- Add other radio buttons here -->
                            <div class="form-check">
                                <input type="radio" class="form-check-input" name="complaint" id="complaint7" value="기타" onclick="etcShow()">
                                <label class="form-check-label" for="complaint7">기타</label>
                            </div>
                            <textarea rows="2" id="complaintTxt" class="form-control mt-2" style="display:none"></textarea>
                        </div>
                        <button type="button" onclick="complaintCheck()" class="btn btn-primary btn-block">확인</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/include/footer.jsp" />
    
    <!-- Top Button -->
    <button id="topBtn" class="btn btn-secondary"><i class="fas fa-arrow-up"></i></button>
		<script>
      'use strict';
    
    function replyHide() {
    	$("#replyHideBtn").hide();
    	$("#replyShowBtn").show();
    	$("#replyList").hide();
    }
    
    function replyShow() {
    	$("#replyHideBtn").show();
    	$("#replyShowBtn").hide();
    	$("#replyList").show();
    }
    
    function replyInputShow() {
    	$("#replyInput").toggle();
    }
    
    // 내용 삭제하기
    function deleteCheck(idx) {
    	let ans = confirm("현재 게시글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	else location.href = "tastingNoteDelete?idx="+idx;
    }
    
    // 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    			mid				: '${sMid}',
    			photoIdx	: '${vo.idx}',
    			content		: content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/tastingNote/tastingNoteReplyInput",
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
    		url  : "${ctp}/tastingNote/tastingNoteReplyDelete",
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
    
    // 좋아요 처리(중복불허)
    function goodCheck() {
    	$.ajax({
    		url  : "${ctp}/tastingNote/tastingNoteGoodCheck",
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
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
    
    
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
    			part   : 'tastingNote',
    			partIdx: ${vo.idx},
    			cpMid  : '${sMid}',
    			cpContent : cpContent
    	}
    	
    	$.ajax({
    		url  : "tastingNoteComplaintInput",
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

        // Scroll to top functionality
        $(window).scroll(function() {
            if ($(this).scrollTop() > 100) {
                $("#topBtn").addClass("on");
            } else {
                $("#topBtn").removeClass("on");
            }
        });

        $("#topBtn").click(function() {
            window.scrollTo({top: 0, behavior: "smooth"});
        });
    </script>
</body>
</html>