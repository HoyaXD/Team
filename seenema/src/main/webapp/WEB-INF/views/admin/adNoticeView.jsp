<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Notice View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<style>
.notice_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

#notice_box {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 400px;
	height: 600px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}

.reginotice_modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}

#reginotice_box {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 600px;
	height: 600px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
}
</style>
</head>
<body>
	<h1>관리자 공지사항 View</h1>
	<button type="button" id="regiNotice_btn">공지사항 등록</button>
	<div class="reginotice_modal">
		<div id="reginotice_box">
			모달창 확인
			<button id="close_modal">X</button>
			<div id="regitext_box">
				<!-- 인풋박스 -->
				<form id="regi_frm" method="post">
					 <label>제목</label><br>
					 <input type="text" name="title" id="regiTitle" style="width:500px;"> <br>
					 <label>내용</label><br>
					 <textarea name="contents" id="regiContents" style="width:500px; height: 400px;"></textarea><br>
					<input type="button" id="regi_btn" value="등록하기">
				</form>
			</div>
		</div>
	</div>
	<hr>
	<table border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>등록일자</th>
				<th>조회수</th>
				<th>수정</th>
				<th>삭제
				<th>
			</tr>
		</thead>
		<tbody id="noTbody">
			<!-- 공지사항 출력 -->
		</tbody>
	</table>

	<div class="notice_modal">
		<div id="notice_box">
			모달창 확인
			<button id="close_modal">X</button>
			<div id="text_box"></div>
		</div>
	</div>

	<script>
		noticeListView();
		//공지사항 목록 출력
		function noticeListView() {
			$(document)
					.ready(
							function() {
								$
										.ajax({
											url : "adNoticeList",
											type : "get",
											dataType : "text",

											success : function(data) {
												let str = JSON.stringify(data);
												let obj = JSON.parse(data);
												let i = 0;
												for (i; i < obj.length; i++) {
													$("#noTbody")
															.append(
																	'<tr><td>'
																			+ obj[i].noticeCode
																			+ '</td><td>'
																			+ obj[i].title
																			+ '</td><td style="max-width:300px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">'
																			+ obj[i].contents
																			+ '</td><td>'
																			+ obj[i].regiDate
																			+ '</td><td>'
																			+ obj[i].hit
																			+ '</td><td>'
																			+ '<button id="noEditModal_btn">수정</button>'
																			+ '</td><td>'
																			+ '<button id="noDel_btn">삭제</button>'
																			+ '</td><tr>'

															)
												}
											},
											error : function() {
												alert("공지사항 출력 실패!");
											}
										});
							});
		}

		//수정
		$(document)
				.on(
						"click",
						"#noEditModal_btn",
						function(e) {
							var targetNum = $(e.target).parent().parent()
									.children().first().text();
							$(".notice_modal").css('display', 'block');

							//모달창에 출력
							$
									.ajax({
										url : "selectNotice",
										type : "get",
										data : {
											noticeCode : targetNum
										},
										dataType : "text",

										success : function(data) {
											let str = JSON.stringify(data);
											let obj = JSON.parse(data);
											$("#text_box").empty();
											$("#text_box")
													.append(
															'<form id="edit_frm" method="post">'
																	+ '공지글 번호'
																	+ '<input type="text" name="noticeCode" id="noticeCode" value="' + obj[0].noticeCode + '"><br>'
																	+ '등록일자'
																	+ '<input type="text" name="regiDate" id="regiDate" value="' + obj[0].regiDate + '"><br>'
																	+ '조회수'
																	+ '<input type="text" name="hit" id="hit" value="' + obj[0].hit + '"><br>'
																	+ '제목'
																	+ '<input type="text" name="title" id="title" value="' + obj[0].title + '"><br>'
																	+ '내용'
																	+ '<textarea name="contents" id="contents" value="' + '" style="width:400px; height:200px;">'
																	+ obj[0].contents
																	+ '</textarea><br>'
																	+ '<input type="button" value="수정" id="noEdit_btn">'
																	+ '</form>'
																	+ '<button id="close_modal">닫기</button>')

										},
										error : function() {
											alert("공지사항 출력 실패!");
										}
									});
						});

		//모달창안에 x버튼
		$(document).on("click", "#close_modal", function(e) {
			$(".notice_modal").css('display', 'none');
			$(".reginotice_modal").css('display', 'none');
		});

		//공지사항 삭제
		$(document).on(
				"click",
				"#noDel_btn",
				function(e) {
					var targetNum = $(e.target).parent().parent().children()
							.first().text();
					$.ajax({
						url : "noticeDel",
						type : "get",
						data : {
							noticeCode : targetNum
						},
						success : function(data) {
							$("#noTbody").empty();
							noticeListView();
						},
						error : function() {
						}
					});
				});

		//수정버튼누르면 실행
		$(document).on("click", "#noEdit_btn", function(e) {
			var form = $("#edit_frm").serialize();

			$.ajax({

				type : "post",
				url : "editNotice",
				data : form,
				dataType : "json",
				success : function(json) {
					$("#noTbody").empty();
					noticeListView();
				},
				error : function(request, status, error) {
					//리턴을 안줘서 수정성공시 여기서 출력
					$(".notice_modal").css('display', 'none');
					$("#noTbody").empty();
					noticeListView();
				}

			});
		});

		//등록버튼 클릭
		$(document).on("click", "#regiNotice_btn", function(e) {
			$(".reginotice_modal").css('display', 'block');
			alert("등록버튼 누름!");
		});

		//공지사항 등록
		$(document).on("click", "#regi_btn", function(e) {
			var form = $("#regi_frm").serialize();
			$.ajax({
				url : "regiNotice",
				type : "post",
				data : form,
				dataType : "json",
				success : function(json) {
					$("#noTbody").empty();
					noticeListView();
				},
				error : function(request, status, error) {
					//리턴을 안줘서 수정성공시 여기서 출력
					$(".reginotice_modal").css('display', 'none');
					$("#noTbody").empty();
					noticeListView();
				}

			});
		});
	</script>

</body>
</html>