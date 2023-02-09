<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<!-- 등록된 영화 리스트 조회/삭제 페이지 -->
<h1>등록된 영화 리스트</h1>
<hr>
<table border="1">
	<tr>
		<th><input type="checkbox" id="allChk"></th>
		<th>영화코드</th>
		<th>포스터</th>
		<th>제목</th>
		<th>개봉일</th>
	</tr>
	<c:forEach var="movie" items="${mList }">
		<tr>
			<td><input type="checkbox" class="chk" value="${movie.movieCode }"></td>
			<td>${movie.movieCode }</td>
			<td><img src="/resources/imgs/${movie.postFileName }" width="100px">
			<td><a href="movieUpdate?movieCode=${movie.movieCode }">${movie.movieTitle }</a></td>
			<td>${movie.releaseDate }</td>
		</tr>
	</c:forEach>
</table>
<button onclick="location.href='movieReg'">영화등록하기</button>
<button id="btn_delMovies">선택삭제</button>

<script>
	$("#allChk").on("change", allChk);
	
	const all = document.querySelector("#allChk");
	const chks = document.querySelectorAll(".chk");
	
	function allChk(){
		for(let i = 0; i < chks.length; i++){
			chks[i].checked = all.checked;
		}
	};
	
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