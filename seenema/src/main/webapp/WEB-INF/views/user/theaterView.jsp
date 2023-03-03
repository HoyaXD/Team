<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영관 - 시네마</title>
<link rel="stylesheet" href="/css/theaterView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<main id="theaterView">
		<div class="sideBar">
			<div class="sideBarMenu menu1">공지 / 뉴스</div>
			<div class="sideBarMenu menu2">Q&A</div>
			<div class="sideBarMenu menu3">상영관</div>
			<div class="ad1"></div>
		</div>
		<div class="theaterWrap">
			<div class="pageBigTitle">상영관</div>
			<div class="ticketImage">
				<img src="">
			</div>
		</div>
	</main>
<%@ include file="footer.jsp" %>
<script>
	//페이지가 시작되면
	$(document).ready(function(){
		$(".menu3").css("backgroundColor", "#FB4357");
		$(".menu3").css("color", "white");
	});
	
	// 사이드바 메뉴2
	$(".menu1").on("click", function(){
		location.href = "/user/userNoticeBoard";
	});
	
	$(".menu2").on("click", function(){
		location.href = "/user/userQnaView";
	});
	
	$(".menu3").on("click", function(){
		location.href = "/user/theaterView";
	});
</script>
</body>
</html>