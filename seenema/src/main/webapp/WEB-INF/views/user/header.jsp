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
      padding-top: 30px;
      width: 1300px;
      height: 100px;
      border-bottom: 1px solid #d2cece;
    }
    #top_logo{
      display: inline-block;
      float: left;
    }
    #top_logo img{
      width: 250px;
      height: 80px;
    }
    .top_menu{
      display: inline-block;
      float: right;
      margin-right: 60px;
    }
    .top_menu li{
      font-size: 12px;
      margin-top: 30px;
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
    .menu_wrap{
      position: relative;
      width:1300px;
      height: 40px;
      text-align:left;
    }
    .menu_wrap li{
      margin-top: 10px;
      float: left;
      margin-right: 80px;
      font-size: 18px;
    }
    .menu_wrap_after{
      border: solid 1px red;
    }
    .nav_active{
      height: 300px;
      display: none;
      position: relative;
      z-index: 3;
    }
    .nav_flex{
      display: flex;
    }
    .nav_active li{
      margin-top: 25px;
    }
    .active_title{
      font-size: 24px;
    }
    .active_menu{
    }
    .test{
      border: #1f53ff;
      height: 80px;
    }
  </style>
</head>
<body>
  <header>
    <div id="header_top">
      <a href="#"><div id="top_logo"><img src="/images/logo.png"></div></a>
      <div class="top_menu">
        <ul>
          <c:if test="${sessionScope.logid == null }">
          <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
          <li><a href="regMemberForm"><img src="/images/join.png"><br>회원가입</a>
          <li><a href="loginForm"><img src="/images/login.png"><br>로그인</a>
            </c:if>
            <c:if test="${sessionScope.logid != null }">
            <li><a href="#"><img src="/images/service.png"><br>고객센터</a>
            <li id="mypage"><a href="regMain"><img src="/images/my.png"><br>마이페이지</a>
            <li><a href="logout"><img src="/images/login.png"><br>로그아웃</a>
            </c:if>
        </ul>
      </div>
    </div>
    <div class = "menu_wrap">
      <ul class="dep1">
        <li><a href="#">영화</a></li>
        <li><a href="reservationMain">예매</a></li>
        <li><a href="storeView">스토어</a></li>
        <li><a href="menu">게시판</a></li>
      </ul>
    </div>
    <div class = "menu_wrap_after"></div>
    <div class = "nav_active">
      <div class="nav_flex">
      <div id="active_moive" class="active_menu">
        <ul>
          <a href="#"><li class="active_title">영화</li></a>
          <a href="#"><li>무비차트</li></a>
          <a href="#"><li>아트하우스</li></a>
          <a href="#"><li>icecon</li></a>
        </ul>
      </div>
      <div id="active_reservation" class="active_menu">
        <ul>
          <a href="#"><li class="active_title">영화</li></a>
          <a href="#"><li>무비차트</li></a>
          <a href="#"><li>아트하우스</li></a>
          <a href="#"><li>icecon</li></a>
        </ul>
      </div>
      <div id="active_store">
        <ul>
          <a href="#"><li class="active_title">영화</li></a>
          <a href="#"><li>무비차트</li></a>
          <a href="#"><li>아트하우스</li></a>
          <a href="#"><li>icecon</li></a>
        </ul>
      </div>
      <div id="active_board">
        <ul>
          <a href="#"><li class="active_title">영화</li></a>
          <a href="#"><li>무비차트</li></a>
          <a href="#"><li>아트하우스</li></a>
          <a href="#"><li>icecon</li></a>
        </ul>
      </div>
      </div>
    </div>

  </header>
<script>
  $('.dep1').hover(function (){
    $('.nav_active').css("display", "block");
  })

  $('.nav_active').mouseleave(function (){
    $('.nav_active').css("display", "none");
  })
  // $('.menu_wrap').mouseleave(function (){
  //   $('.nav_active').css("display", "none");
  // })


</script>
</body>
</html>
