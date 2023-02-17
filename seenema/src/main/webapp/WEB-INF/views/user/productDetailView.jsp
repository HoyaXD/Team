<%@page import="org.green.seenema.vo.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 상세 - 시네마</title>
<link rel="stylesheet" href="/css/productDetailView.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
</head>
<body>
	<input type="hidden" id="id" value="kim">
	<div class="container">
		<header>
			<button type="button" id="goMyCartBtn" style="float: right; height: 50px; cursor: pointer;">내 장바구니 가기</button>
		</header>
		<main>
			<section class="section sectionTop">
				<img src="${product.productImage }">
				<div class="productDetail">
					<table>
						<tbody id="tbody">
							<tr>
								<%-- <th class="pCode">${product.productCode }</th> --%>
								<td style="display:none;">
									<input type="hidden" id="hiddenProductCode" name="productCode" value="${product.productCode }">
									<input type="hidden" id="hiddenProductName" name="productName" value="${product.productName }">
									<input type="hidden" id="hiddenProductprice" name="price" value="${product.price }">
								</td>
								<td colspan="2" class="productName">${product.productName }</td>
							</tr>
							<tr>
								<th>가격</th>
								<td class="productPrice"><span id="productPrice">${product.price }</span><span>원</span></td>
							</tr>
							<tr>
								<th>구성품</th>
								<td class="fontGray productInfo">${product.productInfo }</td>
							</tr>
							<tr>
								<th>구매제한</th>
								<td class="fontGray">구매제한 없음</td>
							</tr>
							<tr>
								<th>유효기한</th>
								<td class="fontGray">24개월</td>
							</tr>
						</tbody>
					</table>
					<div class="productCountBox">
						<div class="minusBtn">-</div>
						<div class="count">1</div>
						<div class="plusBtn">+</div>
					</div>
					<div class="showTotalPriceWrap">
						<div class="chong">총 상품금액</div><div id="totalPrice">${product.price }</div><span id="won">원</span>
					</div>
					<div class="cartBuyBtnWrap">
						<div class="addCartBtn">장바구니에 담기</div>
						<div class="buyBtn">구매하기</div>
					</div>
				</div>
			</section>
			<section class="section sectionBottom">
				사용방법, 주의사항
			</section>
		</main>
		<footer>푸터</footer>
	</div>
<script>
	const price = parseInt($("#productPrice").text(), 10);	// 이 페이지 상품의 가격(정수타입으로 파싱)
	
	const IMP = window.IMP;
	IMP.init("imp58206540");
	
	// 바로구매
	$(document).on("click", ".buyBtn", function(){
		let orderNum = parseInt(new Date().getTime(), 10);	// 주문번호
		let productCode = $("#hiddenProductCode").val();	// 제품코드
		let productName = $("#hiddenProductName").val();	// 제품명
		let price = parseInt($("#hiddenProductprice").val(), 10);	// 제품 단가
		let count = parseInt($(".count").text(), 10);	// 제품수량
		let totalPrice = price * count;	// 결제 금액
		let	id = $("#id").val();	// 유저 아이디
		let userName = "김흥국";	//유저 이름
		//alert(totalPrice);
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
				  			alert("결제가 완료되었습니다.\n결제내역은 마이페이지의 결제내역을 확인해주세요.");
			  			}else{
			  				alert("결제 실패하였습니다.");
			  			}
			  		}
			  		xhttp.open("post", "/user/order/buy.do", true);
			  		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			  		xhttp.send("orderNum=" + orderNum + "&productCode=" + productCode + "&price=" + price + "&count=" + count + "&id=" + id);
				} else {
			  		// 결제 실패
			  		alert("결제를 취소하였습니다.");
					console.log(rsp);
				}
			});
	});
	
	// 문서 로드되면 쉼표찍어서 보여주기
	$(document).ready(function(){
		$("#productPrice").text(price.toLocaleString('ko-KR'));
		$("#totalPrice").text(price.toLocaleString('ko-KR'));
	});
	
	// 상품 수량 (-)
	$(".minusBtn").on("click", function(){
		let nowCount = parseInt($(".count").text(), 10);	// 현재 수량
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount != 1){
			returnCount--;
			$(".count").text(returnCount);
			//console.log($(".count").text());
		}
		let totalPrice = (price * returnCount).toLocaleString('ko-KR'); // 쉼표찍기
		$("#totalPrice").text(totalPrice);	// 계산된 값 넣음
	});
	
	
	// 상품 수량 (+)
	$(".plusBtn").on("click", function(){
		let nowCount = parseInt($(".count").text(), 10);
		let returnCount = nowCount;	// 반환할 수량
		if(nowCount < 5){
			returnCount++;
			$(".count").text(returnCount);
			//console.log($(".count").text());
		}
		let totalPrice = (price * returnCount).toLocaleString('ko-KR');	// 쉼표찍기
		$("#totalPrice").text(totalPrice);	// 계산된 값 넣음
	});
	
	// 장바구니 담기
	$(".addCartBtn").on("click", function(){
		if($("#id").val() == ""){
			alert("로그인 후 이용가능합니다.");
			return;
		}
		//const totalPriceStr = $("#totalPrice").text();
		//const priceStr = $("#productPrice").text();
		//console.log(totalPriceStr);
		//let price = priceStr.split(",").join("");	// 제품 판매가
		//let pInfo = $(".productInfo").text();		// 제품 구성
		
		let pCode = $("#hiddenProductCode").val();				// 제품 코드
		let pCount = $(".count").text();			// 제품 개수
		let id = $("#id").val();					// 회원 아이디
		//console.log(totalPrice);
		//console.log("제품 코드 : " + pCode + "\n제품명 : " + pName + "\n제품 판매가 : " + price + "\n제품 구성 : " + pInfo + "\n장바구니에 담을 제품 갯수 : " + pCount + "\n총 가격 : " + totalPrice);
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let result = parseInt(data, 10);
			if(result == 1){
				alert("장바구니에 등록되었습니다.");
			}else if(result == -1){
				alert("이미 장바구니에 존재하는 상품입니다.");
			}
		}
		xhttp.open("post", "/user/cart/addCart.do", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("productCode=" + pCode + "&productCount=" + pCount + "&id=" + id);
	});
	
	// 내 장바구니로 이동
	$("#goMyCartBtn").on("click", function(){
		if($("#id").val() == ""){
			alert("로그인 후 이용가능합니다.");
			return;
		}
		const id = $("#id").val();
		location.href = "/user/myCart?id=" + id;
	});
</script>
</body>
</html>