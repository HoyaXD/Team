<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/productUpdate.css">
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
               <div id="menu_title">상품 정보 수정</div>
            </div>
         </div>
         <div class="easy_menu">
            <form action="productUpdate.do" id="productUpdate_form" method="post" enctype="multipart/form-data">
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">제품 코드</div>
                        <div id="textbox"><input type="text" name="productCode" id="productCode" value="${p.productCode }" style="background-color: lightgray;" readonly></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">카테고리</div>
                        <div id="textbox">
                            <select class="selectMenu" name="category" size="1">
                                <option value="${p.category }">${p.category }</option>
                                <option value="">-선택-</option>
                                <option value="best">best</option>
                                <option value="snack">snack</option>
                                <option value="ticket">ticket</option>
								<option value="ect">ect</option>
                            </select>
                        </div>
                    </span>
                </div>
                <div id="input_menu_1">
                    <span id="menu_inMenu">
                        <div id="input_title">제품명</div>
                        <div id="textbox"><input type="text" name="productName" id="productName" value="${p.productName }"></div>
                    </span>
                    <span id="menu_inMenu">
                        <div id="input_title">가격</div>
                        <div id="textbox"><input type="text" name="price" value="${p.price }"></div>
                    </span>
                </div>
                <div id="input_menu">
                    <div id="input_title">상품정보</div>
                    <div id="textbox"><textarea name="productInfo">${p.productInfo}</textarea></div>
                </div>
                <div id="input_menu_1">
                        <div id="input_title">상품 이미지 업로드</div>
                        <div id="textbox">
                            <input type="file" name="photoFileName" id="photoFileName" style="display:none;" accept="image/*" onchange="setThumbnail(event)" style="cursor: pointer;">
                            <label id=upload_btn for="photoFileName">
                                파일선택
                            </label>
                            <input type="hidden" name="productImage" value="${p.productImage }">
                        </div>
                </div>
                <div id="submitBox">
                    <div><input type="button" id="delBtn" value="삭제하기"></div>
                    <div><input type="submit" id="submitBtn" value="수정하기"></div>
                </div>
            </form>
            <div id="regied_content">
                <div id="regied_photo">
                    <img src="/resources/imgs/${p.productImage}" id="photo">
                </div>
            </div>
            
         </div>
      </div>

	<script>
		$("#delBtn").on("click", function(){
		    if (!confirm("상품 정보를 삭제하시겠습니까?")) {
		 
		    }else{
		    	location.href="productDelete.do?productCode=" + $("#productCode").val();
		    }
		});
	</script>
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