<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문목록 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/orderListView.css">
</head>
<body>
	<div class="container">
		<header>헤더
		<%-- <input type="hidden" id="id" value="${sessionScope.id }"> --%>
		<input type="hidden" id="id" value="kim">
		</header>
		<c:if test="${empty list}">
			<ul id="itemList">
				<li class="listHead">
					<div>상품명</div>
					<div>판매금액</div>
					<div>수량</div>
					<div>구매금액</div>
					<div>선택</div>
				</li>
				<li>
					<div id="emptyListWrap">
						장바구니 내역이 존재하지 않습니다.
					</div>
				</li>
			</ul>
		</c:if>
	</div>
</body>
</html>