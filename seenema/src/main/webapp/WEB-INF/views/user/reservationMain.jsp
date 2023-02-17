<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/11
  Time: 9:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
  <style>
    *{
      margin: 0 auto;
    }

    #header{
      width: 1300px;
      height: 150px;
      border: solid 1px red;
    }

    #reservationMain{
        margin-top: 50px;
      display: grid;
      width: 1300px;
      grid-template-columns: 350px 350px 150px 450px;
        place-items: center;

    }

    .item{
      border: solid 3px #d3cfcf;
        width: 100%;
      height: 600px;
        background-color: #e8e5dd;
        margin: 0 auto;
    }

    .listMenu{
        width: 100%;
        background-color: #333333;
        text-align: center;
        color: #f0f0f0;
        height: 33px;
        line-height: 33px;

    }
    .movieListView{
        display: block;
    }
    .theaterListView{
        display: grid;
        grid-template-columns: repeat(2, 1fr);
    }
    .theaterItems{
        width: 100%;
    }
    .movie img{
        width: 25px;
        height: 25px;
    }
    .theaterItems{
        height: 40px;
        line-height: 40px;
    }
    .movieTitle {
        width: 150px;
        position: relative;
        bottom: 5px;
    }
    .place{
        background-color: #dcdbd7;
    }
    #timeList{
        margin: 0 auto;

    }
    .time{
        display: inline-block;
        width: 130px;
        height: 50px;
        text-align: center;
        line-height: 50px;
        border: solid 1px #d5d4d2;
        margin: 5px;
    }
    .reservationInfo{
        display: flex;
        width: 1300px;
        justify-content: flex-start;
    }
    .calendar {
        font-family: Arial, sans-serif;
        font-size: 16px;
        overflow: scroll;
        overflow-x: hidden;
        height: 567px;
    }
    .calendar::-webkit-scrollbar {
        width: 10px;
        height: 10px;
        background-color: black;
    }
    .calendar::-webkit-scrollbar-thumb {
        background: #a4a4a2; /* 스크롤바의 색상 */
        height: 3px;
        border-radius: 10px;
    }
    .calendar::-webkit-scrollbar-track {
        background-color: #e8e5dd;
        border-radius: 10px;
        box-shadow: inset 0px 0px 5px white;
    }
    .calendar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .calendar li {
        display: block;
        margin-bottom: 10px;
    }
    .time{
        display: none;
    }
    #hidden{
        width: 1300px;
        text-align: right;
    }


  </style>
</head>
<body>
<header>
    <%@ include file="../user/header.jsp"%>
</header>
  <div id="reservationMain">
      <div class="item" id="movieList">
            <div class="listMenu">
                영화
            </div>
          <div class="movieListView">
                <c:forEach var="movie" items="${mlist }">
                    <div class="movie">
                        <span><img src="/images/${movie.viewAge }.png"></span>
                        <span class="movieTitle">${movie.movieTitle }</span>
                        <span><input type="hidden"value="${movie.movieCode }"></span>
                        <span id="postFileName2"><input type="hidden"value="${movie.postFileName }"></span>
                    </div>
                </c:forEach>
          </div>

      </div>
      <div class="item" id="theaterList">
          <div class="listMenu">
              극장
          </div>
          <div class="theaterListView">
            <div class="theaterItems" id="place">
                <c:forEach var="theater" items="${tlist }">
                    <div class="place">
                       <span class="placeList">${theater.theaterPlace }</span>
                       <span>(${theater.cnt })</span><br>
                    </div>
                </c:forEach>
            </div>
              <div class="theaterItems" id="address">

              </div>
          </div>
      </div>
      <div class="item" id="dateList">
          <div class="listMenu">
            날짜
          </div>
          <div class="calendar">
              <ul id="calendar-list"></ul>
          </div>
      </div>
      <div class="item" id="timeList">
          <div class="listMenu">
              시간
          </div>
          <div class="time">
              10:20
          </div>
          <div class="time">
              12:20
          </div>
          <div class="time">
              13:30
          </div>
          <div class="time">
              17:20
          </div>
          <div class="time">
              18:30
          </div>
          <div class="time">
              19:40
          </div>
          <div class="time">
              21:30
          </div>
          <div class="time">
              23:20
          </div>
      </div>
  </div>
  <div class="reservationInfo">
    <div class="info" id="movieInfo">

    </div>
    <div class="info" id="theaterInfo">극장선택</div>
    <div class="info" id="seatsInfo">영화선택</div>
    <div class="info" id="pay">좌석선택</div>
  </div>
