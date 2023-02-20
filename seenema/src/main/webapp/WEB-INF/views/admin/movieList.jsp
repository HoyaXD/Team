<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/css/movieList.css">

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
               <div id="menu_title">영화조회</div>
               <table id="serch_tbl">
                  <tr>
                     <th>
                        <select name="serchType" id="serchType" size="1">
                           <option>-선택-</option>
                           <option value="MovieTitle">영화제목으로 검색</option>
                           <option value="MovieDate">개봉일로 검색</option>
                           <option value="MovieTitleDate">제목+개봉일로 검색</option>
                        </select>
                        <span id="serchBox">
                           <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
                        </span>
                        <button id="btn_serchMovie" onclick="serchMovie();">검색</button>
                        <button onclick="location.href='movieList'">초기화</button>
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
                        <th><input type="checkbox" id="allChk"></th>
                        <th>영화코드</th>
                        <th>포스터</th>
                        <th>제목</th>
                        <th>개봉일</th>
                        <th>상영시작일</th>
                        <th>상영마감일</th>
                     </tr>
                  </thead>
                  <tbody id="tbody">
                     <c:forEach var="movie" items="${mList }">
                        <tr>
                           <td><input type="checkbox" class="chk" value="${movie.movieCode }"></td>
                           <td>${movie.movieCode }</td>
                           <td><a href="movieUpdate?movieCode=${movie.movieCode }"><img src="/resources/imgs/${movie.postFileName }" width="50px"></a>
                           <td><a href="movieUpdate?movieCode=${movie.movieCode }">${movie.movieTitle }</a></td>
                           <td>${movie.releaseDate }</td>
                           <td style='color:blue;'>${movie.start_date }</td>
                           <td style='color:red;'>${movie.end_date }</td>
                        </tr>
                     </c:forEach>

                     <tfoot id="tfoot">
                        <tr>
                           <th>
                              <button id="btn_delMovies">선택삭제</button>
                           </th>
                           <th></th>
                           <th></th>
                           <th></th>
                           <th></th>
                           <th></th>
                           <th> <button id="movieReg" onclick="location.href='movieReg'">영화등록</button></th>
                           
                        </tr>
                        
                        <tr>
                           <th colspan="7">1 2 3 4 5 6 7 8 9</th>
                        </tr>
                        <tr>
                        </tr>
                     </tfoot>
               </table>
            </div>
         </div>
      </div>

      <script>
         $(document).ready(function() {

            /* 메뉴바 slideUpDown */
            // 첫번째 메뉴바 클릭시 이동   
            $('.mainmenu > li').click(function() {
               var index = $(this).index();
               $('.submenu').eq(index).stop().slideDown();
               //eq(index)는 큰메뉴li
            })

            $('.mainmenu > li').mouseleave(function() {
               $('.submenu').stop().slideUp();
            });

         });
     </script>
  
	<script>
		//전체선택
		$("#allChk").on("change", allChk);
		
		const all = document.querySelector("#allChk");
		const chks = document.querySelectorAll(".chk");
		
		function allChk(){
			for(let i = 0; i < chks.length; i++){
				chks[i].checked = all.checked;
			}
		};
		
		//선택삭제
		$("#btn_delMovies").on("click", movies_delete);
		
		function movies_delete(){
			 if (!confirm("선택된 영화 정보를 삭제하시겠습니까?")) {
			     
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
						location.href="movieList";
					}else{
						alert("삭제실패..");
						location.href="movieList";
					}
				}
				
				xhttp.open("GET", "movies_delete.do?movieCodes="+chked, true); 
					
				xhttp.send();
				}
			}
	</script>
	<script>
	//serchType에 따른 검색창 변화
	 $("#serchType").change(function(e){
		 if($("#serchType option:selected").val() == "MovieTitle"){
			 $("#serchBox").html("<span>"+
					 				"<input type='text' id='serchWord' placeholder='검색어를 입력해주세요.'>"+
					 			"</span>");
			 
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			
			 $("#serchBox").html("<span id='in_serch_box'>"+
					 				"<input type='date' id='start' name='start'> ~ "+
					 				"<input type='date' id='end' name='end'>"+
					 			"</span>"); 
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			 $("#serchBox").html("<span id='in_serch_box'>"+
					 					"<input type='text' id='serchWord' name='serchWord' placeholder='검색어를 입력해주세요.'>"+
		 								"&nbsp;<input type='date' id='start' name='start'> ~ "+
		 								"<input type='date' id='end' name='end'>"+
		 						"</span>"); 
		 }
	});
	
	function serchMovie(){
		let serchWord = $("#serchWord").val();
		let startDate = $("#start").val();
		let endDate = $("#end").val();
		
		if($("#serchType option:selected").val() == "MovieTitle"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
					$("#tfoot").html("<tr>"+
											"<th>"+
												"<button id='js_del'>선택삭제</button>"+
											"<th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
										"</tr>");	
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					$("#tfoot").html("<tr>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
									"</tr>");	
				}
			}	//onload
			xhttp.open("GET", "serchMvByTitle.do?movieTitle=" + serchWord, true); 
			
			xhttp.send();
			
		 }else if($("#serchType option:selected").val() == "MovieDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
					$("#tfoot").html("<tr>"+
											"<th>"+
												"<button id='js_del'>선택삭제</button>"+
											"<th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
										"</tr>");	
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					$("#tfoot").html("<tr>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
									"</tr>");	
				}
			}	//onload
			xhttp.open("GET", "serchMvByDate.do?startDate=" + startDate+ "&endDate=" + endDate, true); 
			
			xhttp.send();
				
		 }else if($("#serchType option:selected").val() == "MovieTitleDate"){
			const xhttp = new XMLHttpRequest();
			xhttp.onload = function() {
				$("#tbody").empty();
				let result = this.responseText; 
				let obj = JSON.parse(result);
				if(obj.length != 0){
					$("#thead").html("<tr>"+
										"<th><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
										"<th>영화코드</th>"+
										"<th>포스터</th>"+
										"<th>제목</th>"+
										"<th>개봉일</th>"+
										"<th>상영시작일</th>"+
										"<th>상영마감일</th>"+
									"</tr>");
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append("<tr>"+
												"<td><input type='checkbox' id='js_chk' name='js_chk' value='"+obj[i].movieCode+"'></td>"+
												"<td>"+obj[i].movieCode+"</td>"+
												"<td><img src='/resources/imgs/"+obj[i].postFileName+"' width='50px'></td>"+
												"<td><a href='movieUpdate?movieCode="+obj[i].movieCode+"'>"+obj[i].movieTitle+"</a></td>"+
												"<td>"+obj[i].releaseDate+"</td>"+
	                                 			"<td style='color:blue'>"+obj[i].start_date+"</td>"+
	                                			"<td style='color:red'>"+obj[i].end_date+"</td>"+
											"</tr>");
					}
					$("#tfoot").html("<tr>"+
											"<th>"+
												"<button id='js_del'>선택삭제</button>"+
											"<th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
										"</tr>");	
				}else if(obj.length === 0){
					$("#thead").html("<tr>"+
							"<th style='width:120px'><input type='checkbox' id='js_allChk' name='js_allChk'></th>"+
							"<th style='width:83px'>영화코드</th>"+
							"<th style='width:75px'>포스터</th>"+
							"<th style='width:221px'>제목</th>"+
							"<th style='width:127px'>개봉일</th>"+
							"<th style='width:122px'>상영시작일</th>"+
							"<th style='width:122px'>상영마감일</th>"+
						"</tr>");
					$("#tbody").html("<tr>"+
											"<th colspan='7' style='height:300px;'> 해당 영화는 존재 하지 않습니다. </th>"+
									"</tr>");
					$("#tfoot").html("<tr>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th></th>"+
											"<th>"+
												"<button onclick='goMovieReg();'>영화등록</button>"+
											"</th>"+
									"</tr>");	
				}
			}	//onload
			xhttp.open("GET", "serchMvByTitleDate.do?startDate=" + startDate+ "&endDate=" + endDate + "&movieTitle=" + serchWord, true); 
		
			xhttp.send();
		 }//else
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
	        if (!confirm("선택된 영화 정보를 삭제하시겠습니까?")) {
	            
	        } else {
	            
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
							location.href="movieList";
						}else{
							alert("삭제실패..");
							location.href="movieList";
						}
					}
					
					xhttp.open("GET", "delMoviesByCodes.do?movieCodes=" + checked_val, true); 
						
					xhttp.send();
				}
	        }
		}
	}
	//영화등록페이지로 이동
	function goMovieReg(){
		location.href="movieReg";
	}
</script>

<c:if test="${param.insert_result == 1 }">
	<script>
		alert("등록완료!");
	</script>
</c:if>
<c:if test="${param.insert_result == 0 }">
	<script>
		alert("등록실패..");
	</script>
</c:if>
<c:if test="${param.del_result == 1 }">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0 }">
	<script>
		alert("삭제실패..");
	</script>
</c:if>
<c:if test="${param.update_result == 1 }">
	<script>
		alert("수정성공!");
	</script>
</c:if>
<c:if test="${param.update_result == 0 }">
	<script>
		alert("수정실패..");
	</script>
</c:if>
</body>