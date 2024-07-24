<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminMain.jsp</title>
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      overflow: hidden;
    }
    frameset {
      border: none;
      width: 100%;
      height: 100%;
    }
  </style>
</head>
<frameset cols="250px, *" border="0">
  <frame src="${ctp}/admin/adminLeft" name="adminLeft" frameborder="0" scrolling="auto" />
  <frame src="${ctp}/admin/adminContent" name="adminContent" frameborder="0" scrolling="auto" />
  <noframes>
    <body>
      <p>이 페이지는 프레임을 지원하는 브라우저가 필요합니다.</p>
    </body>
  </noframes>
</frameset>
</html>