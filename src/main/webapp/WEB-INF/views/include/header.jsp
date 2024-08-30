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
  
  <!-- First Photo Grid-->
  <div class="w3-row-padding">
    <div class="w3-third w3-container w3-margin-bottom">
	    <img src="${ctp}/images/Glenfiddich 18.jpg" alt="High Resolution Image" style="width:100%; height:450px;" class="w3-hover-opacity">
	    <div class="w3-container w3-white">
	        <p><b>Glenfiddich 18</b></p>
	        <p>은은한 사과향이 혀 끝을 돌아 온 입안에 퍼지는 상쾌함을 느낄 수 있습니다.부드러운 스모크와 달콤한 사과와 깊은 나무 향이 나며, 약간의 짠맛과 셰리가 우아하면서 복합적인 느낌을 준다.</p>
	    </div>
		</div>
		<div class="w3-third w3-container w3-margin-bottom">
		    <img src="${ctp}/images/Balvenie 25.jpg" alt="Norway" style="width:100%; height:425px;" class="w3-hover-opacity">
		    <div class="w3-container w3-white">
		        <p><b>Balvenie 25</b></p>
		        <p>향:바나나 캔디, 으깬 민트 잎, 꽃 꿀. 약간의 목수 냄새. 자몽 껍질과 생강의 힌트.향긋한 바닐라와 새 가죽도. 배, 사과, 노란 자두. 커스터드의 힌트. 그런 다음 백후추, 녹차, 레몬 향이 더해져 오크향이 더 많이 납니다.</p>
		    </div>
		</div>
		<div class="w3-third w3-container w3-margin-bottom">
		    <img src="${ctp}/images/Johnnie Walker Blue Label.jpg" alt="Norway" style="width:100%; height:450px;" class="w3-hover-opacity">
		    <div class="w3-container w3-white">
		        <p><b>Johnnie Walker Blue Label</b></p>
		        <p>달콤한 토피 향과 신선한 과일 향, 셰리 향, 스파이시 향이 특징이다. 바위투성이인 황량한 하이랜드의 향긋한 헤더 벌꿀 향을 지나 서해안 섬의 몰트가 지니는 스모키한 피트 향으로 끝난다.</p>
		    </div>
		</div>
  </div>
  
  <!-- Second Photo Grid-->
  <div class="w3-row-padding">
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="${ctp}/images/Suntory Hibiki 30.jpg" alt="Norway" style="width:100%; height:450px;" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>Suntory Hibiki 30 Years Old</b></p>
        <p>초장기 숙성 몰트 유래의 달콤한 향기와 마치 꽃을 연상 시키는 화려한 향기가 풍부합니다. 입맛은 매끈하면서도 뒷맛에 중후함이 느껴집니다.</p>
      </div>
    </div>
    <div class="w3-third w3-container w3-margin-bottom">
      <img src="${ctp}/images/Macallan 15.jpg" alt="Norway" style="width:100%; height:450px;" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>Macallan 15Years</b></p>
        <p>장미향,시나몬 향과 오렌지,레진의 맛과 향을 섬세한 미각으로 즐길 수 있다. 또한 이 잔향들은 말린 과일 향과 함께 어우러져 입안 가득 퍼지는 것이 특징이다.</p>
      </div>
    </div>
    <div class="w3-third w3-container">
      <img src="${ctp}/images/Reyal salute 25.jpg" alt="Norway" style="width:100%; height:450px;" class="w3-hover-opacity">
      <div class="w3-container w3-white">
        <p><b>Reyal salute 25year</b></p>
        <p>짙은 황금빛 호박색향취(Nose):풍부한 과일향과 가을꽃의 달콤한 향취맛(Palate):은은한 스모키향이 베어 있는깊은 풍부한 과일향의 풍미끝 맛</p>
      </div>
    </div>