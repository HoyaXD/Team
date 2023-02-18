<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/theaterList.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
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
               <div id="menu_title">영화관 조회</div>
               <table id="serch_tbl">
                  <tr>
                     <th>
                        <select name="serchType" id="serchType" size="1">
                           <option>-선택-</option>
                           <option value="theaterName">이름으로 검색</option>
                           <option value="theaterPlace">지역으로 검색</option>
                           <option value="theaterTel">연락처로 검색</option>
                        </select>
                        <span id="serchBox">
                           <input type="text" id="serchWord" placeholder="검색어를 입력해주세요.">
                        </span>
                        <button id="btn_serch" onclick="serchTheater();">검색</button>
                        <button onclick="location.href='theaterList'">초기화</button>
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
                        <!-- <th><input type="checkbox" id="allChk"></th> -->
                        <th id="tbl_code">영화관 코드</th>
                        <th id="tbl_place">지역</th>
                        <th id="tbl_name">상영관 이름</th>
                        <th>연락처</th>
                     </tr>
                  </thead>
                  <tbody id="tbody">
                     <c:forEach var="t" items="${tList }">
                        <tr>
                           <!-- <td><input type="checkbox" class="chk" value="${movie.movieCode }"></td> -->
                           <td>${t.theaterCode }</td>
                           <td>${t.theaterPlace }</td>
                           <td><a href="theaterUpdate?theaterCode=${t.theaterCode }">${t.theaterName }</a></td>
                           <td>${t.theaterTel }</td>
                        </tr>
                     </c:forEach>

                     <tfoot>
                        <tr>
                           <th>
                              <!-- <button id="btn_delMovies">선택삭제</button> -->
                           </th>
                           <th></th>
                           <th></th>
                           <th> <button id="movieReg" onclick="location.href='movieReg'">영화관등록</button></th>
                           
                        </tr>
                        <th colspan="7">
                           
                        </th>
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
   let serchWord = $("#serchWord").val();
	//serchType에 따른 검색창 변화
	 $("#serchType").change(function(e){
		if($("#serchType option:selected").val() == "theaterName"){
         $("#serchBox").html("<input type='text' id='serchWord' placeholder='영화관 이름을 입력해주세요.'>");
      }else if($("#serchType option:selected").val() == "theaterPlace"){
         $("#serchBox").html("<input type='text' id='serchWord' placeholder='지역명을 입력해주세요.'>");
      }else if($("#serchType option:selected").val() == "theaterTel"){
         $("#serchBox").html("<input type='text' id='serchWord' placeholder='연락처를 입력해주세요.'>");
      }
	});

   function serchTheater(){
	   
      let serchWord = $("#serchWord").val();
      
      if($("#serchType option:selected").val() == "theaterName"){
         const xhttp = new XMLHttpRequest();
         xhttp.onload = function() {
        	 
        	$("#tbody").empty();
        	
         	let result = this.responseText; 
			let obj = JSON.parse(result);
			if(obj.length != 0){
				for(let i = 0; i < obj.length; i++){
					$("#tbody").append(
							"<tr>"+
								"<td>" + obj[i].theaterCode + "</td>"+
								"<td>" + obj[i].theaterPlace + "</td>"+
								"<td>" +
									"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
										obj[i].theaterName +
									"</a>" +
								"</td>" +
								"<td>" + obj[i].theaterTel + "</td>"+
							"</tr>");
				}	
			}else{
				$("#tbody").html(
						"<tr>"+
							"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
						"</tr>");
			}
         }
               
         xhttp.open("GET", "theaterShcByName.do?name=" + serchWord, true); 
            
         xhttp.send();
         
      }else if($("#serchType option:selected").val() == "theaterPlace"){
    	  const xhttp = new XMLHttpRequest();
          xhttp.onload = function() {
        	  
        	  $("#tbody").empty();
        	  
	          let result = this.responseText; 
	          let obj = JSON.parse(result);
				if(obj.length != 0){
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append(
								"<tr>"+
									"<td>" + obj[i].theaterCode + "</td>"+
									"<td>" + obj[i].theaterPlace + "</td>"+
									"<td>" +
										"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
											obj[i].theaterName +
										"</a>" +
									"</td>" +
									"<td>" + obj[i].theaterTel + "</td>"+
								"</tr>");
					}	
			}else{
				$("#tbody").html(
						"<tr>"+
							"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
						"</tr>");
			}
          }
                
          xhttp.open("GET", "theaterShcByPlace.do?place=" + serchWord, true); 
             
          xhttp.send();
          
      }else if($("#serchType option:selected").val() == "theaterTel"){
    	  const xhttp = new XMLHttpRequest();
          xhttp.onload = function() {
        	  
        	  $("#tbody").empty();
        	  
	          let result = this.responseText; 
	          let obj = JSON.parse(result);
	         
				if(obj.length != 0){
					for(let i = 0; i < obj.length; i++){
						$("#tbody").append(
								"<tr>"+
									"<td>" + obj[i].theaterCode + "</td>"+
									"<td>" + obj[i].theaterPlace + "</td>"+
									"<td>" +
										"<a href='theaterUpdate?theaterCode="+obj[i].theaterCode+"'>" +
											obj[i].theaterName +
										"</a>" +
									"</td>" +
									"<td>" + obj[i].theaterTel + "</td>"+
								"</tr>");
					}	
				}else{
					$("#tbody").html(
							"<tr>"+
								"<th colspan='4' style='height:300px;'> 해당 영화관은 존재 하지 않습니다. </th>"+
							"</tr>");
				}
        	  }
                
          xhttp.open("GET", "theaterShcByTel.do?tel=" + serchWord, true); 
             
          xhttp.send();
      }
   }
</script>

<c:if test="${param.insert_result == 1}">
	<script>
		alert("등록완료!");
	</script>
</c:if>
<c:if test="${param.insert_result == 0}">
	<script>
		alert("등록실패....");
	</script>
</c:if>

<c:if test="${param.update_result == 1}">
	<script>
		alert("수정완료!");
	</script>
</c:if>
<c:if test="${param.update_result == 0}">
	<script>
		alert("수정실패....");
	</script>
</c:if>

<c:if test="${param.del_result == 1}">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0}">
	<script>
		alert("삭제실패....");
	</script>
</c:if>
</body>
</html>