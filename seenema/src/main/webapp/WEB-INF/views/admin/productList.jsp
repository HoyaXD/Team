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
<h1>상품조회</h1>
<hr>
<h3>상품검색</h3>

<table border="1">
	<tr>
		<th>
			<select name="serchType" id="serchType" size="1">
				<option>-선택-</option>
				<option value="productName">상품명으로 검색</option>
				<option value="price">가격으로 검색</option>
			</select>
			<input type="text" name="serchProduct" id="serchWord" placeholder="검색어를 입력해주세요.">
			<button onclick="serchProduct();">검색</button>
			<button onclick="location.href='productList'">초기화</button>
		</th>	
	</tr>
</table>
<hr>
<table border="1" id="product_tbl">
	<thead id="thead">
		<tr>
			<th><input type="checkbox" id="allChk"></th>
			<th>상품코드</th>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>가격</th>
			<th>판매량</th>	
		</tr>
	</thead>
	<tbody id="tbody">
	<c:forEach var="p" items="${plist }">
		<tr>
			<td><input type="checkbox" class="chk" value="${p.productCode }"></td>
			<td>${p.productCode }</td>
			<td><img src="/resources/imgs/${p.productImage }" width="100px"></td>
			<td><a href = "productUpdate?productCode=${p.productCode }">${p.productName }</a></td>
			<td>${p.price }</td>
			<td>${p.productSales }</td>
		</tr>
	</c:forEach>
	<tr>
		<td colspan="6">
			<button onclick="location.href='productReg'">상품등록</button>
			<button id="btn_delProducts">선택삭제</button>
		</td>
	</tr>
	</tbody>
	
</table>

	<script>
		//상품조회
		function serchProduct(){
			let serchType = $("#serchType").val();
			let serchWord = $("#serchWord").val();
			
			if(serchType == "productName"){
				//이름으로 상품조회
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					$("#thead").html("<tr>"+
											"<th><input type='checkbox' name='js_allChk' id='js_allChk'></th>"+
											"<th>상품코드</th>"+
											"<th>상품이미지</th>"+
											"<th>상품명</th>"+
											"<th>가격</th>"+
											"<th>판매량</th>"+
										"</tr>");
					for(let i = 0; i < obj.length; i++){
						
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
												"<td>"+obj[i].productCode+"</td>"+
												"<td><img src='/resources/imgs/"+obj[i].productImage+"' width='100px'></td>"+
												"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
												"<td>"+obj[i].price+"</td>"+
												"<td>"+obj[i].productSales+"</td>"+
											"</tr>"
											);
					}
						$("#tbody").append("<tr>"+
												"<td colspan='6'>"+
													"<button onclick='goProductRegPage();'>상품등록</button>"+
													"<button id='js_del'>선택삭제</button>"+
												"</td>"+
											"</tr>");
					
				}
				xhttp.open("GET", "getListByName.do?productName=" + serchWord, true); 
					
				xhttp.send();
			}else if(serchType == "price"){
				//가격으로 상품조회
				
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					$("#thead").html("<tr>"+
											"<th><input type='checkbox' name='js_allChk' id='js_allChk'></th>"+
											"<th>상품코드</th>"+
											"<th>상품이미지</th>"+
											"<th>상품명</th>"+
											"<th>가격</th>"+
											"<th>판매량</th>"+
										"</tr>");
					for(let i = 0; i < obj.length; i++){
						
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
												"<td>"+obj[i].productCode+"</td>"+
												"<td><img src='/resources/imgs/"+obj[i].productImage+"' width='100px'></td>"+
												"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
												"<td>"+obj[i].price+"</td>"+
												"<td>"+obj[i].productSales+"</td>"+
											"</tr>"
											);
					}
						$("#tbody").append("<tr>"+
												"<td colspan='6'>"+
													"<button onclick='goProductRegPage();'>상품등록</button>"+
													"<button id='js_del'>선택삭제</button>"+
												"</td>"+
											"</tr>");
					
				}
				xhttp.open("GET", "getListByPrice.do?price=" + serchWord, true); 
					
				xhttp.send();
			}
		}
		
		//상품등록페이지로 이동
		function goProductRegPage(){
			location.href="productReg";
		}
		
		//전체 선택
		$("#allChk").on("change", allChk);
		
		const all = document.querySelector("#allChk");
		const chks = document.querySelectorAll(".chk");
		
		function allChk(){
			for(let i = 0; i < chks.length; i++){
				chks[i].checked = all.checked;
			}
		};
		
		//선택삭제
		$("#btn_delProducts").on("click", products_delete);
		function products_delete(){
			
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
					location.href="productList";
				}else{
					alert("삭제실패..");
					location.href="productList";
				}
			}
			
			xhttp.open("GET", "products_delete.do?productCodes=" + chked, true); 
				
			xhttp.send();
			}
		
		//조회 전체 선택
		 $("#thead").on('click', $('#js_allChk'), function(){
			if($('input:checkbox[name="js_allChk"]').prop("checked") == true){
				 $('input:checkbox[name="js_chk"]').each(function() {
				     	this.checked = true;
				     	
				 });
			}else if($('input:checkbox[name="js_allChk"]').prop("checked") == false){
				 $('input:checkbox[name="js_chk"]').each(function() {
				     	this.checked = false;
				 });
			}
		});
		
		//조회 선택 삭제
		$("#tbody").on("click", $("#js_del"), serchDelete);
		function serchDelete(e){
			
			let checked_val = new Array();
			
			$('input:checkbox[name="js_chk"]').each(function() {
		     	if(this.checked){ //체크박스 체크되면
		     		checked_val.push(this.value); //체크박스 value를 배열에 담음
		     	};
			 });
			
			if(e.target.id == "js_del"){
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
				let result = this.responseText; 
					if(result == 1){
						alert("삭제완료!");
						location.href="productList";
					}else{
						alert("삭제실패..");
						location.href="productList";
					}
				}
				
				xhttp.open("GET", "products_delete.do?productCodes=" + checked_val, true); 
					
				xhttp.send();
			}
		}
</script>

<c:if test="${param.update_result == 1 }">
	<script>
		alert("수정완료!");
	</script>
</c:if>
<c:if test="${param.update_result == 0 }">
	<script>
		alert("수정실패...");
	</script>
</c:if>
<c:if test="${param.del_result == 1 }">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0 }">
	<script>
		alert("삭제실패...");
	</script>
</c:if>

</body>
</html>