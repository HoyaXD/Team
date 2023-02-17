<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.setAttribute("id", "kim");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 상세보기 페이지</title>
<link rel="stylesheet" href="/css/movieDetailView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<header>헤더</header>
		<main>
			<div class="movieInfoWrap">
				<!-- 영화 포스터 이미지 -->
				<div class="movieImage">영화 포스터</div>
				<!-- 상단 영화 정보 박스 -->
				<div class="movieInfo">
					<div class="movieTitle">
						<div id="title">타이타닉</div>
						<div id="titleReservationStatus">예매중</div>
						<div id="titleDday">D-1</div>
					</div>
					<div class="movieEnglishTitle">Titanic</div>
					<div class="reservationRate">예매율 33.4%</div>
					<div class="director_ActorInfoWrap">
						<div id="director_Actor">감독 : 제임스 카메론 / 배우 : 레오나르도 디카프리오 , 케이트 윈슬렛</div>
						<div id="genre">장르 : 드라마, 로맨스, 멜로, 액션 / 기본 : 15, 195분, 미국</div>
						<div id="openDate">개봉 : 2023.02.08</div>
					</div>
				</div>
			</div>
			<div class="movieContent">
				<ul class="tabMenu">
					<li class="item"><a href="#">주요정보</a></li>
					<li class="item"><a href="#">트레일러</a></li>
					<li class="item"><a href="#">스틸컷</a></li>
					<li class="item"><a href="#">평점/리뷰</a></li>
				</ul>
			</div>
			<!-- 댓글 컨텐츠 박스 -->
			<div class="replySection">
				<div id="replyTopWrap">
					<div id="replySectionTitle">한줄평</div>
					<input type="button" id="regReplyBtn" value="평점작성">
				</div>
				<!-- 댓글 작성 영역 -->
				<form name="replyForm" id="replyForm">
					<fieldset>
						<input type="radio" class="star" name="rate" value="5" id="rate5"><label for="rate5">★</label>
						<input type="radio" class="star" name="rate" value="4" id="rate4"><label for="rate4">★</label>
						<input type="radio" class="star" name="rate" value="3" id="rate3"><label for="rate3">★</label>
						<input type="radio" class="star" name="rate" value="2" id="rate2"><label for="rate2">★</label>
						<input type="radio" class="star" name="rate" value="1" id="rate1"><label for="rate1">★</label>
					</fieldset>
					<textarea id="comment" name="comment" maxlength="50" placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다."></textarea>
					<div id="textWrap">
						<div id="noticeComment">※ 이 댓글에 대한 법적 책임은 작성자에게 귀속됩니다.</div>
						<div class="commentCount">0자</div>
			        	<div class="textTotal">&nbsp;/&nbsp;50자</div>
					</div>
					<input type="hidden" name="id" id="id" value="${sessionScope.id }">
					<input type="hidden" name="movieCode" id="movieCode" value="22"><!-- 영화코드(나중에 삭제해야함) -->
				</form>
				<div class="replyList">
					<!-- 댓글 목록  -->
				</div>
				<div class="beforeAfterWrap">
					<div id="beforeBtn">이전</div>
					<div id="afterBtn">다음</div>
				</div>
				<!-- 댓글 수정 박스 -->
				<div id="updateReplyBox">
					<div id="updateReplyBoxTop">
						<div id="updateReplyBoxTitle">한줄평 수정</div>
						<div id="closeBtn">X</div>
					</div>
					<div class="updateReplyBoxWriteSection">
						<div id="updateReplyBoxmovieTitle">
							타이타닉
						</div>
						<form name="updateReplyForm" id="updateReplyForm">
							<fieldset>
								<input type="radio" class="star" name="updateRate" value="5" id="updateRate5"><label for="updateRate5">★</label>
								<input type="radio" class="star" name="updateRate" value="4" id="updateRate4"><label for="updateRate4">★</label>
								<input type="radio" class="star" name="updateRate" value="3" id="updateRate3"><label for="updateRate3">★</label>
								<input type="radio" class="star" name="updateRate" value="2" id="updateRate2"><label for="updateRate2">★</label>
								<input type="radio" class="star" name="updateRate" value="1" id="updateRate1"><label for="updateRate1">★</label>
							</fieldset>
							<textarea id="updateReplyFormComment" name="updateComment" maxlength="50" placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다."></textarea>
							<div id="updateReplyFormTextWrap">
								<div id="updateReplyFormNoticeComment">※ 이 댓글에 대한 법적 책임은 작성자에게 귀속됩니다.</div>
								<div class="updateReplyFormCommentCount">0자</div>
						       	<div class="updateReplyFormTextTotal">&nbsp;/&nbsp;50자</div>
							</div>
							<input type="hidden" id="updateBoxReplyCode" value="">
							<input type="hidden" name="id" id="uId">
							<input type="hidden" name="movieCode" id="movieCode" value="22">	<!-- 나중에 삭제 -->
						</form>
						<div id="updateReplyDoBtn">수정</div>
					</div>
				</div>
			</div>
		</main>
		<footer>푸터</footer>
	</div>
