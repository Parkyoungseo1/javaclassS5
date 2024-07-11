<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- Header -->
  <header id="portfolio">
    <div class="w3-container">
    <h1><b>My Portfolio</b></h1>
    <div class="w3-section w3-bottombar w3-padding-16">
      <span class="w3-margin-right">Filter:</span> 
      <button class="w3-button w3-black">ALL</button>
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>Whiskey</button>
      <button class="w3-button w3-white w3-hide-small"><i class="fa fa-photo w3-margin-right"></i>Liqueur</button>
      <button class="w3-button w3-white w3-hide-small"><i class="fa fa-map-pin w3-margin-right"></i>Wine</button>
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>Makgeolli</button>
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>Highball</button>
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>Cocktail</button>
      <button class="w3-button w3-white"><i class="fa fa-diamond w3-margin-right"></i>etc</button>
    </div>
    </div>
  </header>