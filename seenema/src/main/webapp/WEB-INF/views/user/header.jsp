<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
  <style>
    *{
      margin: 0 auto;
    }
    ul, li{
      list-style: none;
      text-align: center;
    }
    #header_top{
      width: 1300px;
      height: 130px;
      border-bottom: 1px solid #d2cece;
    }
    #top_logo{
      display: inline-block;
      float: left;
    }
    #top_logo img{
      width: 300px;
      height: 120px;
    }
    .top_menu{
      display: inline-block;
      float: right;
      margin-right: 60px;
    }
    .top_menu li{
      font-size: 12px;
      margin-top: 60px;
      float:right;
      margin-left:40px;
    }
    .top_menu img{
      width: 36px;
      height: 36px;
    }
    a{
      text-decoration-line: none;
      color: black;
    }



    .menu_wrap {

      width: 1300px;
      height: 40px;
      text-align: left;
      border-bottom: solid 2px red;
      z-index: 3;
    }
    .menu_wrap li{
      margin-top: 10px;
      float: left;
      margin-right: 80px;
      font-size: 18px;
    }

    .nav_active{
      position: absolute;
      z-index: 2;
      width: 1500px;
      left: 280px;
      height: 230px;
      background-color: white;
      display: none;
    }
    .nav_active li{
      margin-top: 25px;
    }
    .active_title{
      font-size: 18px;
      font-weight: bold;
    }
    .nav_flex{
      position: absolute;
      z-index: 1;
      text-align: left;
    }
    .under_menu{
      position: relative;
    }
    .active_menu{
      display: inline-block;
      z-index: 3;
      border-right: solid 1px #d2cece;
      width: 250px;
    }
    .active_menu li{
      text-align: left;
    }
    #active_board{
      border: none;
    }


  </style>
</head>
<body>
  <header>
    <div id="header_top">
      <a href="main"><div id="top_logo"><img src="/images/logo2.png"></div></a>
      <div class="top_menu">
        <ul>
          <c:if test="${sessionScope.logid == null }">
          <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
          <li><a href="regMemberForm"><img src="/images/join.png"><br>회원가입</a>
          <li><a href="loginForm"><img src="/images/login.png"><br>로그인</a>
            </c:if>
            <c:if test="${sessionScope.logid != null }">
            <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
            <li id="mypage"><a href="myPage"><img src="/images/my.png"><br>마이페이지</a>
            <li><a href="logout"><img src="/images/login.png"><br>로그아웃</a>
            </c:if>
        </ul>
      </div>
    </div>
    <div class = "under_menu">
      <div class = "menu_wrap">
        <ul class="dep1">
          <li><a href="#">영화</a></li>
          <li><a href="reservationMain">예매</a></li>
          <li><a href="storeView">스토어</a></li>
          <li><a href="menu">게시판</a></li>
        </ul>
      </div>
      <div class = "nav_active">
        <div class="nav_flex">
          <div id="active_movie" class="active_menu">
            <ul>
              <a href="#"><li class="active_title">영화</li></a>
              <a href="#"><li>무비차트</li></a>
              <a href="#"><li>아트하우스</li></a>
              <a href="#"><li>icecon</li></a>
            </ul>
          </div>
          <div id="active_reservation" class="active_menu">
            <ul>
              <a href="reservationMain"><li class="active_title">예매</li></a>
              <a href="reservationMain"><li>빠른예매</li></a>
              <a href="reservationHistory"><li>내 예매내역</li></a>
              <a href="#"><li>icecon</li></a>
            </ul>
          </div>
          <div id="active_store" class="active_menu">
            <ul>
              <a href="storeView"><li class="active_title">스토어</li></a>
              <a href="#"><li>무비차트</li></a>
              <a href="#"><li>아트하우스</li></a>
              <a href="#"><li>icecon</li></a>
            </ul>
          </div>
          <div id="active_board" class="active_menu">
            <ul>
              <a href="#"><li class="active_title">게시판</li></a>
              <a href="#"><li>무비차트</li></a>
              <a href="#"><li>아트하우스</li></a>
              <a href="#"><li>icecon</li></a>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </header>
<script>

  $(".dep1").hover(()=>{
      $(".nav_active").slideDown(500);
  });

  $('.under_menu').mouseleave(function (){
    $(".nav_active").slideUp(300);
  })





</script>
</body>
</html>
