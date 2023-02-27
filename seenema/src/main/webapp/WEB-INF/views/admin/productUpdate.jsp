<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/productUpdate.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu.css">
</head>
<body>
   <div class="gamut1">
     <!-- 좌측메뉴 jsp -->
	<%@ include file="adminMenu.jsp"%>
     
      <div class="main_view1">

         <div id="doToday_menu">
            <div id="main_header">
               <div id="menu_title">상품 정보 수정</div>
            </div>
         </div>
         <div class="easy_menu1">
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
                    <img src="/resources/${p.productImage}" id="photo">
                </div>
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