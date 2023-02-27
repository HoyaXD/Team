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
    <title>영화예매 - 시네마</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/reservationMain.css">
    <style>
        .reservationInfo{
            display: flex;
            width: 1300px;
            height: 100px;
            color: white;
            /*justify-content: flex-start;*/
        }
        .ri_wrap{
            background-color: #343433;

        }
        sel_postFileName img{
            width: 30px;
            height: 80px;
        }
        input[type=submit]{
            margin-top: 10px;
            width: 100px;
            height: 100px;
            background-color: #ee1919;
            border: solid 1px red;
            border-radius: 8px;
            color: white;
            font-size: 24px;
        }
        #sel_title{
            margin-bottom: 10px;
        }

        .info{
            /*padding-top: 40px;*/
        }
        #theaterInfoDiv{
            padding-top: 40px;
        }
        #timeInfoDiv{
            padding-top: 40px;
        }
    </style>
</head>
<body>
<div class="box">
    <%@ include file="../user/header.jsp"%>
<div class="content">
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
          <div class="time">10:20</div>
          <div class="time">12:20</div>
          <div class="time">13:30</div>
          <div class="time">17:20</div>
          <div class="time">18:30</div>
          <div class="time">19:40</div>
          <div class="time">21:30</div>
          <div class="time">23:20</div>
      </div>
  </div>
    <div id="hidden">
        <form action="reservationSeats" method="post" name="frm">
            <input type="hidden" name="movieCode" id="movieCode">
            <input type="hidden" name="movieTitle" id="movieTitle">
            <%--        <input type="text" name="postFileName" id="postFileName">--%>
            <input type="hidden" name="id" value="${sessionScope.logid}">
            <input type="hidden" name="theaterPlace" id="theaterPlace" placeholder="지역">
            <input type="hidden" name="theater" id="theater" placeholder="영화관">
            <input type="hidden" name="movieDate" id="movieDate" placeholder="날짜">
            <input type="hidden" name="reservationTime" id="reservationTime" placeholder="시간">


    </div>
    <div class="ri_wrap">
        <div class="reservationInfo">
            <div class="info" id="movieInfo">
                <span id="sel_postFileName"></span>
            </div>
            <div class="info" id="theaterInfoDiv">
                <p id="sel_title"></p>
                <span id="theaterInfo"></span>
                <span id="theaterInfo2"></span>
            </div>
            <div class="info" id="timeInfoDiv">
                <span id="timeInfo"></span>
                <span id="timeInfo2"></span>
            </div>
            <div class="info" id="pay"><input type="submit" value="좌석선택" onclick="return validateForm();"></div>
            </form>
      </div>
    </div>
</div>

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
        $('#timeInfo').text($(e.target).text());
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
        $('#reservationTime').val($(e.target).text());
        $('#timeInfo2').text($(e.target).text());
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
        $('#sel_postFileName').html('<img src ="/images/'+$(e.target).nextAll('#postFileName2').children().val()+'" width="90px" height="130px">');
        $('#movieTitle').val($(e.target).text()); //영화제목에 값넣기
        $('#sel_title').text($(e.target).text()); //영화제목에 값넣기
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        $('#theaterInfo').text("");
        $('#theaterInfo2').text("");

        $('.placeList').css({
            "background-color":"#dedad2",
            "color":"black"
        });

        $('.placeList').parent( 'div' ).css({
            "background-color":"#dedad2",
            "color":"black"
        })
        $('.theater').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })


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
        $('#theater').val($(e.target).text().trim()); //영화관에 값넣기
        $('#theaterInfo2').text($(e.target).text()); //영화관에 값넣기
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $('.theater').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });
    })


    $(document).on("click", ".placeList",function (e){ // 선택된 영화지역에 있는 상영관 보여주기
        $('#theaterPlace').val($(e.target).text()); //영화지역에 값넣기
        $('#theaterInfo').text($(e.target).text()); //영화지역에 값넣기
        $('#theaterInfo2').text("");
        $('#timeInfo').text("");//영화시간초기화
        $('#timeInfo2').text("");
        $('.theater').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.cal_list').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $('.placeList').css({
            "background-color":"#dedad2",
            "color":"black"
        });

        $('.placeList').parent( 'div' ).css({
            "background-color":"#dedad2",
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
                            '<div class="theater" style="height: 30px; line-height: 30px; cursor: pointer;"> '
                            + parse[i].theaterName
                            + '<div>')
                }
            },
            error : function() {
                alert("극장목록 불러오기 실패");
            }
        });
    });

    function validateForm() {     //유효성검사
        var movieTitle = document.getElementById("movieTitle");
        var id = document.getElementsByName("id")[0];
        var theaterPlace = document.getElementById("theaterPlace");
        var theater = document.getElementById("theater");
        var movieDate = document.getElementById("movieDate");
        var reservationTime = document.getElementById("reservationTime");

        if (id.value === "") {
            if (confirm("로그인이 필요한 서비스입니다. 로그인하시겠습니까?")) {
                window.location.href = "loginForm"; // 로그인 페이지 경로
            }
            return false;
        }
        else if (movieTitle.value === "") {
            alert("영화를 선택해주세요");
            return false;
        }

        else if (theaterPlace.value === "") {
            alert("상영관 지역을 선택해주세요");
            return false;
        }
        else if (theater.value === "") {
            alert("상영관을 선택해주세요");
            return false;
        }
        else if (movieDate.value === "") {
            alert("날짜를 선택해주세요");
            return false;
        }
        else if (reservationTime.value === "") {
            alert("상영 시간을 선택해주세요");
            return false;
        }
        return true;
    }


</script>
</body>
</html>
