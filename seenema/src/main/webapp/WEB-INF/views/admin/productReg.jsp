<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>상품등록페이지</h1>
	<hr>
	<form action="productReg.do" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<th>상품명</th><td><input type="text" name="productName" required></td>
			</tr>
			<tr>
				<th>가격</th><td><input type="text" name="price" required>원</td>
			</tr>
			<tr>
				<th>상품정보</th><td><textarea name="productInfo" required></textarea></td>
			</tr>
			<tr>
				<th>상품이미지</th><td><input type="file" name="photoFileName" required></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="등록하기"></th>
			</tr>
		</table>
	</form>
</body>
</html>