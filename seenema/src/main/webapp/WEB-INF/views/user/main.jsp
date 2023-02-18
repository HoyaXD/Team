<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/main.css">
</head>
<body>
	<%@include file="header.jsp" %>
	<!-- <header>헤더</header> -->
    <div class="content">
        <div class="videoWrap">
            <video autoplay muted loop>
                <source src="https://adimg.cgv.co.kr/images/202301/antman/0215_antman_pc_1080x608.mp4" type="video/mp4">
                <!-- <source src="https://adimg.cgv.co.kr/images/202302/MySweetMonster/pc_1080x608.mp4" type="video/mp4"> -->
            </video>
        </div>
    </div>
        <main>
            <div class="titleWrap">
                <div class="sectionTitle on" id="movieChartTitle">무비차트</div>
                <div class="sectionTitle" id="upcomingTitle">상영예정작</div>
            </div>
            <div class="section">
                <input type="radio" name="slide" id="slide01" checked>
                <input type="radio" name="slide" id="slide02">
                <input type="radio" name="slide" id="slide03">
                <input type="radio" name="slide" id="slide04">
                <div class="slidewrap">
                    <ul class="slidelist">
                       <!--  -->
                    </ul>
                </div>
            </div>
            <div class="storeSection">
                스토어
            </div>
            <div class="noticeSection">
            	공지사항
            </div>
        </main>
    <footer>푸터</footer>
<script>
	$(document).ready(getMainMovieList());
	
	function getMainMovieList(){
		const xhttp = new XMLHttpRequest();
		xhttp.onload = function(){
			let data = this.responseText;
			let list = JSON.parse(data);
			//console.log(list.length);
			//console.log(list.toString());
			//console.log(list[0].postFileName);
			let page = list.length / 5;
			//$(".slidelist")
			//console.log(page);
			let index = 0;
			for(let i = 0; i < page; i++){
				if(i == 0){
					$(".slidelist").append(	// 첫페이지 일때
						"<li>"
	                       	+ "<div class='items'>"
	                           	+ "<div class='item item" + i + "'></div>"
						        + "<label for='slide0" + (i + 2) + "' class='right'></label>"
					        + "</div>"
						+ "</li>"
					);
				}else if(i == page - 1){	// 마지막 페이지일때
					$(".slidelist").append(
							"<li>"
		                       	+ "<div class='items'>"
	                       			+ "<label for='slide0" + i + "' class='left'></label>"
	                           		+ "<div class='item item" + i + "'>"
	                   			 	+ "</div>"
								+ "</div>"
							+ "</li>"
						);
				}else{	// 그외 나머지
					$(".slidelist").append(
						"<li>"
	                       	+ "<div class='items'>"
	                       			+ "<label for='slide0" + i + "' class='left'></label>"
	                           		+ "<div class='item item" + i + "'></div>"
									+ "<label for='slide0" + (i + 2) + "' class='right'></label>"
							+ "</div>"
						+ "</li>"
					);
				}
				for(let j = 0; j < 5; j++){
					//console.log(i);
					//console.log(index);
					//console.log(list[index].postFileName);
					let ageTag;
					if(list[index].viewAge == 12){
						ageTag = "<div class='age' style='background-color: #e0c600;'>" + list[index].viewAge + "</div>";
					}else if(list[index].viewAge == 15){
						ageTag = "<div class='age' style='background-color: #d17300;'>" + list[index].viewAge + "</div>";
					}else if(list[index].viewAge == 19){
						ageTag = "<div class='age' style='background-color: #d12a00;'>" + list[index].viewAge + "</div>";
					}else{
						ageTag = "<div class='age' style='background-color: #318000;'>ALL</div>";
					}
					$(".item" +	i).append(
						"<div class='movie'>"
                            + "<div class='movieInfoTopWrap'>"
                            	+ ageTag
                                + "<img src='/images/" + list[index].postFileName + "'>"
                                + "<div class='overlay'></div>"
                                + "<div class='buttons'>"
                                    + "<button class='goMovieInfoBtn' value=" + list[index].movieCode + ">상세보기</button>"
                                    + "<button class='goMovieResrvBtn' value=" + list[index].movieCode + ">예매하기</button>"
                                + "</div>"
                                + "<div class='ranking'>" + (index + 1) + "</div>"
                                + "<div class='gradient'></div>"
                            + "</div>"
                            + "<div class='movieInfo'>"
                                + (list[index].movieTitle.length < 14 ? 
                                		"<div class='movieInfoTitle'>" + list[index].movieTitle + "</div>"
                                		: "<div class='movieInfoTitle'>" + list[index].movieTitle.substring(0, 14) + "···" + "</div>")
                                + "<div class='movieInfoBottomWrap'>"
                                    + "<span class='rate'><span class='star'>★</span>" + list[index].rate + "</span><span class='reservationRate'>예매율 37.1%</span>"
                                + "</div>"
                            + "</div>"
                        + "</div>"
					);
					index++;
				}
			}
		}
		xhttp.open("get", "/user/main/getMainMoiveList.do", true);
		xhttp.send();
	}
	
	$(document).on("click", ".goMovieInfoBtn", function(){
		//alert($(this).val());
		location.href = "/user/movieDetailView?movieCode=" + $(this).val();
	});
	
</script>
</body>
</html>