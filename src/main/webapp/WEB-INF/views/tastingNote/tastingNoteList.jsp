<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Photo Gallery</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
  <style>
    :root {
      --primary-color: #007bff;
      --secondary-color: #6c757d;
      --success-color: #28a745;
      --info-color: #17a2b8;
      --background-color: #f8f9fa;
      --card-background: #ffffff;
      --text-color: #333333;
    }

    body {
      font-family: 'Arial', sans-serif;
      background-color: var(--background-color);
      color: var(--text-color);
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 2rem;
    }

    h2 {
      color: var(--primary-color);
      margin-bottom: 2rem;
    }

    .search-controls {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }

    .search-controls select, .search-controls input[type="button"] {
      margin-right: 0.5rem;
    }

    .action-buttons {
      display: flex;
      justify-content: flex-end;
      margin-bottom: 1rem;
    }

    .action-buttons .btn {
      margin-left: 0.5rem;
    }

    .card-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 1.5rem;
    }

    .card {
      background-color: var(--card-background);
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease;
      display: flex;
      flex-direction: column;
    }

    .card:hover {
      transform: translateY(-5px);
    }

    .card-body {
      padding: 1rem;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
    }

    .card-body img {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 4px;
    }

    .card-note {
      margin-top: 1rem;
      background-color: #f1f3f5;
      border-radius: 4px;
      padding: 0.5rem;
      font-size: 0.9rem;
      flex-grow: 1;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
    }

    .card-footer {
      background-color: rgba(0, 0, 0, 0.03);
      padding: 0.75rem;
      font-size: 0.875rem;
    }

    .card-footer .row {
      display: flex;
      justify-content: space-around;
    }

    .card-footer i {
      margin-right: 0.25rem;
    }

    #topBtn {
      position: fixed;
      bottom: 20px;
      right: 20px;
      background-color: var(--primary-color);
      color: white;
      border: none;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      font-size: 1.5rem;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      opacity: 0;
      transition: opacity 0.3s, transform 0.3s;
      z-index: 1000;
    }

    #topBtn.on {
      opacity: 1;
      transform: translateY(0);
    }

    #topBtn:hover {
      background-color: var(--info-color);
    }

    @media (max-width: 768px) {
      .search-controls {
        flex-direction: column;
        align-items: stretch;
      }

      .search-controls > div {
        margin-bottom: 1rem;
      }

      .action-buttons {
        justify-content: center;
      }
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<div class="container" style="margin-left: 400px;">
  <h2 class="text-center">Tasting Note</h2>

  <div class="search-controls">
    <div class="input-group">
      <select name="part" id="part" class="form-control">
        <option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
        <option value="Whiskey" ${part == 'Whiskey' ? 'selected' : ''}>Whiskey</option>
        <option value="Liqueur" ${part == 'Liqueur' ? 'selected' : ''}>Liqueur</option>
        <option value="Wine" ${part == 'Wine' ? 'selected' : ''}>Wine</option>
        <option value="Makgeolli" ${part == 'Makgeolli' ? 'selected' : ''}>Makgeolli</option>
        <option value="Highball" ${part == 'Highball' ? 'selected' : ''}>Highball</option>
        <option value="Cocktails" ${part == 'Cocktails' ? 'selected' : ''}>Cocktails</option>
        <option value="etc" ${part == 'etc' ? 'selected' : ''}>etc</option>
      </select>
      <select name="choice" id="choice" class="form-control ml-2">
        <option value="최신순" ${choice == '최신순' ? 'selected' : ''}>최신순</option>
        <option value="추천순" ${choice == '추천순' ? 'selected' : ''}>추천순</option>
        <option value="조회순" ${choice == '조회순' ? 'selected' : ''}>조회순</option>
        <option value="댓글순" ${choice == '댓글순' ? 'selected' : ''}>댓글순</option>
      </select>
      <div class="input-group-append">
        <button onclick="photoSearch()" class="btn btn-primary">조건검색</button>
      </div>
    </div>
  </div>

  <div class="action-buttons">
    <button onclick="location.href='tastingNoteInput';" class="btn btn-success">사진올리기</button>
    <button onclick="location.href='tastingNoteSingle';" class="btn btn-info">한장씩보기</button>
  </div>

  <div id="list-wrap" class="card-container">
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <div class="card">
        <div class="card-body">
          <a href="tastingNoteContent?idx=${vo.idx}">
            <img src="${ctp}/tastingNote/${vo.thumbnail}" alt="${vo.title}" title="${vo.title}" />
          </a>
          <div class="card-note">${vo.note}</div>
        </div>
        <div class="card-footer">
          <div class="row">
            <div><i class="fa-regular fa-pen-to-square" title="댓글수"></i> ${vo.replyCnt}</div>
            <div><i class="fa-regular fa-face-grin-hearts" title="좋아요"></i> ${vo.goodCount}</div>
            <div><i class="fa-regular fa-eye" title="조회수"></i> ${vo.readNum}</div>
            <div><i class="fa-solid fa-layer-group" title="사진수"></i> ${vo.photoCount}</div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<button id="topBtn" title="위로이동"><i class="fas fa-chevron-up"></i></button>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
  'use strict';
  
  function photoSearch() {
    let part = $("#part").val();
    let choice = $("#choice").val();
    
    location.href = "tastingNoteList?part="+part+"&choice="+choice;
  }
  
  // Infinite scroll implementation (Ajax)
  let lastScroll = 0;
  let curPage = 1;
  
  $(window).scroll(function() {
    let currentScroll = $(this).scrollTop();
    let documentHeight = $(document).height();
    let windowHeight = $(window).height();
    
    if (currentScroll > lastScroll && (windowHeight + currentScroll + 200) >= documentHeight) {
      curPage++;
      $.ajax({
        url: "tastingNoteListPaging",
        type: "post",
        data: {
          pag: curPage,
          part: '${part}',
          choice: '${choice}'
        },
        success: function(res) {
          $("#list-wrap").append(res);
        }
      });
    }
    lastScroll = currentScroll;

    // Show/hide top button
    if (currentScroll > 100) {
      $("#topBtn").addClass("on");
    } else {
      $("#topBtn").removeClass("on");
    }
  });
  
  // Smooth scroll to top
  $("#topBtn").click(function() {
    $("html, body").animate({ scrollTop: 0 }, "slow");
  });
</script>
</body>
</html>