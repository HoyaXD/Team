<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Member Management View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<h1>회원관리페이지</h1>
	<hr>
	<select id="choiceMenu">
		<option value="userId">아이디로 검색</option>
		<option value="userName">이름으로 검색</option>
		<option value="userGrade">등급으로 검색</option>
	</select>
	<div id="searchBox">
		<input type="text" id="keyC" placeholder="검색어 입력"> 
		<input type="button" id="search_btn" value="검색"> 
		<input type="button" id="reset_btn" value="초기화">
	</div>
	<hr>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>이름</th>
					<th>성별</th>
					<th>생년월일</th>
					<th>연락처</th>
					<th>등급</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="tbodyView">
				<tr>
					<!-- tbody에서 출력 -->

				</tr>
			</tbody>
		</table>
	</div>
	<button id="btn">버튼</button>
	<script>
		listView();
		//비동기를 하여 계속 해서 보이게끔 하기
		function listView() {

			$(document)
					.ready(
							function() {

								$
										.ajax({
											url : "MemberListView",
											type : "get",
											datatype : "text",

											success : function(data) {
												let obj = JSON.stringify(data);
												let parse = JSON.parse(obj);
												let i = 0;

												for (i; i < parse.length; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ parse[i].id
																			+ '</td><td>'
																			+ parse[i].pw
																			+ '</td><td>'
																			+ parse[i].name
																			+ '</td><td>'
																			+ parse[i].gender
																			+ '</td><td>'
																			+ parse[i].tel
																			+ '</td><td>'
																			+ parse[i].birthday
																			+ '</td><td>'
																			+ parse[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});
							});
		}

		//수정버튼을 누르면 수정창이 나온다.
		$(document)
				.on(
						"click",
						".adjm_btn",
						function(e) {

							var target = $(e.target).parent().parent()
									.children().first().text();
							let id = target;
							alert(id);
							let url = "memEditPop?id=" + id;
							window
									.open(url, "회원정보수정",
											"width=500, height=700, scrollbars=yes, resizable=no");

							$.ajax({

								url : "PopOneList",
								type : "get",
								datatype : "text",

								success : function(data) {
									alert("수정이벤트발생");

									alert(data);
									let obj = JSON.stringify(data);
									let parse = JSON.parse(obj);
									let i = 0;

									for (i; i < parse.length; i++) {

									}
								}

							});

						});

		//삭제버튼 누르면 삭제하기
		$(document).on(
				"click",
				".del_btn",
				function(e) {
					var target = $(e.target).parent().parent().children()
							.first().text();
					$.ajax({
						url : "MemberDel",
						type : "get",
						data : {
							id : target
						},

						success : function() {
						},
						error : function() {
							$("#tbodyView").empty();
							listView();
						}
					});
				});

		//검색기능을 이용하여 목록출력
		$(document)
				.on(
						"click",
						"#search_btn",
						function(e) {
							var userId = "userId";
							var userName = "userName";
							var userGrade = "userGrade";
							//아이디로 회원목록 출력
							if ($("#choiceMenu option:selected").val() == userId) {
								var form = $("#keyC").val();

								$
										.ajax({

											type : "GET",
											url : "memberView/MemberIdView",
											data : {
												id : form
											},
											dataType : "JSON",

											success : function(data) {
												let obj = JSON.stringify(data);
												let parse = JSON.parse(obj);
												//한명의 회원목록 수정창을 닫음
												//회원목록을 보여주는 창을 새로고침
												let i = 0;
												$("#tbodyView").empty();
												for (i; i < parse.length; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ parse[i].id
																			+ '</td><td>'
																			+ parse[i].pw
																			+ '</td><td>'
																			+ parse[i].name
																			+ '</td><td>'
																			+ parse[i].gender
																			+ '</td><td>'
																			+ parse[i].tel
																			+ '</td><td>'
																			+ parse[i].birthday
																			+ '</td><td>'
																			+ parse[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}

										});
								//이름으로 회원목록 출력

							} else if ($("#choiceMenu option:selected").val() == userName) {
								var name = $("#keyC").val();
								$
										.ajax({

											type : "GET",
											url : "memberView/MemberNameView",
											data : {
												name : name
											},
											dataType : "JSON",

											success : function(data) {
												let obj = JSON.stringify(data);
												let parse = JSON.parse(obj);
												//한명의 회원목록 수정창을 닫음
												//회원목록을 보여주는 창을 새로고침
												let i = 0;
												$("#tbodyView").empty();
												for (i; i < parse.length; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ parse[i].id
																			+ '</td><td>'
																			+ parse[i].pw
																			+ '</td><td>'
																			+ parse[i].name
																			+ '</td><td>'
																			+ parse[i].gender
																			+ '</td><td>'
																			+ parse[i].tel
																			+ '</td><td>'
																			+ parse[i].birthday
																			+ '</td><td>'
																			+ parse[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});

								//등급으로 회원목록 출력
							} else if ($("#choiceMenu option:selected").val() == userGrade) {
								var grade = $("#keyC").val();
								$
										.ajax({
											type : "GET",
											url : "memberView/MemberGradeView",
											data : {
												grade : grade
											},
											dataType : "JSON",

											success : function(data) {
												let obj = JSON.stringify(data);
												let parse = JSON.parse(obj);
												let i = 0;
												$("#tbodyView").empty();
												for (i; i < parse.length; i++) {

													$("#tbodyView")
															.append(
																	'<tr><td>'
																			+ parse[i].id
																			+ '</td><td>'
																			+ parse[i].pw
																			+ '</td><td>'
																			+ parse[i].name
																			+ '</td><td>'
																			+ parse[i].gender
																			+ '</td><td>'
																			+ parse[i].tel
																			+ '</td><td>'
																			+ parse[i].birthday
																			+ '</td><td>'
																			+ parse[i].grade
																			+ '</td><td>'
																			+ '<button class="adjm_btn" type="button">수정</button>'
																			+ '</td><td>'
																			+ '<button class="del_btn">삭제</button>'
																			+ '</td/></tr>')
												}
											},
											error : function() {
												alert("회원 목록 출력 실패!");
											}
										});

							}
						});

		$(document).on("click", "#reset_btn", function(evt) {
			$("#tbodyView").empty();
			listView();
		});
	</script>
</body>
</html>
