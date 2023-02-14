<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/11
  Time: 9:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<html>
<head>
    <title>Title</title>
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
    }
    .place{
        background-color: #d5d4d2;
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
  </style>
</head>
<body>


  <div id="reservationMain">
      <div class="item" id="movieList">
            <div class="listMenu">
                영화
            </div>
          <div class="movieListView">
                <c:forEach var="movie" items="${mlist }">
                    <div class="movie">
                        <span><img src="/images/${movie.viewAge }.png"></span>
                        <span  class="movieTitle">${movie.movieTitle }</span>
                        <span><input type="hidden"value="${movie.movieCode }"></span>
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
          <div>
              <input type="date">
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
<script>

    $('.time').click(function (e){

        $('.time').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })

        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });

    })

    $('.movieTitle').click(function (e){

        alert($(e.target).next().children().val()); // movieCode
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

    $(document).on("click", ".theater",function (e){
        $('.theater').css({
            "background-color":"#e8e5dd",
            "color":"black"
        })
        $(e.target).css({
            "background-color":"#5c5c5c",
            "color":"white"
        });
    })


    $(document).on("click", ".placeList",function (e){

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
