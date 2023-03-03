<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/productReg.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
</head>
<body>
   <div class="gamut1">
    <%@ include file="adminMenu.jsp"%>
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">제품 등록</div>
            </div>
         </div>
         <div class="easy_menu1">
            <form action="productReg.do" id="productReg_Form" method="post" enctype="multipart/form-data">
                <div id="input_menu">
                    <div id="input_title">제품명</div>
                    <div id="textbox"><input type="text" name="productName"></div>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">카테고리</div>
                        <div id="textbox">
                            <select class="selectMenu" name="category" size="1">
                                <option value="">-선택-</option>
                                <option value="snack">스낵</option>
                                <option value="ticket">영화 관람권</option>
                                <option value="best">베스트</option>
                                <option value="ect">기타</option>
                            </select>
                        </div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">가격</div>
                        <div id="textbox"><input type="text" name="price"></div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">제품정보</div>
                    <div id="textbox"><textarea name="productInfo"></textarea></div>
                </div>
                <div id="input_menu_1">
                        <div id="input_title">제품 이미지 업로드</div>
                        <div id="textbox">
                            <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)"required style="cursor: pointer;">
                            <label id=upload_btn for="photoFileName">
                                파일선택
                            </label>
                        </div>
                </div>
                <div id="submitBox">
                    <div><input type="submit" value="등록하기"></div>
                </div>
            </form>
            <div id="regied_content">
                <div id="regied_photo">
                    -상품 이미지 미리보기-
                </div>
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
        }
      </script>

</body>
</html>