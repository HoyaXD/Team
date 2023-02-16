<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	*{
		font-family: "Noto Sans KR", "Roboto", "dotum", "sans-serif";
	}
</style>
</head>
<body>
<!-- 등록된 영화 리스트 조회/삭제 페이지 -->
<h1>등록된 영화 리스트</h1>
<hr>
<h3>영화검색</h3>
<table border="1">
	<tr>
		<th>
			<select name="serchType" id="serchType" size="1">
				<option>-선택-</option>
				<option value="MovieTitle">영화제목으로 검색</option>
				<option value="MovieDate">개봉일로 검색</option>
				<option value="MovieTitleDate">제목+개봉일로 검색</option>
			</select>
			<span id="serchBox">
				<input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
			</span>
			<button id="btn_serchMovie" onclick="serchMovie();">검색</button>
			<button onclick="location.href='movieList'">초기화</button>
		</th>	
		
	</tr>
</table>
<hr>
<table border="1">
	<thead id="thead">
		<tr>
			<th><input type="checkbox" id="allChk"></th>
			<th>영화코드</th>
			<th>포스터</th>
			<th>제목</th>
			<th>개봉일</th>
		</tr>
	</thead>
	<tbody id="tbody">
		<c:forEach var="movie" items="${mList }">
			<tr>
				<td><input type="checkbox" class="chk" value="${movie.movieCode }"></td>
				<td>${movie.movieCode }</td>
				<td><img src="/resources/imgs/${movie.postFileName }" width="100px">
				<td><a href="movieUpdate?movieCode=${movie.movieCode }">${movie.movieTitle }</a></td>
				<td>${movie.releaseDate }</td>
			</tr>
		</c:forEach>
		<tr>
			<th colspan="5">
				<button onclick="location.href='movieReg'">영화등록하기</button>
				<button id="btn_delMovies">선택삭제</button>
			</th>
		</tr>
	</tbody>
	
</table>

<script>
	//전체선택
	$("#allChk").on("change", allChk);
	
	const all = document.querySelector("#allChk");
	const chks = document.querySelectorAll(".chk");
	
	function allChk(){
		for(let i = 0; i < chks.length; i++){
			chks[i].checked = all.checked;
		}
	};
	
	//선택삭제
	$("#btn_delMovies").on("click", movies_delete);
	function movies_delete(){
		
		let chked = new Array();
		
		for(let i = 0; i < chks.length; i++){
			if(chks[i].checked){
				chked.push(chks[i].value);
			}
		}
		
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function() {
		let result = this.responseText; 
			if(result == 1){
				alert("삭제완료!");
				location.href="movieList";
			}else{
				alert("삭제실패..");
				location.href="movieList";
			}
		}
		
		xhttp.open("GET", "movies_delete.do?movieCodes="+chked, true); 
			
		xhttp.send();
		}
