<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/movieReg.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<!-- 영화등록페이지 -->
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
               <div id="menu_title">영화등록</div>
            </div>
         </div>
         <div class="easy_menu">
            <form action="movieUplode.do" id="movieReg_Form" method="post" enctype="multipart/form-data">
                <div id="input_menu">
                    <div id="input_title">영화 제목</div>
                    <div id="textbox"><input type="text" name="movieTitle"></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">장르</div>
                        <div id="textbox"><input type="text" name="genre"></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">러닝타임</div>
                        <div id="textbox"><input type="text" name="runningTime"></div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">감독</div>
                    <div id="textbox"><input type="text" name="director"></div>
                </div>
                <div id="input_menu">
                    <div id="input_title">배우</div>
                    <div id="textbox"><input type="text" name="actors"></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">관람연령</div>
                        <div id="textbox">
                            <select class="selectMenu" name="viewAge" size="1">
                                <option>-선택-</option>
                                <option value="0">전체관람가</option>
                                <option value="12">12세 이상 관람가</option>
                                <option value="15">15세 이상 관람가</option>
                                <option value="19">청소년 관람불가</option>
                            </select>
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">개봉일</div>
                        <div id="textbox"><input type="date" name="releaseDate"></div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영날짜</div>
                        <div id="textbox"><input type="date" name="start_date">&nbsp;&nbsp;~</div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="textbox"><input type="date" name="end_date"></div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영관</div>
                        <div id="textbox">
                            <select class="selectMenu" id="theater" size="1">
	                                <option value="none">-선택-</option>
                                <c:forEach var="t" items="${theater }">
	                                <option value="${t.theaterName }">${t.theaterName }</option>
                                </c:forEach>
                            </select>
                        </div>
                    </span>
                    <span id="selected_theater">
                        <div id="input_title" class="selected_theater"></div>
                        <div id="textbox" class="selected_result" name="selected_result">
                           
                        </div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">상영시간</div>
                        <div id="textbox">
                            <input type="time" id="sel_playingTime">
                        </div>
                    </span>
                    <span id="selected_time">
                        <div id="input_title" class="selected_time"></div>
                        <div id="textbox" class="selected_time_result" name="selected_time_result">
                           
                        </div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">줄거리</div>
                    <div id="textbox"><textarea name="plot"></textarea></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">포스터 업로드</div>
                        <div id="textbox">
                            <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)"required style="cursor: pointer;">
                            <label id=upload_btn for="photoFileName">
                                파일선택
                            </label>
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">예고편 URL</div>
                        <div id="textbox"><input type="text" id="previewURL" name="previewURL"></div>
                    </span>
                </div>
                <div id="submitBox">
                    <div><input type="submit" value="등록하기"></div>
                </div>
            </form>
            <div id="regied_content">
                <div id="regied_photo">
                    -포스터 미리보기-
                </div>
                <div id="regied_preview">
                    -예고편 미리보기-
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

        $("#previewURL").on("keyup", function(){
            //alert($("#previewURL").val());
            if($("#previewURL").val() == ""){
                $("#regied_preview").text("-예고편 미리보기-");
            }else{
                let url = $("#previewURL").val().replace('https://youtu.be/', 'https://www.youtube.com/embed/');
               $("#regied_preview").html('<iframe width="370" height="300" src="'+url+'?autoplay=1&controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>');
                
            }
        });

        $("#theater").on("change", function(){
            //selected_theater, selected_result
            $(".selected_theater").text("선택된 영화관");
            if($(".selected_result").text().includes($("#theater").val() + " X") == false && $("#theater").val() != "none"){
                $(".selected_result").append("<button value='" + $("#theater").val() + "' id='theater_del'>" 
                                                + $("#theater").val() + 
                                            " X</button>"+
                                            "<input type='hidden' name='theater' value='"+$("#theater").val()+"'> "
                                            );
            }else if($("#theater").val() == "none"){
                
            }else{
                alert("이미 추가된 상영관 입니다.");
            }
        });
        
        $(".selected_result").on("click", $("#theater_del"), function(e){
        	e.target.remove(); 
        });

        $("#sel_playingTime").on("change", function(){
            $(".selected_time").text("선택된 상영시간");
            if($(".selected_time_result").text().includes($("#sel_playingTime").val() + " X") == false){
                $(".selected_time_result").append("<button value='" + $("#sel_playingTime").val() + "' id='playingTime_del'>" 
                                                + $("#sel_playingTime").val() + 
                                            " X</button>"+
                                            "<input type='hidden' name='playingTime' value='"+$("#sel_playingTime").val()+"'> "
                                            );
            }else{
                alert("이미 추가된 상영시간 입니다.");
            }
        });

        $(".selected_time_result").on("click", $("#playingTime_del"), function(e){
        	e.target.remove(); 
        });
      </script>
</body>
</html>