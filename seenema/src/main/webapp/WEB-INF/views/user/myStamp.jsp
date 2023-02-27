<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 - 씨네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/myStamp.css">
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
	<div class="myStampTitle">${member.name }님의 스탬프 적립 내역</div>
	<input type="hidden" class="stampCount" value="${member.stamp }">
	<div class="stampSection">
		<div class="stampWrap">
			<div class="firstLine">
				<!--  -->
			</div>
			<div class="secondLine">
				<!--  -->
			</div>
		</div>	
	</div>
</div>
<%@ include file="footer.jsp" %>
</body>
<script>
	$(document).ready(getStampList());
	
	// 초기 판 세팅
	function getStampList(){
		for(let i = 0; i < 4; i++){
			$(".firstLine").append(
					"<div class='item item" + (i + 1) + "'>"
						+ "<img src='/images/noStamp.png'>"  
					+ "</div>"
			);
			$(".secondLine").append(
					"<div class='item item" + (i + 5) + "'>"
						+ "<img src='/images/noStamp.png'>"  
					+ "</div>"
			);
			
		}
		$(".firstLine").append(
				"<div class='item image1'>"
					+ "<img src='/images/stampCola.png'>"  
				+ "</div>"
		);
		$(".secondLine").append(
				"<div class='item image2'>"
					+ "<img src='/images/stampPopcorn.png'>"  
				+ "</div>"
		);
		let count = parseInt($(".stampCount").val(), 10);
		for(let i = 1; i < count + 1; i++){
			$(".item" + i + " > img").attr("src", "/images/stamp.png");
		}
		if(count >= 4){
			$(".image1 > img").attr("src", "/images/colaClear.png");
		}
		if(count == 8){
			$(".image2 > img").attr("src", "/images/popcornClear.png");
		}
	}
	
	
</script>
</html>