<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 상세 정보</title>
    <style>
        .product-image { max-width: 400px; }
    </style>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></P>
	<h1>상품 상세 정보</h1>
	    <img src="${product.imageUrl}" alt="${product.name}" class="product-image">
	    <p>이름: ${product.name}</p>
	    <p>가격: ${product.price}원</p>
	    <p>설명: ${product.description}</p>
	    <a href="/products">목록으로 돌아가기</a>
<p><br/></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>