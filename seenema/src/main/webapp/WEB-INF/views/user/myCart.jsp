<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 - 시네마</title>
<link rel="stylesheet" href="/css/myCart.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
	<div class="container">
		<header>헤더
		<%-- <input type="hidden" id="id" value="${sessionScope.id }"> --%>
		<input type="hidden" id="id" value="kim">
		</header>
		<c:if test="${empty list}">
			
		</c:if>
		<c:if test="${!empty list}">
			<ul id="itemList">
				<li class="listHead">
					<div class="checkBox">
						<input type="checkbox" id="checkAll"><label for="checkAll">✓</label>
					</div>
					<div>상품명</div>
					<div>판매금액</div>
					<div>수량</div>
					<div>구매금액</div>
					<div>선택</div>
				</li>
				<c:forEach var="item" items="${list }" varStatus="status">
					<li class="item">
						<div class="checkBox">
							<input type="checkbox" id="chck${status.index }" class="check" value="${status.index }">
							<input type="hidden" class="inputProductCode" value="${item.productCode }">
							<input type="hidden" class="inputProductName" value="${item.productName }">
							<input type="hidden" class="inputProductInfo" value="${item.productInfo }">
							<input type="hidden" class="inputPrice" value="${item.price }">
							<input type="hidden" class="inputProductCount" value="${item.productCount }">
							<input type="hidden" class="inputTotalPrice" value="${item.productCount * item.price }">
							<label for="chck${status.index }">✓</label>
						</div>
						<div>
							<img id="productImage" src="${item.productImage }">
						</div>
						<div class="titleInfoWrap">
							<div id="productName">${item.productName }</div>
							<div id="productInfo">${item.productInfo }</div>
						</div>
						<div>
							<span class="price price${status.index }">
								<fmt:formatNumber value="${item.price }" pattern="#,###" />
							</span>
							<span class="won">원</span>
						</div>
						<div class="countWrap">
							<div class="wrap">
								<div class="count">${item.productCount }</div>
								<div class="upDownBtnWrap">
									<div class="plusBtn">▲</div>
									<div class="minusBtn">▼</div>
								</div>
							<div class="applyBtn">변경</div>
							</div>
						</div>
						<div class="oneProductTotalPriceWrap">
							<span class="prodTotalprice price${status.index }">
								<fmt:formatNumber value="${item.totalPrice }" pattern="#,###" />
							</span>
							<span class="won">원</span>
						</div>
						<div class="buyNowWrap">
							<button class="buyNowBtn" type="button">바로구매</button>
						</div>
						<div>
							<div class="deleteBtn">X</div>
						</div>
					</li>
				</c:forEach>
			</ul>
			<div class="bottomWrap">
				<div class="selectDeleteBtn">선택상품 삭제</div>
				<div class="priceInfoWrap">
					<div class="chong">총 결제금액&nbsp;</div>
					<div class="calcPriceWrap">
						<div id="totalPrice">0</div><div>원</div>
					</div>
				</div>
			</div>
			<div class="buyBtn">구매하기</div>
		</c:if>
		<footer>푸터</footer>
	</div>
