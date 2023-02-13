<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 - 시네마</title>
<link rel="stylesheet" href="/css/myCart.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<header>헤더</header>
		<table>
			<thead>
				<tr>
					<td class="checkBox">
						<input type="checkbox" id="selectAll" class="checkAll">
						<label id="all" for="selectAll">✓</label>
					</td>
					<td class="productNameTh">상품명</td>
					<td class="productPriceTh">판매금액</td>
					<td>수량</td>
					<td>구매금액</td>
					<td>선택</td>
					<td></td>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach var="item" items="${list }" varStatus="status">
					<tr class="itemRow">
						<td>
							<input type="checkbox" id="chck${status.index }" class="check" value="${item.productCode}">
							<label class="check item${status.index }" for="chck${status.index }">✓</label>
						</td>
						<td class="imageInfoWrap">
							<img id="productImage" src="${item.productImage }">
							<div class="titleInfoWrap">
								<span id="productName">${item.productName }</span><br>
								<span id="productInfo">${item.productInfo }</span>
							</div>
						</td>
						<td class="priceTd">
							<span class="price price${status.index }">${item.price }</span><span>원</span>
						</td>
						<td>${item.productCount }</td>
						<td>${item.totalPrice }</td>
						<td><button id="buyBtn" type="button">바로구매</button></td>
						<td><div class="xBtn">X</div></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="calcPriceWrap">
			<div>총 결제금액</div>
			<div id="totalPrice">
				0
			</div>
		</div>
		<footer>푸터</footer>
	</div>
<script>
	
	//전체선택
	$("#selectAll").change(function(){
		const checks = $(".check");
		for(let i = 0; i < checks.length; i++){
			checks[i].checked = this.checked;
		}
	});
	
	// 총 결제금액 계산
	$("input[type='checkbox']").change(function(){
		//console.log(this.parentElement.parentElement.children[2].children[0].innerText));
		// 텍스트니까 정수로 파싱
		let productPrice = parseInt(this.parentElement.parentElement.children[2].children[0].innerText);
		$("#totalPrice");
	});
	
		
	
</script>
</body>
</html>