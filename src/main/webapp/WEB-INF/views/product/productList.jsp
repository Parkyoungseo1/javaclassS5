<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
    <title>상품 목록</title>
    <style>
        .product-item { display: inline-block; margin: 10px; text-align: center; }
        .thumbnail { width: 100px; height: 100px; object-fit: cover; }
    </style>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></P>
	<h1>상품 목록</h1>
	    <div>
	        <c:forEach var="product" items="${products}">
	            <div class="product-item">
	                <a href="/products/${product.id}">
	                    <img src="${product.thumbnailUrl}" alt="${product.name}" class="thumbnail"><br>
	                    ${product.name} - ${product.price}원
	                </a>
	            </div>
	        </c:forEach>
	    </div>
<p><br/></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>