<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/productList.css">
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <!-- 등록된 영화 리스트 조회/삭제 페이지 -->
   <div class="gamut">

    <div class="header">
       <div class="logo">Ssenema</div>
       <nav>
          <ul class="mainmenu">
             <li>영화 관리
                <ul class="submenu">
                   <li><a href="admin/movieReg">영화등록</a></li>
                   <li><a href="admin/movieList">영화 목록 및 괸리</a></li>
                </ul>
             </li>
             <li>영화관 관리
                <ul class="submenu">
                   <li><a href="admin/theaterReg">영화관 등록</a></li>
                   <li><a href="admin/theaterList">영화관 목록 및 관리</a></li>
                </ul>
             </li>
             <li>매출 관리
                <ul class="submenu">
                   <li>매출 현황1</li>
                   <li>매출 현황2</li>
                   <li>매출 현황3</li>
                   <li>매출 현황4</li>
                </ul>
             </li>
             <li>상품 관리
                <ul class="submenu">
                   <li>상품 등록</li>
                   <li>상품 수정</li>
                   <li>상품 3</li>
                   <li>상품 4</li>
                </ul>
             </li>
             <li><a href="admin/MemberMGMT">회원관리 관리</a></li>
             <li><a href="admin/qnaView">Q&A 관리</a></li>
             <li><a href="admin/adNoticeView">공지사항 관리</a></li>
             <li><a href="">한줄평 관리//만들어야됨</a></li>
          </ul>
       </nav>
    </div>
    <!--상단바-->
    <!--  <div class="top_bar">
          상단바
      </div> -->
    <div class="main_view">

       <div id="doToday_menu">
          <div id="main_header">
             <div id="menu_title">제품 조회</div>
             <table id="serch_tbl">
                <tr>
                   <th>
                      <select name="serchType" id="serchType" size="1">
                         <option>-선택-</option>
                         <option value="productName">상품명으로 검색</option>
                         <option value="price">가격 검색</option>
                         <option value="category">카테고리 검색</option>
                      </select>
                      <span id="serchBox">
                         <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
                      </span>
                      <button id="btn_serchProduct" onclick="serchProduct();">검색</button>
                      <button onclick="location.href='productList'">초기화</button>
                   </th>
                </tr>
             </table>
          </div>
       </div>

       <div class="easy_menu">
          <div id="listBox">
             <table id="list_tbl">
                <thead id="thead">
                    <tr>
                        <th></th><th></th><th></th><th></th><th></th><th></th>
                        <th>
                            <select id="sort" size="1">
                                <option value="null">-정렬-</option>
                                <option value="best">베스트</option>
                                <option value="snack">스낵</option>
                                <option value="ticket">영화관람권</option>
                                <option value="lowPrice">낮은 가격 순</option>
                                <option value="highPrice">높은 가격 순</option>
                                <option value="lowCnt">판매량 낮은 순</option>
                                <option value="highCnt">판매량 높은 순</option>
                            </select>
                        </th>
                    </tr>
                    <tr>
                      <th id="list_chkbox"><input type="checkbox" id="allChk"></th>
                      <th id="list_code">제품코드</th>
                      <th id="list_img">이미지</th>
                      <th id="list_name">제품이름</th>
                      <th id="list_category">카테고리</th>
                      <th id="list_price">가격</th>
                      <th id="list_cnt">판매량</th>
                    </tr>
                </thead>
                <tbody id="tbody">
                   <c:forEach var="p" items="${pList }">
                      <tr>
                        <td><input type="checkbox" class="chk" value="${p.productCode }"></td>
                        <td>${p.productCode}</td>
                        <td><img src="/resources/${p.productImage }" width="65px"></td>
                        <td><a href="productUpdate?productCode=${p.productCode}">${p.productName}</a></td>
                        <td>${p.category }</td>
                        <td>${p.price}</td>
                        <td style="color:blue">${p.productSales}</td>
                      </tr>
                   </c:forEach>
                   <tfoot id="tfoot">
                      <tr>
                         <th>
                            <button id="btn_delProducts">선택삭제</button>
                         </th>
                         <th></th>
                         <th></th>
                         <th></th>
                         <th></th>
                         <th></th>
                         <th> <button id="productReg" onclick="location.href='productReg'">제품등록</button></th>
                      </tr>
                      
                      <tr>
                         <th id="pageNum" colspan="7"></th>
                      </tr>
                      <tr>
                      </tr>
                   </tfoot>
             </table>
             <input type="text" id="cnt">
             <input type="text" id="currentPage" value="1">
           
          </div>
       </div>
    </div>
    
	<script>
		
		cntProduct();
		function cntProduct(){
			
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				
				let result = this.responseText; 
				$("#cnt").val(result); 
				//showPageButton();
				page();
			}
			
			xhttp.open("GET", "getCnt", true); 
				
			xhttp.send();
			
		}
		
		/* function page(){
			let currentPage = $("#currentPage").val(); //현재 페이지
			let totalCount = $("#cnt").val(); //총 데이터의 갯수
			let pageCount = 10; //화면에 나타날 페이지 갯수
			let limit = 10; //한 페이지 당 나타낼 데이터의 갯수
			let totalPage = Math.ceil(totalCount / limit); // 총페이지 개수
			let pageGroup = Math.ceil(currentPage / pageCount); //페이지그룹(1~10, 11~20 ...)
			
			let lastNum = pageGroup * pageCount;
			if(lastNum > totalPage){
				lastNum = totalPage
			};
			
			let firstNum = lastNum - (pageCount - 1);
			
			let next = lastNum + 1;
			let prev = firstNum - 1;
			
			if(totalCount < 101){ 
				for(let i = firstNum; i <= lastNum; i++){
					$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
				}
			}else if(totalCount > 100){
				for(let i = firstNum; i <= lastNum; i++){
					$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
				}
				$("#pageNum").append("<button id='next' style='width:30px;'>다음</button>");
			}else if(totalCount > 100 && lastNum >= 20){
				$("#pageNum").append("<button id='prev' style='width:30px;'>이전</button>")
				for(let i = firstNum; i <= lastNum; i++){
					$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
				}
				$("#pageNum").append("<button id='next' style='width:30px;'>다음</button>");
			}
			
			$("#tfoot").on("click", prevNext);
			function prevNext(e){
				
				if(e.target.id == "next"){ //다음페이지 누르면
					//$("#pageNum").children().first().trigger("click");
					let firstNum = document.querySelector("#next").previousElementSibling.innerText;
					$("#pageNum").empty();
					let _firstNum = parseInt(firstNum)+1;
					let lastNum = totalCount / 10 + 1;
					let pages = lastNum / 10;
					pageGroup = pageGroup+1;
					
					if(pageGroup == Math.ceil(pages)){ //마지막페이지
						$("#pageNum").append("<button id='prev' style='width:30px;'>이전</button>")
						for(let i = _firstNum; i <= totalPage; i++){
							$("#pageNum").append("<button id='page_num_btn' style='width:30px;'>"+i+"</button>");
						}
						
					}else{ //이외페이지
						$("#pageNum").append("<button id='prev' style='width:30px;'>이전</button>")
						for(let i = _firstNum; i <= _firstNum+9; i++){
							$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
						}
						$("#pageNum").append("<button id='next' style='width:30px;'>다음</button>")
					}
				}else if(e.target.id == "prev"){ //이전페이지 누르면
					let prevNum = parseInt($("#prev").next().text());
					let prevStart = prevNum - 10;
					$("#pageNum").empty();
					if(pageGroup > 1){
						pageGroup = pageGroup-1
					}else{
						pageGroup = 1; 
					}
					if(pageGroup == 1){
						for(let i = prevStart; i < prevNum; i++){
							$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
						}
						$("#pageNum").append("<button id='next' style='width:30px;'>다음</button>")
					}else if(pageGroup > 1){
						$("#pageNum").append("<button id='prev' style='width:30px;'>이전</button>")
						for(let i = prevStart; i < prevNum; i++){
							$("#pageNum").append("<button id='page_num_btn' value='"+i+"' style='width:30px;'>"+i+"</button>");
						}
						$("#pageNum").append("<button id='next' style='width:30px;'>다음</button>")
					}
					
				} 
			};
			
			$("#tfoot").on("click", goPage);
			function goPage(e){
				if(e.target.id == "page_num_btn"){
					
					location.href="productList?pageNum="+e.target.innerText;
				}else if(e.target.id == "next"){
					
					let last = e.target.previousElementSibling.innerText;
					let _last = parseInt(last)-1
					location.href="productList?pageNum=" + _last;
					 
				}else if(e.target.id == "prev"){
					let next = e.target.nextElementSibling.innerText;
					let _next = parseInt(next)-1
					location.href="productList?pageNum="+ _next;
				}
			}   
		} */
		 
