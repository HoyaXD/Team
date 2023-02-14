<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 목록 - 시네마</title>
<link rel="stylesheet" href="/css/storeView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<header>헤더</header>
	<div class="topImageWrap">
		<img id="topImage" src="/images/storeTop.png">
	</div>
	<div class="contents">
		<nav class="navBar"><!-- 상단 메뉴바 -->
			<ul class="menuBar">
				<li id="bestMenu">
					<a class="menu" id="best" href="#bestScroll">베스트</a>
				</li>
				<li id="ticketMenu">
					<a class="menu" id="ticket" href="#ticketScroll">관람권</a>
				</li>
				<li id="snackMenu">
					<a class="menu" id="snack" href="#snackScroll">스낵/음료</a>
				</li>
			</ul>
		</nav><!-- 상단 메뉴바 -->
		<div class="bestWrap">
			<div id="bestScroll">&nbsp;</div>
			<!-- 베스트 -->
			<div class="sectionTitle">베스트 상품</div>
			<div class="itemWrap">
				<a href="#" class="item item1">
					<img src="/images/kkeullimPackage.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>끌림 패키지</h4>
							<p>일반관람권 2매 + 스위트 콤보</p>
							<div class="price">28,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item2">
					<img src="/images/theKkeullimPackage.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>THE 끌림 패키지</h4>
							<p>관람권 2매 + 스위트 콤보</p>
							<div class="price">65,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item3">
					<img src="/images/datePackage.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>데이트의 완성 2인 패키지</h4>
							<p>2D 일반관람권 2매 + 스위트 콤보</p>
							<div class="price">32,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item4">
					<img src="/images/ticket1.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>일반 관람권</h4>
							<p>일반 관람권 1매</p>
							<div class="price">13,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item5">
					<img src="/images/ticket2.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>샤롯데 관람권</h4>
							<p>샤롯데 관람권 1매</p>
							<div class="price">35,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item6">
					<img src="/images/colaM.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>콜라 M</h4>
							<p>콜라 M</p>
							<div class="price">2,800원</div>
						</div>
					</div>
				</a>
			</div>
		</div>
		
		<!-- 관람권 -->
		<div class="ticketWrap">
			<div id="ticketScroll">&nbsp;</div>
			<div class="sectionTitle">관람권</div>
			<div class="itemWrap">
				<a href="#" class="item item1">
					<img src="/images/ticket1.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>일반 관람권</h4>
							<p>일반 관람권 1매</p>
							<div class="price">13,000원</div>
						</div>
					</div>
				</a>
				<a href="#" class="item item2">
					<img src="/images/ticket2.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>샤롯데 관람권</h4>
							<p>샤롯데 관람권 1매</p>
							<div class="price">35,000원</div>
						</div>
					</div>
				</a>
			</div>
		</div>
		
		<!-- 스낵, 음료 -->
		<div class="snackWrap">
			<div id="snackScroll">&nbsp;</div>
			<div class="sectionTitle">스낵/음료</div>
			<div class="itemWrap">
				<a href="/user/productDetailView?productCode=2" class="item item1">
					<img src="/images/sweetCombo.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>스위트 콤보</h4>
							<p>오리지널 팝콘 L + 탄산음료 M2</p>
							<div class="price">10,000원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=3" class="item item2">
					<img src="/images/doubleCombo.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>더블 콤보</h4>
							<p>오리지널 팝콘 M2 + 탄산음료 M2</p>
							<div class="price">14,000원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=4" class="item item3">
					<img src="/images/colaM.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>콜라 M</h4>
							<p>콜라 M</p>
							<div class="price">2,800원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=5" class="item item4">
					<img src="/images/colaL.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>콜라 L</h4>
							<p>콜라 L</p>
							<div class="price">3,300원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=6" class="item item5">
					<img src="/images/cM.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>사이다 M</h4>
							<p>사이다 M</p>
							<div class="price">2,800원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=7" class="item item6">
					<img src="/images/cL.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>사이다 L</h4>
							<p>사이다 L</p>
							<div class="price">3,300원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=8" class="item item7">
					<img src="/images/originalPopcornM.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>오리지널 팝콘 M</h4>
							<p>오리지널 팝콘 M</p>
							<div class="price">5,000원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=9" class="item item8">
					<img src="/images/originalPopcornL.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>오리지널 팝콘 L</h4>
							<p>오리지널 팝콘 L</p>
							<div class="price">5,500원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=10" class="item item9">
					<img src="/images/caramelPopcornM.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>카라멜 팝콘 M</h4>
							<p>카라멜 팝콘 M</p>
							<div class="price">6,000원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=11" class="item item10">
					<img src="/images/caramelPopcornL.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>카라멜 팝콘 L</h4>
							<p>카라멜 팝콘 L</p>
							<div class="price">6,500원</div>
						</div>
					</div>
				</a>
				<a href="/user/productDetailView?productCode=12" class="item item11">
					<img src="/images/halfPopcornL.jpeg">
					<div class="itemInfo">
						<div class="itm_tit">
							<h4>반반 팝콘(오리지널/카라멜) L</h4>
							<p>반반 팝콘(오리지널/카라멜) L</p>
							<div class="price">6,500원</div>
						</div>
					</div>
				</a>
			</div>
		</div>
	</div>
	<footer>푸터</footer>
<script>
	// 스크롤 부드럽게
	$(document).on('click', 'a[href^="#"]', function (event) {
	    event.preventDefault();	// 기능 차단
	    $('html, body').animate({
	        scrollTop: $($.attr(this, 'href')).offset().top
	    }, 300);
	});
	
	// 스크롤에 따라 보더
	$(window).scroll(function () { 
		let scrollY = $(document).scrollTop(); 
		if(scrollY < 1370){
			$("#best").css("border-bottom", "3px solid black");
			$("#best").css("color", "black");
			$("#ticket").css("border-bottom", "none");
			$("#ticket").css("color", "gray");
		}else if(scrollY > 1880){
			$("#ticket").css("border-bottom", "none");
			$("#ticket").css("color", "gray");
			$("#snack").css("border-bottom", "3px solid black");
			$("#snack").css("color", "black");
			
		}else{
			$("#best").css("border-bottom", "none");
			$("#best").css("color", "gray");
			$("#ticket").css("border-bottom", "3px solid black");
			$("#ticket").css("color", "black");
			$("#snack").css("border-bottom", "none");
			$("#snack").css("color", "gray");
		}
	    console.log(scrollY); //스크롤 y축 좌표
	});
</script>
</body>
</html>
