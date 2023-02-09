<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 영화등록페이지 -->
<h1>영화등록페이지</h1>
<hr>
<form action="movieUplode.do" method="post" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<th>영화 이름</th>
			<td><input type="text" name="movieTitle" id="movieTitle"></td>
		</tr>
		<tr>
			<th>장르</th>
			<td><input type="text" name="genre" id="genre"></td>
		</tr>
		<tr>
			<th>줄거리</th>
			<td><textarea name="plot" id="plot"></textarea></td>
		</tr>
		<tr>
			<th>감독</th>
			<td><input type="text" name="director" id="director"></td>
		</tr>
		<tr>
			<th>배우</th>
			<td><input type="text" name="actors" id="actors"></td>
		</tr>
		<tr>
			<th>관람연령</th>
			<td><input type="text" name="viewAge" id="viewAge"></td>
		</tr>
		<tr>
			<th>개봉날짜</th>
			<td><input type="date" name="releaseDate" id="releaseDate"></td>
		</tr>
		<tr>
			<th>러닝타임</th>
			<td><input type="text" name="runningTime" id="runningTime"></td>
		</tr>
		<tr>
			<th>예고편URL</th>
			<td><input type="text" name="previewURL" id="previewURL"></td>
		</tr>
		<tr>
			<th>이미지파일 업로드</th>
			<td><input type="file" name="photoFileName" id="photoFileName"></td>
		</tr>
		<tr>
			<th colspan="2"><input type="submit" value="등록하기"></th>
		</tr>
	</table>
</form>

</body>
</html>