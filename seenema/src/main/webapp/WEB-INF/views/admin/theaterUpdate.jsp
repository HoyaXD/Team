<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/theaterUpdate.css">
</head>
<body>
    <div class="gamut">
      <div class="header">
         <div class="logo">Ssenema</div>
         <nav>
            <ul class="mainmenu">
               <li>영화 관리
                  <ul class="submenu">
                     <li><a href="movieReg">영화등록</a></li>
                     <li><a href="movieList">영화 목록 및 괸리</a></li>
                  </ul>
               </li>
               <li>영화관 관리
                  <ul class="submenu">
                     <li><a href="theaterReg">영화관 등록</a></li>
                     <li><a href="theaterList">영화관 목록 및 관리</a></li>
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
               <div id="menu_title">영화관 정보 수정</div>
            </div>
         </div>
         <div class="easy_menu">
            <form action="theaterUpdate.do" id="theaterUpdate_Form" method="post" enctype="multipart/form-data">
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">영화관 코드</div>
                        <div id="textbox"><input type="text" name="theaterCode" id="theaterCode" value="${theater.theaterCode }" style="background-color: lightgray;" readonly></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">상영관 지역</div>
                        <div id="textbox">
                            <select class="selectMenu" name="theaterPlace" size="1">
                                <option value="${theater.theaterPlace }">${theater.theaterPlace }</option>
                                <option>-선택-</option>
                                <option value="서울특별시">서울특별시</option>
                                <option value="인천광역시">인천광역시</option>
                                <option value="대전광역시">대전광역시</option>
                                <option value="대구광역시">대구광역시</option>
                                <option value="부산광역시">부산광역시</option>
                                <option value="울산광역시">울산광역시</option>
                                <option value="광주광역시">광주광역시</option>
                            </select>
                        </div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">상영관 이름</div>
                    <div id="textbox"><input type="text" name="theaterName" value="${theater.theaterName }" id="theaterName"></div>
                </div>
                <div id="input_menu">
                    <div id="input_title">주소</div>
                    <div id="textbox"><input type="text" name="theaterAddress" value="${theater.theaterAddress }" id="theaterAddress"></div>
                </div>
                
                <div id="input_menu">
                    <div id="input_title"></div>
                    <div id="textbox"><input type="button" id="map_preview" value="지도 미리 보기"></div>
                </div>
                <div id="input_menu">
                    <div id="input_title">연락처</div>
                    <div id="textbox"><input type="text" name="theaterTel" value="${theater.theaterTel }" id="theaterTel"></div>
                </div>
               <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">좌석 행</div>
                        <div id="textbox"><input type="text" name="seat_column" value="${theater.seat_column }"></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">좌석 열</div>
                        <div id="textbox"><input type="text" name="seat_row" value="${theater.seat_row }"></div>
                    </span>
                </div>
                <!-- <div id="input_menu">
                    <div id="input_title"></div>
                    <div id="textbox"><input type="button" id="addressChange_btn" onclick="addressChange();" value="위도, 경도 찾기"></div>
                </div> -->
                <div id="input_menu">
                    <div id="input_title">영화관 사진 업로드</div>
                    <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)" style="cursor: pointer;">
                    <label id=upload_btn for="photoFileName">
                        파일선택
                    </label>
                    <input type="hidden" name="theaterImage" value="${theater.theaterImage }">
                </div>
                <div id="submitBox">
                    <div><input type="button" id="delBtn" value="삭제하기"></div>
                    <div><input type="submit" id="submitBtn" value="수정하기"></div>
                </div>
            </form>

            <div id="regied_content">
                <div id="regied_photo">
                    <img src="/resources/images/${theater.theaterImage}" id="photo">
                </div>
                <div id="regied_map_preview">
                   	
                </div>
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
	     function setThumbnail(event) {
	         let reader = new FileReader();
	 
	         reader.onload = function(event) {
	             let img = document.createElement("img");
	             img.setAttribute("src", event.target.result);
	             img.setAttribute("width", "370");
	             img.setAttribute("height", "450");
	             $("#regied_photo").html(img);
	         };
	         reader.readAsDataURL(event.target.files[0]);
	            
	         
	     };
	
	        
	    function addressChange(){
	       window.open("https://address.dawul.co.kr/", "_blank", "width=1500, height=600");
	    };
	
		$("#delBtn").on("click", function(){
	        if (!confirm("영화관 정보를 삭제하시겠습니까?")) {
	     
	        }else{
				location.href="theaterDelete.do?theaterCode=" + $("#theaterCode").val();
	        }
		});
	</script>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e2cb63af5ce21e3e335968b15d8713a&libraries=services"></script>
	<script>
		map_preview();
		
		function map_preview(){
			/* let list_latitude = $("#latitude").val();
			let list_longitude = $("#longitude").val(); */
			let theaterName = $("#theaterName").val();
			let theaterTel = $("#theaterTel").val();
			let theaterAddress = $("#theaterAddress").val();
			
			var mapContainer = document.getElementById('regied_map_preview'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			 
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(theaterAddress, function(result, status) {
		    
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        /* $("#latitude").val(result[0].y);
		        let latitude = $("#latitude").val(); */
		        let latitude = result[0].y;
		        /* $("#longitude").val(result[0].x);
				let longitude = $("#longitude").val(); */
				let longitude = result[0].x;
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
				
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		        	
		            content: '<div style="width:150px">'+
		            			'<div style="color:black; text-align:center;">'+
		            				theaterName+
		            			'</div>'+
		            			'<span><a href="https://map.kakao.com/link/map/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <큰지도보기></a></span>'+
		            		'<span><a href="https://map.kakao.com/link/to/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <길찾기></a></span></div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
			    } 
			});    
		};
		
		$("#map_preview").on("click", map_preview);
	</script>
	


</body>
</html>