<div id="hidden">
    <form action="reservationSeats" method="post">
        <input type="hidden" name="movieCode" id="movieCode">
        <input type="hidden" name="movieTitle" id="movieTitle">
<%--        <input type="text" name="postFileName" id="postFileName">--%>
        <input type="hidden" name="id" value="${sessionScope.logid}">
        <input type="hidden" name="theaterPlace" id="theaterPlace" placeholder="지역">
        <input type="hidden" name="theater" id="theater" placeholder="영화관">
        <input type="hidden" name="movieDate" id="movieDate" placeholder="날짜">
        <input type="hidden" name="reservateTime" id="reservateTime" placeholder="시간">
        <input type="submit" value="좌석선택">
    </form>
</div>
<footer>
    <%@ include file="../user/footer.jsp"%>
</footer>
<script>
    var today = new Date();

    var year = today.getFullYear();
    var month = ('0' + (today.getMonth() + 1)).slice(-2);
    var day = ('0' + today.getDate()).slice(-2);

    var dateString = year + '-' + month  + '-' + day; //오늘 날짜 구하기

    let d = new Date();
    let sel_month = 1; //
    d.setMonth(d.getMonth() + sel_month );

    let year2    = d.getFullYear();
    let month2   = ('0' + (d.getMonth() +  1 )).slice(-2);
    let day2     = ('0' + d.getDate()).slice(-2);
    dt = year2+"-"+month2+"-"+day2;
     //한달 뒤 날짜 구하기

    const startDate = new Date(dateString); // 시작 날짜 설정 (오늘)
    const endDate = new Date(dt); // 마지막 날짜 설정 (한달 뒤)

    // Loop over each day and add it to the calendar
    const calendarList = document.getElementById('calendar-list');
    for (let date = startDate; date <= endDate; date.setDate(date.getDate() + 1)) {
        const listItem = document.createElement('li');
        listItem.className = "cal_list";
        const dateText = document.createTextNode(date.toISOString().slice(0, 10));
        listItem.appendChild(dateText);
        calendarList.appendChild(listItem);
    }

    $('.cal_list').click(function (e){  //날짜 선택시 css, hidden에 값 넣기
        $('#movieDate').val($(e.target).text());
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });

        $('.time').css({
            "display" : "inline-block"
        })
    })

    $('.time').click(function (e){  //시간 선택시 css, hidden에 값 넣기
        $('#reservateTime').val($(e.target).text());
        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });

    })

    $('.movieTitle').click(function (e){ //영화 제목 선택


        $('#movieCode').val($(e.target).next().children().val()); //영화코드에 값넣기
        $('#postFileName').val($(e.target).nextAll('#postFileName2').children().val()); //파일네임에 값넣기
        $('#movieTitle').val($(e.target).text()); //영화제목에 값넣기


        $('.movieTitle').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $('.movieTitle').parent( 'div' ).css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });

        $(e.target).parent( 'div' ).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });
    })

    $(document).on("click", ".theater",function (e){  //영화관 클릭
        $('#theater').val($(e.target).text()); //영화관에 값넣기

        $('.theater').css({
            "background-color":"#dcdbd7",
            "color":"black"
        })
        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });
    })


    $(document).on("click", ".placeList",function (e){ // 선택된 영화지역에 있는 상영관 보여주기
        $('#theaterPlace').val($(e.target).text()); //영화지역에 값넣기

        $('.placeList').css({
            "background-color":"#d5d4d2",
            "color":"black"
        });

        $('.placeList').parent( 'div' ).css({
            "background-color":"#d5d4d2",
            "color":"black"
        })
        $(e.target).css({
            "background-color":"#e8e5dd",
        });

        $(e.target).parent( 'div' ).css({
            "background-color":"#e8e5dd",
        });
        var place = $(e.target).text();
    $.ajax({
            url : "getTheaterList.do?place="+place,
            type : "get",
            datatype : "text",
            success : function(data) {
                let obj = JSON.stringify(data);
                let parse = JSON.parse(obj);
                let i = 0;
                $("#address").empty();
                for (i; i < parse.length; i++) {
                    $("#address")
                        .append(
                            '<div class="theater" style="height: 30px; line-height: 30px;"> '
                            + parse[i].theaterName
                            + '<div>')
                }
            },
            error : function() {
                alert("극장목록 불러오기 실패");
            }
        });
    });


</script>
</body>
</html>
