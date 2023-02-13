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
<h1>상품정보 수정 페이지</h1>
<hr>
<form action="productUpdate.do" method="post" enctype="multipart/form-data">
<table border="1">
	<tr>
		<th colspan="2"><img src="/resources/imgs/${p.productImage }" width="200px"></th>
	</tr>
	<tr>
		<th>상품코드</th>
		<td><input type="text" value="${p.productCode }" name="productCode" id="productCode" readonly>
	</tr>
	<tr>
		<th>상품명</th>
		<td><input type="text" value="${p.productName }" name="productName"></td>
	</tr>
	<tr>
		<th>가격</th>
		<td><input type="text" value="${p.price }" name="price"></td>
	</tr>
	<tr>
		<th>상품정보</th>
		<td><textarea name="productInfo">${p.productInfo }</textarea></td>
	</tr>
	<tr>
		<th>판매량</th>
		<td><input type="text" value="${p.productSales }" name="productSales" readonly></td>
	</tr>
	<tr>
		<th rowspan="2">이미지</th>
		<td>현재파일:<input type="text" name="productImage" value="${p.productImage }"></td>
	</tr>
	<tr>
		<td><input type="file" name="photoFileName"></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="button" value="삭제하기" id="delBtn">
			<input type="submit" value="수정하기">
		</th>
	</tr>
</table>

<script>
	$("#delBtn").on("click", function(){
		location.href="productDelete.do?productCode=" + $("#productCode").val();
	});
</script>
</form>
</body>
</html>