<script>
	const IMP = window.IMP;
	IMP.init("imp58206540");
	
	// 일괄구매
	$(".buyBtn").on("click", function(){
		let checks = $(".check");
		//let totalPrice = 0;	// 총 금액
		let productCodes = new Array();	// 제품코드 배열
		let prices = new Array();	// 제품수량 배열
		let counts = new Array();	// 제품수량 배열
		let productList = "";
		let orderNum = "s" + new Date().getTime();	// 주문번호
		let	id = $("#id").val();	// 유저 아이디
		for(let i = 0; i < checks.length; i++){
			let productCode = parseInt(checks[i].parentElement.children[1].value, 10);
			let price = parseInt(checks[i].parentElement.children[4].value, 10);
			let count = parseInt(checks[i].parentElement.children[5].value, 10);
			if(i > 0){
				productList += "," + checks[i].parentElement.children[2].value;
			}else{
				productList += checks[i].parentElement.children[2].value;
			}
			totalPrice += price * count;
			
			productCodes.push(productCode);	// 제품코드 배열에 담기
			prices.push(price);			// 제품 가격 배열에 담기
			counts.push(count);			// 수량 배열에 담기
			console.log("제품 코드 : " + productCode + "\n금액 : " + price + "\n수량 : " + count);
		}
		IMP.request_pay({
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: orderNum,   // 주문번호
			name: productList,
			amount: 100,
			buyer_name: "김흥국",
		},  function (rsp) { // callback
				if (rsp.success) {
			  		// 결제 성공
					//console.log(rsp);
					const xhttp = new XMLHttpRequest();
			  		xhttp.onload = function(){
			  			let result = parseInt(this.responseText, 10);
			  			if(result == 1){
				  			//alert("결제가 완료되었습니다.");
				  			successRemoveList(productCodes, id);
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/store/buyProducts.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCodes=" + productCodes + "&prices=" + prices + "&counts=" + counts + "&id=" + id);
				} else {
			  		// 결제 실패
			  		alert("결제 실패");
					console.log(rsp);
				}
			});
	});
	
	// 상품 선택 구매 후 장바구니 목록 삭제
	function successRemoveList(productCodes, id){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			if(result == 1){
				alert("주문 성공!");
				location.href = "/user/myCart?id=" + id;  // 페이지 새로고침
			}else{
				alert("주문 실패...");
			}
		}
		xhttp.open("post", "/user/selectDelete.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("productCodes=" + productCodes + "&id=" + id);
	}
	
	
	
	
	// 개별 구매
	$(".buyNowBtn").on("click", function(){
		let orderNum = "s" + new Date().getTime();	// 주문번호
		let productCode = $(this).parent().parent().children().eq(0).children().eq(1).val();	// 제품코드
		let productName = $(this).parent().parent().children().eq(0).children().eq(2).val();	// 제품명
		let price = parseInt($(this).parent().parent().children().eq(0).children().eq(4).val(), 10);	// 제품 단가
		let count = parseInt($(this).parent().parent().children().eq(0).children().eq(5).val(), 10);	// 제품수량
		let totalPrice = parseInt($(this).parent().parent().children().eq(0).children().eq(6).val(), 10);	// 결제 금액
		let	id = $("#id").val();	// 유저 아이디
		let userName = "김흥국";	//유저 이름
		/* console.log(
			"주문 번호 : " + orderNum + "\n제품코드 : " + productCode + "\n제품명 : " + productName + "\n제품 단가 : " + price
			+ "\n수량 : " + count + "\n총 결제 금액 : " + totalPrice + "\n아이디 : " + id
		); */
		IMP.request_pay({
			pg: "html5_inicis",
			pay_method: "card",
			merchant_uid: orderNum,   // 주문번호
			name: productName,
			amount: 100,
			buyer_name: userName,
		},  function (rsp) { // callback
				if (rsp.success) {
			  		// 결제 성공
					//console.log(rsp);
			  		const xhttp = new XMLHttpRequest();
			  		xhttp.onload = function(){
			  			let result = parseInt(this.responseText, 10);
			  			if(result == 1){
				  			//alert("결제가 완료되었습니다.");
				  			success(productCode, id);
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/store/buy.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCode=" + productCode + "&price=" + price + "&count=" + count + "&id=" + id);
				} else {
			  		// 결제 실패
			  		alert("결제를 취소하였습니다.");
					console.log(rsp);
				}
			});
	});
	
	// 개별 주문 완료건 장바구니에서 삭제 실행
	function success(productCode, id){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let result = parseInt(this.responseText, 10);
			if(result == 1){
				alert("결제가 완료되었습니다.");
				location.href = "/user/myCart?id=" + id;  // 페이지 새로고침
			}
		}
		xhttp.open("post", "/user/deleteProduct.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  		xhttp.send("productCode=" + productCode + "&id=" + id);
	}
	
	// 처음에 전부 체크인 상태로 로드
	$(document).ready(function(){
		$("#checkAll").prop("checked", true);
		$(".check").prop("checked", true);
		let checks = $(".check");
		let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
		for(let i = 0; i < checks.length; i++){
			let price = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
			let count = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
			totalPrice += price * count;
		}
		$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
	});
	
	// 전체 체크(금액계산)
	$("#checkAll").on("click", function(){
		$("#totalPrice").text(0);
		let checks = $(".check");
		let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
		if($(this).is(":checked")){
    		checks.prop("checked", true);
    		for(let i = 0; i < checks.length; i++){
    			let price = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
    			let count = parseInt(checks[i].nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.value, 10);
    			totalPrice += price * count;
    		}
			//console.log("전체 체크(O) : " + totalPrice);
		}else{
			checks.prop("checked", false);
			totalPrice = 0;
			//console.log("전체 체크(X) : " + totalPrice);
		}
		$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
	});
	
	// 개별 체크(금액 계산)
	$(".check").on("click", function(){
		let totalPrice = parseInt($("#totalPrice").text().split(",").join(""), 10);
		if($(this).is(":checked")){
			if($(".check:checked").length == $(".check").length){
				$("#checkAll").prop("checked", true);
			}else{
				$("#checkAll").prop("checked", false);
			}
			//$(".checkAll").prop("checked", true);
			let price = parseInt($(this).next().next().next().next().val(), 10);
			let count = parseInt($(this).next().next().next().next().next().val(), 10);
			totalPrice += price * count;
			//console.log("개별 체크(O) : " + totalPrice);
		}else{
			$("#checkAll").prop("checked", false);
			let price = parseInt($(this).next().next().next().next().val(), 10);
			let count = parseInt($(this).next().next().next().next().next().val(), 10);
			totalPrice -= price * count;
			//console.log("개별 체크(X) : " + totalPrice);
		}
		//console.log(totalPrice);
		$("#totalPrice").text(totalPrice.toLocaleString('ko-KR'));
	});
	
	// 상품 삭제버튼
	$(".deleteBtn").on("click", function(e){
		if(confirm("선택하신 상품을 삭제하시겠습니까?") == true){
			let productCode = e.target.parentElement.parentElement.children[0].children[1].value;	// 제품코드
			let id = $("#id").val();	// 회원 아이디
			const params = {
					"productCode": productCode,
					"id": id
			};
			$.ajax({
				type: "post",
				url: "/user/deleteProduct.do",
				data: params,
				success: function(data){
					let result = parseInt(data, 10);
					if(result == 1){
						alert("성공");
						location.href = "/user/myCart?id=" + id;  // 페이지 새로고침
					}else{
						alert("실패");
					}
				},
				error: function(){
					alert("오류");
				}
			});
		}
	});
	
	// 상품 수량 (-)
	$(".minusBtn").on("click", function(){
		let nowCount = parseInt($(this).parent().prev().text(), 10);	// 현재 수량
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount != 1){
			returnCount--;
			$(this).parent().prev().text(returnCount);  // 반복이니까 자기자신 기준으로
			//console.log($(".count").text());
		}
	});
	
	// 상품 수량 (+)
	$(".plusBtn").on("click", function(){
		let nowCount = parseInt($(this).parent().prev().text(), 10);
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount < 5){
			returnCount++;
			$(this).parent().prev().text(returnCount);	// 반복이니까 자기자신 기준으로
		}
	});
	
	// 수량변경 실행
	$(".applyBtn").on("click", function(){
		let count = parseInt($(this).parent().children().eq(0).text(), 10);
		let id = $("#id").val();
		let productCode = $(this).parent().parent().parent().children().eq(0).children().eq(1).val();
		//console.log("아이디 : " + id + "\n코드 : " + productCode + "\n수량 : " + count);
		const cart = {
			"productCode": productCode,
			"id": id,
			"count": count
		};
		$.ajax({
			type: "post",
			url: "/user/updateProductCount.do",
			data: cart,
			success: function(data){
				let result = parseInt(data, 10);
				if(result == 1){
					alert("성공");
					location.href = "/user/myCart?id=" + id;  // 페이지 새로고침
				}else{
					alert("실패");
				}
			},
			error: function(){
				alert("오류");
			}
		});
	});
	
	// 선택삭제
	$(".selectDeleteBtn").on("click", function(){
		let checks = $(".check");
		let productCodes = new Array();
		let id = $("#id").val();
		
		for(let i = 0; i < checks.length; i++){
			if(checks[i].checked){
				//console.log(checks[i].nextElementSibling.value);
				productCodes.push(checks[i].nextElementSibling.value);
			}
		}
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			if(data == "1"){
				alert("성공");
				location.href = "/user/myCart?id=" + id;  // 페이지 새로고침
			}else{
				alert("실패");
			}
		}
		xhttp.open("post", "/user/selectDelete.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("productCodes=" + productCodes + "&id=" + id);
	});
</script>
</body>
</html>