<script>
	getReplyList();
	// 댓글 목록
	function getReplyList(){
		const id = $("#id").val();
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			document.querySelector(".replyList").replaceChildren();
			$(obj).each(function(index){
				//console.log(obj[index].comment);
				let star;
				let unstar;
				let rate;
				if(obj[index].rate == "1"){
					star = "★";
					unstar = "★★★★";
					rate = "1";
				}else if(obj[index].rate == "2"){
					star = "★★";
					unstar = "★★★";
					rate = "2";
				}else if(obj[index].rate == "3"){
					star = "★★★";
					unstar = "★★";
					rate = "3";
				}else if(obj[index].rate == "4"){
					star = "★★★★";
					unstar = "★";
					rate = "4";
				}else{
					star = "★★★★★";
					rate = "5";
				}
				$(".replyList").append(
						"<div class='replyBox'>"
							+ "<input type='hidden' id='replyCode' value=" + this.replyCode + ">"
							+ "<div class='replyBoxTop'>"
							+ (rate != 5? 
									"<div id='replyStar'>" 
										+ "<span class='star'>" + star + "</span>" 
										+ "<span class='unstar'>" + unstar + "</span>" 
									+ "</div>" 
									+ "<div id='replyRate'>" + rate + "</div>"
									: 
									"<div id='replyStar'>" 
										+ "<span class='star'>" + star + "</span>" 
									+ "</div>" 
									+ "<div id='replyRate'>" + rate + "</div>")
								+ (id == this.id? "<div class='btnWrap'><div id='updateBtn'>수정</div><div id='deleteBtn'>삭제</div></div>" : "")
							+ "</div>"
							+ "<div id='replyComment'>" + this.comment + "</div>" 
							+ "<div class='replyBoxBottom'>"
								+ "<div id='replyId'>" + this.id + "</div>"
								+ "<div id='replyRegDate'>" + this.regDate + "</div>"
							+ "</div>"
						+ "</div>"
				);
			});
		}
		xhttp.open("post", "/user/getReplyList.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send();
	}
	
	// 댓글 등록
	$("#regReplyBtn").on("click", function(){
		if($("input[name='rate']:checked").val() == null){
			alert("평점을 선택해주세요!");
		}else if($("#comment").val() == ""){
			alert("한줄평을 입력해주세요!");
		}else{
			//alert("별점 : " + $("input[name='reviewStar']:checked").val() + "\n댓글 내용 : " + $("#comment").val());
			// 등록 실행
			const formData = $(replyForm).serialize();
			$.ajax({
				url: "/user/regReply.do",
				type: "post",
				data: formData,
				dataType: "json",
				success: function(data){
					let result = parseInt(data, 10);
					if(result == 1){	// 댓글 등록 성공
						alert("댓글을 성공적으로 등록하였습니다!");
						$("#comment").val("");	// 댓글 내용 초기화
						$(".commentCount").text("0자");	// 댓글카운트 초기화
						$("input[type=radio]").prop("checked", false);	// 별점 초기화
						getReplyList();	// 댓글 목록 갱신
					}else{	// 댓글 등록 실패
						alert("댓글등록에 실패했습니다.");
					}
				},
				error: function(){	// 에러
					alert("댓글등록에 실패했습니다.");
				}
			});
		}
	});
	
	// 댓글 글자수 카운트
	$("#comment").keyup(function(e){
		let comment = $(this).val();
		if(comment.length == 0 || comment == ""){
			// 코멘트 입력 X
			$(".commentCount").text("0자");
		}else{
			$(".commentCount").text(comment.length + "자");
		}
	});
	
	// 댓글 수정박스 글자수 카운트
	$("#updateReplyFormComment").keyup(function(e){
		let comment = $(this).val();
		if(comment.length == 0 || comment == ""){
			// 코멘트 입력 X
			$(".updateReplyFormCommentCount").text("0자");
		}else{
			$(".updateReplyFormCommentCount").text(comment.length + "자");
		}
	});
	
	// 댓글 수정박스 열기	
	$(document).on("click", "#updateBtn", function(e){
		let replyCode = e.target.parentElement.parentElement.parentElement.children[0].value;
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let obj = JSON.parse(data);
			$("#updateReplyFormComment").val(obj.comment);
			$("#updateRate" + obj.rate).prop('checked', true);
			$("#updateReplyBox").css("display", "block");
			$("#updateBoxReplyCode").val(replyCode);
			$("#uId").val(obj.id);
		}
		xhttp.open("post", "/user/getReplyInfo.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("replyCode=" + replyCode);
	});
	
	// 댓글 수정박스 닫기
	$("#closeBtn").on("click", function(){
		$("#updateReplyBox").css("display", "none");
		$("#updateReplyFormComment").val("");
		$("input[name='updateRate']").prop("checked", false);
		$("#updateBoxReplyCode").val("");
	});
	
	// 댓글 수정 실행
	$("#updateReplyDoBtn").on("click", function(){
		if($("#updateReplyFormComment").val() == ""){
			alert("코멘트를 입력해주세요!");
			return;
		}else if($("input[name='updateRate']:checked").val() == null){
			alert("평점을 선택해주세요!");
			return;
		}else{
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function(){
				let data = this.responseText;
				let result = parseInt(data, 10);
				if(result == 1){
					alert("수정 성공!");
					$("#updateReplyBox").css("display", "none");
					$("#updateReplyFormComment").val("");
					//$("#updateRate" + obj.rate).prop('checked', false);
					$("#updateBoxReplyCode").val("");
					getReplyList();	// 댓글 목록 갱신
				}else{
					alert("수정 실패!");
				}
			}
			let rate = $("input[name='updateRate']:checked").val();
			let comment = $("#updateReplyFormComment").val();
			let replyCode = $("#updateBoxReplyCode").val();
			console.log("평점 : " + rate + "\n코멘트 : " + comment + "\n댓글 코드 : " + replyCode);
			
			xhttp.open("post", "updateReply.do", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send("rate=" + rate + "&comment=" + comment + "&replyCode=" + replyCode);
		}
	});
	
	// 댓글 삭제
	$(document).on("click", "#deleteBtn", function(e){
		const replyCode = e.target.parentElement.parentElement.parentElement.children[0].value;
		replyCode;
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = this.responseText;
			if(result == "1"){
				alert("댓글을 삭제 완료.");
				getReplyList();
			}else{
				alert("댓글 삭제 실패");
			}
		}
		xhttp.open("post", "/user/deleteReply.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("replyCode=" + replyCode);
	});
	
</script>
</body>
</html>