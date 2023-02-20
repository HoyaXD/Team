<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 제이쿼리 -->
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!-- 관리자 좌측메뉴 css -->
<link rel="stylesheet" href="/css/adMenu.css">	
<script type="text/javascript" src="/js/adminMenu.js"></script>

<body>
	<div class="header">
		<div class="logo">Seenema</div>
		<nav>
			<ul class="mainmenu">
				<li><a href="adminPage">관리자 메인</a>
					<ul class="submenu"></ul></li>
				<li>영화 관리
					<ul class="submenu">
						<li><a href="movieReg">영화등록</a></li>
						<li><a href="movieList">영화 목록 및 괸리</a></li>
					</ul>
				</li>
				<li>영화관 관리
					<ul class="submenu">
						<li><a href="theaterReg">영화관 등록</a></li>
						<li><a href="theaterList">영화관 목록 및 관리</a></li>
					</ul>
				</li>
				<li>상품 관리
					<ul class="submenu">
						<li>상품 등록</li>
						<li>상품 수정</li>
						<li>상품 3</li>
						<li>상품 4</li>
					</ul>
				</li>
				<li>매출 관리
					<ul class="submenu">
						<li>매출 현황1</li>
						<li>매출 현황2</li>
						<li>매출 현황3</li>
						<li>매출 현황4</li>
					</ul>
				</li>
				<li><a href="MemberMGMT">회원관리 관리</a></li>
				<li><a href="qnaView">Q&A 관리</a></li>
				<li><a href="adNoticeView">공지사항 관리</a></li>
				<li><a href="adminReplyView">한줄평 관리</a></li>
			</ul>
		</nav>
	</div>
</body>