</script>
<script>
	//serchType에 따른 검색창 변화
	 $("#serchType").change(function(e){
		 if($("#serchType option:selected").val() == "MovieTitle"){
			 $("#serchBox").html("<span>"+
					 				"<input type='text' id='serchWord' placeholder='검색어를 입력해주세요.'>"+
					 			"</span>");
			 
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			
			 $("#serchBox").html("<span>"+
					 				"<input type='date' id='start' name='start'> -"+
					 				"<input type='date' id='end' name='end'>"+
					 			"</span>"); 
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			 $("#serchBox").html("<span>"+
					 					"<input type='text' id='serchWord' name='serchWord' placeholder='검색어를 입력해주세요.'>"+
		 								"&nbsp;<input type='date' id='start' name='start'> - "+
		 								"<input type='date' id='end' name='end'>"+
		 						"</span>"); 
		 }
	});
	
	function serchMovie(){
		let serchWord = $("#serchWord").val();
		let startDate = $("#start").val();
		let endDate = $("#end").val();
		
		if($("#serchType option:selected").val() == "MovieTitle"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				
				$("#thead").html("<tr>"+
									"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th>영화코드</th>"+
									"<th>포스터</th>"+
									"<th>제목</th>"+
									"<th>개봉일</th>"+
								"</tr>");
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append("<tr>"+
											"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
											"<td>"+obj[i].movieCode+"</td>"+
											"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='100px'></td>"+
											"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
											"<td>"+obj[i].releaseDate+"</td>"+
										"</tr>");
				}
				$("#tbody").append("<tr>"+
										"<td colspan='5'>"+
										"<button onclick='goProductRegPage();'>영화등록</button>"+
										"<button id='js_del'>선택삭제</button>"+
										"</td>"+
									"</tr>");
				
			}	//onload
			xhttp.open("GET", "serchMvByTitle.do?movieTitle=" + serchWord, true); 
			
			xhttp.send();
			
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				
				$("#thead").html("<tr>"+
									"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th>영화코드</th>"+
									"<th>포스터</th>"+
									"<th>제목</th>"+
									"<th>개봉일</th>"+
								"</tr>");
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append("<tr>"+
											"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
											"<td>"+obj[i].movieCode+"</td>"+
											"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='100px'></td>"+
											"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
											"<td>"+obj[i].releaseDate+"</td>"+
										"</tr>");
				}
				$("#tbody").append("<tr>"+
										"<td colspan='5'>"+
										"<button onclick='goProductRegPage();'>영화등록</button>"+
										"<button id='js_del'>선택삭제</button>"+
										"</td>"+
									"</tr>");
				
			}	//onload
			xhttp.open("GET", "serchMvByDate.do?startDate=" + startDate+ "&endDate=" + endDate, true); 
			
			xhttp.send();
				
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				
				$("#thead").html("<tr>"+
									"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th>영화코드</th>"+
									"<th>포스터</th>"+
									"<th>제목</th>"+
									"<th>개봉일</th>"+
								"</tr>");
				
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append("<tr>"+
											"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
											"<td>"+obj[i].movieCode+"</td>"+
											"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='100px'></td>"+
											"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
											"<td>"+obj[i].releaseDate+"</td>"+
										"</tr>");
				}
				
				$("#tbody").append("<tr>"+
										"<td colspan='5'>"+
										"<button onclick='goProductRegPage();'>영화등록</button>"+
										"<button id='js_del'>선택삭제</button>"+
										"</td>"+
									"</tr>");
				
			}	//onload
			xhttp.open("GET", "serchMvByTitleDate.do?startDate=" + startDate+ "&endDate=" + endDate + "&movieTitle=" + serchWord, true); 
		
			xhttp.send();
		 }//else
	}//function
	
	//조회 전체 선택
	 $("#thead").on('click', $('#js_allChk'), function(){
		if($('input:checkbox[name="js_allChk"]').prop("checked") == true){
			 $('input:checkbox[name="js_chk"]').each(function() {
			     	this.checked = true;
			     	
			 });
		}else if($('input:checkbox[name="js_allChk"]').prop("checked") == false){
			 $('input:checkbox[name="js_chk"]').each(function() {
			     	this.checked = false;
			 });
		}
	});
	
	//조회 선택 삭제
	$("#tbody").on("click", $("#js_del"), serchDelete);
	function serchDelete(e){
		
		let checked_val = new Array();
		
		$('input:checkbox[name="js_chk"]').each(function() {
	     	if(this.checked){ //체크박스 체크되면
	     		checked_val.push(this.value); //체크박스 value를 배열에 담음
	     	};
		 });
		
		if(e.target.id == "js_del"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
			let result = this.responseText; 
				
				if(result == 1){
					alert("삭제완료!");
					location.href="movieList";
				}else{
					alert("삭제실패..");
					location.href="movieList";
				}
			}
			
			xhttp.open("GET", "delMoviesByCodes.do?movieCodes=" + checked_val, true); 
				
			xhttp.send();
		}
	}
</script>

<c:if test="${param.insert_result == 1 }">
	<script>
		alert("등록완료!");
	</script>
</c:if>
<c:if test="${param.insert_result == 0 }">
	<script>
		alert("등록실패..");
	</script>
</c:if>
<c:if test="${param.del_result == 1 }">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0 }">
	<script>
		alert("삭제실패..");
	</script>
</c:if>
<c:if test="${param.update_result == 1 }">
	<script>
		alert("수정성공!");
	</script>
</c:if>
<c:if test="${param.update_result == 0 }">
	<script>
		alert("수정실패..");
	</script>
</c:if>
</body>