/* 		function showPageButton(){
			let totalProduct = $("#cnt").val();
			let currentPage = $("#currentPage").val();
			let pageNum = Math.ceil(totalProduct / 10);
			let pageGroup = Math.ceil(parseInt(currentPage) / 10);
			
			let lastNumber = pageGroup * 10;
			if(lastNumber > pageNum){
				lastNumber = pageNum
			}
			let firstNumber = lastNumber - ( 10 - 1 );
			
			let nextPage = lastNumber + 1;
			let prev = firstNumber -1;
			
			if(pageNum > 10){ //페이지가 10 초과 이면 다음버튼 생성
				//$("#pageNum").append("<button id='prev'>이전</button>");
				for(let i = 1; i < 11; i ++){
					$("#pageNum").append("<button id='page_num_btn' style='width:30px'>" + i + "</button>");
				}
				$("#pageNum").append("<button id='next' style='width:30px'>다음</button>");
				
				$("#next").on("click", function(){
					$("#pageNum").empty();
					$("#pageNum").append("<button id='prev' style='width:30px'>이전</button>");
					for(let i = 11; i <= pageNum; i++){
						$("#pageNum").append("<button id='page_num_btn' style='width:30px'>" + i + "</button>");
					
					}
					$("#pageNum").append("<button id='next' style='width:30px'>다음</button>");
				})
				
			}else if(pageNum < 10){ //페이지가 10 이하이면 다음페이지 생성하지 않음
				for(let i = 1; i <= pageNum; i++){
					$("#pageNum").append("<button id='page_num_btn' style='width:30px'>" + i + "</button>");
				}
			}
		} */
		
		/*$("#tfoot").on('click', $("#page_num_btn"), function(e){
			if(e.target.id == "page_num_btn"){
				let page_num = e.target.innerText;
				$("#currentPage").val(page_num);
				
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					
					$("#tbody").empty();
					$("#tfoot").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					$("#thead").html("<tr>"+
	    					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
	                        "<th>"+
	                        	"<select id='sort' size='1'>"+
	                                "<option value='null'>-정렬-</option>"+
	                                "<option value='best'>베스트</option>"+
	                                "<option value='snack'>스낵</option>"+
	                                "<option value='ticket'>영화관람권</option>"+
	                      
	                                "<option value='lowPrice'>낮은 가격 순</option>"+
	                                "<option value='highPrice'>높은 가격 순</option>"+
	                                "<option value='lowCnt'>판매량 낮은 순</option>"+
	                                "<option value='highCnt'>판매량 높은 순</option>"+
	                            "</select>"+
	                        "</th>"+
	                    "</tr>"+
						"<tr>"+
							"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th id='list_code'>제품코드</th>"+
							"<th id='list_img'>이미지</th>"+
							"<th id='list_name'>제품이름</th>"+
							"<th id='list_category'>카테고리</th>"+
							"<th id='list_price'>가격</th>"+
							"<th id='list_cnt'>판매량</th>"+
						"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append(
								"<tr>"+
		                        	"<td><input type='checkbox' class='js_chk' name='js_chk' value='"+obj[i].productCode+"'></td>"+
		                        	"<td>"+obj[i].productCode+"</td>"+
		                        	"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
		                        	"<td><a href='productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</a></td>"+
		                        	"<td>"+obj[i].category+"</td>"+
		                        	"<td>"+obj[i].price+"</td>"+
		                        	"<td style='color:blue'>"+obj[i].productSales+"</td>"+
		                     	"</tr>");
					}
					$("#tfoot").append("<tr>"+
							"<th>"+
								"<button id='js_del'>선택삭제</button>"+
							"</th>"+
							"<th></th>"+
							"<th></th>"+
							"<th></th>"+
							"<th></th>"+
							"<th></th>"+
							"<th>"+
								"<button onclick='goProductRegPage();'>상품등록</button>"+
							"</th>"+
						"</tr>"+
						"<tr>"+
	                		"<th id='pageNum' colspan='7'></th>"+
	             		"</tr>");//tfoot
					cntProduct();
				}//onload
				
				xhttp.open("GET", "goPage?pageNum=" + page_num, true); 
					
				xhttp.send();
				
				
			}
			
			//if
		});*/
		
	
	</script>
	<script>
		
		//상품조회
		$("#serchType").on('change', function(e){
			if($("#serchType").val() == "price"){
				$("#serchBox").html(
						"<input type='text' id='start' placeholder='가격을 입력해주세요.'> ~ "+
						"<input type='text' id='end' placeholder='가격을 입력해주세요.'>");
			}else{
				$("#serchBox").html(
						 "<input type='text' id='serchWord' placeholder='검색어를 입력해주세요.'>");
			}
		});
		
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
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                        	"<select id='src_sort' size='1'>"+
					                                "<option value='null'>-정렬-</option>"+
					                                "<option value='best'>베스트</option>"+
					                                "<option value='snack'>스낵</option>"+
					                                "<option value='ticket'>영화관람권</option>"+
					                      
					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue;'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);//tbody
						}//for
							$("#tfoot").html("<tr>"+
													"<th>"+
														"<button id='js_del'>선택삭제</button>"+
													"</th>"+
													"<th></th>"+
													"<th></th>"+
													"<th></th>"+
													"<th></th>"+
													"<th></th>"+
													"<th>"+
														"<button onclick='goProductRegPage();'>상품등록</button>"+
													"</th>"+
												"</tr>");//tfoot
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot").html("<tr>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductReg()'>상품등록</button>"+
								"</th>"+
						"</tr>");
					};//if
				}//func
				xhttp.open("GET", "getListByName.do?productName=" + serchWord, true); 
					
				xhttp.send();
				
			}else if(serchType == "price"){
				//가격으로 상품조회
				//alert($("#start").val());
				if($("#start").val() > $("#end").val()){
					alert("시작 금액대가 더 큽니다. 가격대를 다시 확인해주세요 !");
					$("#start").focus();
					return true;
				}
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                        	"<select id='src_sort' size='1'>"+
		                                "<option value='null'>-정렬-</option>"+
		                                "<option value='best'>베스트</option>"+
		                                "<option value='snack'>스낵</option>"+
		                                "<option value='ticket'>영화관람권</option>"+
		                         
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						$("#tfoot").html("<tr>"+
								"<th>"+
									"<button id='js_del'>선택삭제</button>"+
								"</th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductRegPage();'>상품등록</button>"+
								"</th>"+
							"</tr>");
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot").html("<tr>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductReg()'>상품등록</button>"+
								"</th>"+
						"</tr>");
					};
					
				}
				xhttp.open("GET", "getListByPrice.do?start=" + $("#start").val() + "&end=" + $("#end").val(), true); 
					
				xhttp.send();
			}else if(serchType == "category"){
				//카테고리검색
				
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                        	"<select id='src_sort' size='1'>"+
		                                "<option value='null'>-정렬-</option>"+
		                                "<option value='best'>베스트</option>"+
		                                "<option value='snack'>스낵</option>"+
		                                "<option value='ticket'>영화관람권</option>"+
		                                
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						$("#tfoot").html("<tr>"+
								"<th>"+
									"<button id='js_del'>선택삭제</button>"+
								"</th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductRegPage();'>상품등록</button>"+
								"</th>"+
							"</tr>");
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot").html("<tr>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductReg()'>상품등록</button>"+
								"</th>"+
						"</tr>");
					};
					
				}
				xhttp.open("GET", "getListByCategory.do?category=" + serchWord, true); 
					
				xhttp.send();
			}//else if
		}//function
		
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
			if (!confirm("선택된 상품을 삭제하시겠습니까?")) {
	            
	        }else{
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
		}//function
		
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
		$("#tfoot").on("click", $("#js_del"), serchDelete);
		
		function serchDelete(e){
			if(e.target.id == "js_del"){
				if (!confirm("선택된 상품을 삭제하시겠습니까?")) {
	            
		        }else{
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
				        
					}//if
	        	}//confirm
			}//if button js_del
		}//function
		
		//상품등록페이지로 이동
		function goProductReg(){
			location.href="productReg";
		}
	</script>
	<script>
		//메인 sort
		$(document).on("change", $("#sort"), sort);
		function sort(e){
			if(e.target.id == "sort"){
			
					
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let sort_vlue = $("#sort").val();
					let _sort_vlue = "";
					
					if(sort_vlue == "best"){
						_sort_vlue = "베스트";
					}else if(sort_vlue == "snack"){
						_sort_vlue = "스낵"
					}else if(sort_vlue == "ticket"){
						_sort_vlue = "영화관람권"
					}else if(sort_vlue == "ect"){
						_sort_vlue = "기타"	
					}else if(sort_vlue == "lowPrice"){
						_sort_vlue = "낮은 가격 순"
					}else if(sort_vlue == "highPrice"){
						_sort_vlue = "높은 가격 순"
					}else if(sort_vlue == "lowCnt"){
						_sort_vlue = "낮은 판매량 순"
					}else if(sort_vlue == "highCnt"){
						_sort_vlue = "높은 판매량 순"
					};
					
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                            "<select id='sort' size='1'>"+
					                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
					                                "<option value='null'>-정렬-</option>"+
					                                "<option value='best'>베스트</option>"+
					                                "<option value='snack'>스낵</option>"+
					                                "<option value='ticket'>영화관람권</option>"+
					                             
					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th id='list_cnt'>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						$("#tfoot").html("<tr>"+
								"<th>"+
									"<button id='js_del'>선택삭제</button>"+
								"</th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductRegPage();'>상품등록</button>"+
								"</th>"+
							"</tr>");
					}else if(obj.length === 0){
						$("#thead").html(
								"<tr>"+
									"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
									"<th id='list_code'>제품코드</th>"+
									"<th id='list_img'>이미지</th>"+
									"<th id='list_name'>제품이름</th>"+
									"<th id='list_category'>카테고리</th>"+
									"<th id='list_price'>가격</th>"+
									"<th id='list_cnt'>판매량</th>"+
								"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot").html("<tr>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductReg()'>상품등록</button>"+
								"</th>"+
						"</tr>");
					};
					
				}
				if($("#sort").val() == "best"){
					//카테고리 - 베스트
					xhttp.open("GET", "getListByCategory.do?category=best", true); 
						
					xhttp.send();
				}else if($("#sort").val() == "snack"){
					//카테고리 - 스낵
					xhttp.open("GET", "getListByCategory.do?category=snack", true); 
						
					xhttp.send();
				}else if($("#sort").val() == "ticket"){
					//카테고리 - 관람권
					xhttp.open("GET", "getListByCategory.do?category=ticket", true); 
						
					xhttp.send();
				}else if($("#sort").val() == "ticket"){
					//카테고리 - 기타
					xhttp.open("GET", "getListByCategory.do?category=ect", true); 
						
					xhttp.send();
				}else if($("#sort").val() == "lowPrice"){
					//낮은 가격 순으로 정렬
					xhttp.open("GET", "getListByLowPrice", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "highPrice"){
					//높은 가격 순으로 정렬
					xhttp.open("GET", "getListByHighPrice", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "lowCnt"){
					//판매량 낮은 순으로 정렬
					xhttp.open("GET", "getListByLowSales", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "highCnt"){
					//판매량 높은 순으로 정렬
					xhttp.open("GET", "getListByHighSales", true); 
					
					xhttp.send();
				}else if($("#sort").val() == "null"){
					
				}
			}//e.target if
			
			
		}//sort function
	</script>
	<script>
		//검색 sort
		
		$(document).on('change', $("#src_sort"), src_sort);
		
		function src_sort(e){
			let serchWord = $("#serchWord").val();
			
			if(e.target.id == "src_sort"){
				let sort_vlue = $("#src_sort").val();
				const xhttp = new XMLHttpRequest();
				xhttp.onload = function() {
					let _sort_vlue = "";
					
					if(sort_vlue == "best"){
						_sort_vlue = "베스트";
					}else if(sort_vlue == "snack"){
						_sort_vlue = "스낵"
					}else if(sort_vlue == "ticket"){
						_sort_vlue = "영화관람권"
					}else if(sort_vlue == "ect"){
						_sort_vlue = "기타"
					}else if(sort_vlue == "lowPrice"){
						_sort_vlue = "낮은 가격 순"
					}else if(sort_vlue == "highPrice"){
						_sort_vlue = "높은 가격 순"
					}else if(sort_vlue == "lowCnt"){
						_sort_vlue = "낮은 판매량 순"
					}else if(sort_vlue == "highCnt"){
						_sort_vlue = "높은 판매량 순"
					};
					
					$("#tbody").empty();
					let result = this.responseText; 
					let obj = JSON.parse(result);
					
					$("#tbody").empty();
					if(obj.length != 0){
						
						$("#thead").html("<tr>"+
                        					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
					                        "<th>"+
					                            "<select id='src_sort' size='1'>"+
					                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
					                                "<option value='null'>-정렬-</option>"+
					                                "<option value='best'>베스트</option>"+
					                                "<option value='snack'>스낵</option>"+
					                                "<option value='ticket'>영화관람권</option>"+
					  
					                                "<option value='lowPrice'>낮은 가격 순</option>"+
					                                "<option value='highPrice'>높은 가격 순</option>"+
					                                "<option value='lowCnt'>판매량 낮은 순</option>"+
					                                "<option value='highCnt'>판매량 높은 순</option>"+
					                            "</select>"+
					                        "</th>"+
					                    "</tr>"+
										"<tr>"+
											"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
											"<th id='list_code'>제품코드</th>"+
											"<th id='list_img'>이미지</th>"+
											"<th id='list_name'>제품이름</th>"+
											"<th id='list_category'>카테고리</th>"+
											"<th id='list_price'>가격</th>"+
											"<th id='list_cnt'>판매량</th>"+
										"</tr>");
						
						for(let i = 0; i < obj.length; i++){
							
							$("#tbody").append("<tr>"+
													"<td><input type='checkbox' name='js_chk' class='js_chk' value="+obj[i].productCode+">"+
													"<td>"+obj[i].productCode+"</td>"+
													"<td><img src='/resources/"+obj[i].productImage+"' width='65px'></td>"+
													"<td><a href = 'productUpdate?productCode="+obj[i].productCode+"'>"+obj[i].productName+"</td>"+
													"<td>"+obj[i].category+"</td>"+
													"<td>"+obj[i].price+"</td>"+
													"<td style='color:blue'>"+obj[i].productSales+"</td>"+
												"</tr>"
												);
						}
						$("#tfoot").html("<tr>"+
								"<th>"+
									"<button id='js_del'>선택삭제</button>"+
								"</th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductRegPage();'>상품등록</button>"+
								"</th>"+
							"</tr>");
					}else if(obj.length === 0){
						$("#thead").html("<tr>"+
            					"<th></th><th></th><th></th><th></th><th></th><th></th>"+
		                        "<th>"+
		                            "<select id='src_sort' size='1'>"+
		                            	"<option value='"+sort_vlue+"'>"+_sort_vlue+"</option>"+
		                                "<option value='null'>-정렬-</option>"+
		                                "<option value='best'>베스트</option>"+
		                                "<option value='snack'>스낵</option>"+
		                                "<option value='ticket'>영화관람권</option>"+
		                       
		                                "<option value='lowPrice'>낮은 가격 순</option>"+
		                                "<option value='highPrice'>높은 가격 순</option>"+
		                                "<option value='lowCnt'>판매량 낮은 순</option>"+
		                                "<option value='highCnt'>판매량 높은 순</option>"+
		                            "</select>"+
		                        "</th>"+
		                    "</tr>"+
							"<tr>"+
								"<th id='list_chkbox'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
								"<th id='list_code'>제품코드</th>"+
								"<th id='list_img'>이미지</th>"+
								"<th id='list_name'>제품이름</th>"+
								"<th id='list_category'>카테고리</th>"+
								"<th id='list_price'>가격</th>"+
								"<th id='list_cnt'>판매량</th>"+
							"</tr>");
						
						$("#tbody").html("<tr>"+
								"<th colspan='7' style='height:300px;'> 해당 상품은 존재 하지 않습니다. </th>"+
						"</tr>");
						$("#tfoot").html("<tr>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th></th>"+
								"<th>"+
									"<button onclick='goProductReg()'>상품등록</button>"+
								"</th>"+
						"</tr>");
					};
					
				}
				if($("#src_sort").val() == "best"){
					//카테고리 - 베스트
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameCategory?productName="+ serchWord + "&category=best", true); 
							
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceCategory?start="+ $("#start").val() + "&end=" + $("#end").val() + "&category=best", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						
						xhttp.open("GET", "getListCategoryCategory?category1=" + serchWord + "&category2=" + e.target.value, true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "snack"){
					//카테고리 - 스낵
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameCategory?productName="+ serchWord + "&category=snack", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceCategory?start="+ $("#start").val() + "&end=" + $("#end").val() + "&category=snack", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryCategory?category1=" + serchWord + "&category2=" + e.target.value, true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "ticket"){
					//카테고리 - 관람권
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameCategory?productName="+ serchWord + "&category=ticket", true); 
							
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceCategory?start="+ $("#start").val() + "&end=" + $("#end").val() + "&category=ticket", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryCategory?category1=" + serchWord + "&category2=" + e.target.value, true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "ect"){
					//카테고리 - 기타
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameCategory?productName="+ serchWord + "&category=ect", true); 
							
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceCategory?start="+ $("#start").val() + "&end=" + $("#end").val() + "&category=ect", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryCategory?category1=" + serchWord + "&category2=" + e.target.value, true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "lowPrice"){
					//낮은 가격 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNamePrice?productName=" + serchWord + "&price=low", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPricePrice?start="+ $("#start").val() + "&end=" + $("#end").val() + "&price=low", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryPrice?category=" + serchWord + "&price=low", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "highPrice"){
					//높은 가격 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNamePrice?productName=" + serchWord + "&price=high", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPricePrice?start="+ $("#start").val() + "&end=" + $("#end").val() + "&price=high", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategoryPrice?category=" + serchWord + "&price=high", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "lowCnt"){
					//판매량 낮은 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameSales?productName=" + serchWord + "&sales=low", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceSales?start="+ $("#start").val() + "&end=" + $("#end").val() + "&sales=low", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategorySales?category=" + serchWord + "&sales=low", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "highCnt"){
					//판매량 높은 순으로 정렬
					if($("#serchType").val() == "productName"){
						
						xhttp.open("GET", "getListNameSales?productName=" + serchWord + "&sales=high", true); 
					
						xhttp.send();
					}else if($("#serchType").val() == "price"){
						xhttp.open("GET", "getListPriceSales?start="+ $("#start").val() + "&end=" + $("#end").val() + "&sales=high", true); 
						
						xhttp.send();
					}else if($("#serchType").val() == "category"){
						xhttp.open("GET", "getListCategorySales?category=" + serchWord + "&sales=high", true); 
						
						xhttp.send();
					}
				}else if($("#src_sort").val() == "null"){
					
				}
			}//e.target if
		}//src_sort function
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