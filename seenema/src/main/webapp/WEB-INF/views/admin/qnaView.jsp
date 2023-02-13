<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Q&A View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<style>
	.ans_modal {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		display: none;
		background-color: rgba(0, 0, 0, 0.4);
	}
	
	#ans_box {
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
</style>
</head>
<body>
	<h1>Q&A 페이지</h1>
	<hr>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>아이디</th>
					<th>파일유무</th>
					<th>등록시간</th>
					<th>답변</th>
				</tr>
			</thead>
			<tbody id="qnaTbody">
				<!-- 여기에 회원이 작성한 QnA출력 -->
				
			</tbody>
		</table>
	</div>

	<div class="ans_modal">
		<div id="ans_box">모달창 확인
			<button id="close_modal">X</button>
			<div id="text_box">
				
				
			</div>
		</div>
	</div>

	<script>
		$(document)
				.ready(
						function() {
							$
									.ajax({

										url : "qnaList",
										type : "get",
										datatype : "text",

										success : function(data) {
											let str = JSON.stringify(data);
											let obj = JSON.parse(str);
											let i = 0;

											for (i; i < obj.length; i++) {
												//regidate가 타입이 timestamp라서 10번째까지 잘라줌
												var resultDate = obj[i].regiDate
														.substring(0, 10);

												$("#qnaTbody")
														.append(
																'<tr><td>'
																		+ obj[i].qcode
																		+ '</td><td>'
																		+ obj[i].title
																		+ '</td><td style="max-width:150px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">'
																		+ obj[i].contents
																		+ '</td><td>'
																		+ obj[i].id
																		+ '</td><td>'
																		+ obj[i].fileName
																		+ '</td><td>'
																		+ resultDate
																		+ '</td><td>'
																		+ '<button id="ans_btn">답변하기</button>'
																		+ '</td></tr>')//포문 끝

											}
										},

										error : function() {
											alert("Q&A 목록 출력 실패!");
										}
									});
						});

		//답변버튼 누르면 모달창 나옴
		$(document).on("click", "#ans_btn", function(e) {
			
			var targetNum = $(e.target).parent().parent().children().first().text();
			$(".ans_modal").css('display', 'block');
			
			//qcode보냄
			$.ajax({
				url : "qnaOneList",
				type : "get",
				data : { qcode : targetNum },
				datatype : "JSON",
				success : function(data){
					let str = JSON.stringify(data);
					let obj = JSON.parse(str);
					var resultDate = obj.regiDate.substring(0, 10);
					var resultTime = obj.regiDate.substring(11, 16);
					$("#text_box").empty();
					$("#text_box").append(
						'제목' + '<input type="text" value="'+ obj.title + '" readonly><br> ' +
						'아이디' + '<input type="text" value="'+ obj.id + '" style="width:50px;"readonly> ' +
						'등록시간' + '<input type="text" value="'+ resultDate +"     "+ resultTime + '" readonly><br> ' + 
						'내용<br>' + '<textarea style="width:400px; height:200px;">'+ obj.contents + 
						'\n\n' + '-------------------------------------------------------' +
						'\n\n' +'안녕하세요. 영화를 사랑하는 Seenema 고객센터입니다.' + 
						'</textarea>' + 
						'<button>수정하기</button>' + '<button id="close_modal">닫기</button>'
					)
					
				},
				error : function(){
				}
			});
		});
		//모달창안에 x버튼
		$(document).on("click", "#close_modal", function(e) {
			$(".ans_modal").css('display', 'none');
		});
	</script>

</body>
</html>