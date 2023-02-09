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
<!-- 영화정보 수정페이지 -->
<h1>영화 정보 수정페이지</h1>
<hr>
<form action="movieUpdate.do" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<td colspan="2"><img src="/resources/imgs/${movie.postFileName }" width="200px">
		</tr>
		<tr>
			<th>영화코드</th> 
			<td><input type="text" name="movieCode" id="movieCode" value="${movie.movieCode }" readonly></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="movieTitle" value="${movie.movieTitle }">
		</tr>
		<tr>
			<th>장르</th>
			<td><input type="text" name="genre" value="${movie.genre }"></td>
		</tr>
		<tr>
			<th>줄거리</th>
			<td><textarea name="plot">${movie.plot }</textarea>
		</tr>
		<tr>
			<th>감독</th>
			<td><input type="text" name="director" value="${movie.director }"></td>
		</tr>
		<tr>
			<th>배우</th>
			<td><input type="text" name="actors" value="${movie.actors }"></td>
		</tr>
		<tr>
			<th>관람연령</th>
			<td><input type="text" name="viewAge" value="${movie.viewAge }"></td>
		</tr>
		<tr>
			<th>개봉일</th>
			<td><input type="date" name="releaseDate" value="${movie.releaseDate }"></td>
		</tr>
		<tr>
			<th>러닝타임</th>
			<td><input type="text" name="runningTime" value="${movie.runningTime }"></td>
		</tr>
	 	<tr>
	 		<th>예고편URL</th>
	 		<td><input type="text" name="previewURL" value="${movie.previewURL }"></td>
	 	</tr>
	 	<tr>
			<th rowspan="2">포스터</th>
	 		<td>현재파일:<input type="text" name="postFileName" value="${movie.postFileName }" readonly></td>
			
	 	</tr>
	 	<tr>
	 	<td><input type="file" name="photoFileName" value="${movie.postFileName }"></td>
	 	</tr>
	 	<tr>
	 		
	 		<th colspan="2">
		 		<input type="button" value="삭제하기" id="delBtn">
		 		<input type="submit" value="수정하기">
	 		</th>
	 	</tr>
	</table>
</form>
<script>
	$("#delBtn").on("click", function(){
		location.href="movieDelete.do?movieCode=" + $("#movieCode").val();
	});
</script>
</body>
</html>