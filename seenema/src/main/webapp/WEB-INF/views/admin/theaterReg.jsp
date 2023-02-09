<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>영화관 등록 페이지</h1>
<hr>
<form action="theaterReg.do" method="post">
	<table border="1">
		<tr>
			<th>상영관 지역</th>
			<td>
				<select name="theaterPlace" size="1">
					<option>지역선택</option>
					<option value="서울특별시">서울특별시</option>
					<option value="인천광역시">인천광역시</option>
					<option value="대전광역시">대전광역시</option>
					<option value="대구광역시">대구광역시</option>
					<option value="부산광역시">부산광역시</option>
					<option value="광주광역시">광주광역시</option>
					<option value="창원특례시">창원특례시</option>	
				</select>
			</td>
		</tr>
		<tr>
			<th>상영관 이름</th>
			<td><input type="text" name="theaterName"></td>	
		</tr>
		<tr>
			<th>주소</th>
			<td><input type="text" name="theaterAddress"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text" name="theaterTel"></td>
		</tr>
		<tr>
			<th>좌석수</th>
			<td><input type="text" name="theaterSeats">석</td>
		</tr>
		<tr>
			<th rowspan="2">지도</th>
			<th>위도 : <input type="text" name="latitude"></th>
			
		</tr>
		<tr>
			<th>경도 : <input type="text" name="longitude"></th>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="등록하기">
			</th>
		</tr>
	</table>
</form>
</body>
</html>