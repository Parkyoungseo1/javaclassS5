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
  <title>Flavor Content</title>
  <%@ include file="/WEB-INF/views/include/bs4.jsp" %>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background-color: #f8f9fa;
      color: #333;
    }
    .container {
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      padding: 40px;
      margin-top: 50px;
    }
    h2 {
      color: #2c3e50;
      margin-bottom: 30px;
      font-weight: 700;
    }
    .table {
      border: none;
    }
    .table th {
      background-color: #ecf0f1;
      color: #34495e;
      font-weight: 600;
      border-top: none;
    }
    .table td {
      vertical-align: middle;
      border-top: 1px solid #ecf0f1;
    }
    .btn {
      border-radius: 30px;
      padding: 10px 25px;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    .btn-primary {
      background-color: #3498db;
      border-color: #3498db;
    }
    .btn-primary:hover {
      background-color: #2980b9;
      border-color: #2980b9;
    }
    .btn-danger {
      background-color: #e74c3c;
      border-color: #e74c3c;
    }
    .btn-danger:hover {
      background-color: #c0392b;
      border-color: #c0392b;
    }
    .btn-warning {
      background-color: #f39c12;
      border-color: #f39c12;
      color: #fff;
    }
    .btn-warning:hover {
      background-color: #d35400;
      border-color: #d35400;
      color: #fff;
    }
    .comment-section {
      background-color: #ecf0f1;
      border-radius: 12px;
      padding: 30px;
      margin-top: 40px;
    }
    .comment-form {
      background-color: #fff;
      border-radius: 12px;
      padding: 30px;
      margin-top: 30px;
      box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    .modal-content {
      border-radius: 12px;
    }
    .modal-header {
      background-color: #3498db;
      color: #fff;
      border-top-left-radius: 12px;
      border-top-right-radius: 12px;
    }
    .modal-title {
      font-weight: 700;
    }
    .close {
      color: #fff;
    }
    .close:hover {
      color: #ecf0f1;
    }
  </style>
  <script>
    // ... (JavaScript remains unchanged)
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
  <h2 class="text-center">Flavor Content</h2>
  <div class="card mb-4">
    <div class="card-body">
      <table class="table table-borderless">
        <tr>
          <th width="20%">Author</th>
          <td>${vo.nickName}</td>
          <th width="20%">Date</th>
          <td>${fn:substring(vo.WDate, 0, 16)}</td>
        </tr>
        <tr>
          <th>Category</th>
          <td>${vo.part}</td>
          <th>Views</th>
          <td>${vo.readNum}</td>
        </tr>
        <tr>
          <th>IP Address</th>
          <td colspan="3">${vo.hostIp}</td>
        </tr>
        <tr>
          <th>Content</th>
          <td colspan="3" style="min-height:200px">${fn:replace(vo.content, newLine, "<br/>")}</td>
        </tr>
      </table>
    </div>
  </div>
  <div class="d-flex justify-content-between mt-4">
    <div>
      <c:if test="${empty flag}"><button onclick="location.href='flavorList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning">Back to List</button></c:if>
      <c:if test="${!empty flag}"><button onclick="location.href='flavorSearch?pag=${pag}&pageSize=${pageSize}&search=${search}&searchString=${searchString}';" class="btn btn-warning">Back to Search</button></c:if>
    </div>
    <div>
      <c:if test="${sNickName == vo.nickName || sLevel == 0}">
        <c:if test="${report == 'OK'}"><span class="text-danger font-weight-bold mr-2">This post is currently under report.</span></c:if>
        <button onclick="location.href='flavorUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary mr-2">Edit</button>
        <button onclick="flavorDelete()" class="btn btn-danger">Delete</button>
      </c:if>
      <c:if test="${sNickName != vo.nickName}">
        <c:if test="${report == 'OK'}"><span class="text-danger font-weight-bold mr-2">This post is currently under report.</span></c:if>
        <c:if test="${report != 'OK'}"><button data-toggle="modal" data-target="#myModal" class="btn btn-danger">Report</button></c:if>
      </c:if>
    </div>
  </div>
</div>

<div class="container comment-section">
  <h4 class="mb-4">Comments</h4>
  <!-- Comment list -->
  <div class="card">
    <div class="card-body">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>Author</th>
            <th>Comment</th>
            <th>Date</th>
            <th>IP</th>
            <th>Reply</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
            <tr>
              <td class="text-left">
                <c:if test="${replyVo.re_step >= 1}">
                  <c:forEach var="i" begin="1" end="${replyVo.re_step}"> &nbsp;&nbsp;</c:forEach> └▶
                </c:if>
                ${replyVo.nickName}
                <c:if test="${sMid == replyVo.mid || sLevel == 0}">
                  (<a href="javascript:replyDelete(${replyVo.idx})" title="Delete comment">x</a>)
                </c:if>
              </td>
              <td class="text-left">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
              <td>${fn:substring(replyVo.WDate, 0, 10)}</td>
              <td>${replyVo.hostIp}</td>
              <td>
                <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge badge-success">Reply</a>
                <a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge badge-warning replyCloseBtn">Close</a>
              </td>
            </tr>
            <tr>
              <td colspan="5" class="p-0">
                <div id="replyDemo${replyVo.idx}" style="display:none">
                  <div class="card-body bg-light">
                    <form>
                      <div class="form-group">
                        <label for="contentRe${replyVo.idx}">Reply:</label>
                        <textarea rows="3" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.nickName}</textarea>
                      </div>
                      <div class="text-right">
                        <span class="mr-2">Author: ${sNickName}</span>
                        <button type="button" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-secondary btn-sm">Submit Reply</button>
                      </div>
                    </form>
                  </div>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
  
  <div class="comment-form">
    <h5 class="mb-3">Add a Comment</h5>
    <form name="replyForm">
      <div class="form-group">
        <textarea rows="4" name="content" id="content" class="form-control" placeholder="Enter your comment here..."></textarea>
      </div>
      <div class="text-right">
        <span class="mr-2">Author: ${sNickName}</span>
        <button type="button" onclick="replyCheck()" class="btn btn-primary">Submit Comment</button>
      </div>
    </form>
  </div>
</div>

<!-- Report Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Report this post</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body">
        <form name="modalForm">
          <div class="form-group">
            <label>Select reason for reporting:</label>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint1" name="complaint" class="custom-control-input" value="광고,홍보,영리목적">
              <label class="custom-control-label" for="complaint1">Advertising, promotion, commercial purpose</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint2" name="complaint" class="custom-control-input" value="욕설,비방,차별,혐오">
              <label class="custom-control-label" for="complaint2">Profanity, defamation, discrimination, hatred</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint3" name="complaint" class="custom-control-input" value="불법정보">
              <label class="custom-control-label" for="complaint3">Illegal information</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint4" name="complaint" class="custom-control-input" value="음란,청소년유해">
              <label class="custom-control-label" for="complaint4">Obscenity, harmful to youth</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint5" name="complaint" class="custom-control-input" value="개인정보노출,유포,거래">
              <label class="custom-control-label" for="complaint5">Personal information exposure, distribution, trading</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint6" name="complaint" class="custom-control-input" value="도배,스팸">
              <label class="custom-control-label" for="complaint6">Spam</label>
            </div>
            <div class="custom-control custom-radio">
              <input type="radio" id="complaint7" name="complaint" class="custom-control-input" value="기타" onclick="etcShow()">
              <label class="custom-control-label" for="complaint7">Other</label>
            </div>
          </div>
          <div class="form-group" id="etc" style="display:none">
            <textarea id="complaintTxt" class="form-control" rows="3" placeholder="Please specify the reason"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" onclick="complaintCheck()" class="btn btn-primary">Submit Report</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>