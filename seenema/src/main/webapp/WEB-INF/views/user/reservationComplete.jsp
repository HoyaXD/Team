<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/18
  Time: 9:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예매완료 - 시네마</title>
    <style>
        .ticket {
            width: 700px;
            height: 350px;
            position: relative;
            background: url('/images/ticket.jpg') no-repeat center center;
            background-size: cover;
            /*border-radius: 10px;*/
            /*box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);*/
            overflow: hidden;
            display: flex;
        }

        .ticket:before,
        .ticket:after {
            content: "";
            position: absolute;
            bottom: 0;
            background: inherit;
            height: 50%;
            width: 50%;
            transform: skewX(-45deg);
            transform-origin: bottom left;
            border-radius: 5px;
            z-index: -1;
        }

        .ticket:before {
            left: 0;
        }

        .ticket:after {
            right: 0;
            transform-origin: bottom right;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="header.jsp"%>
</header>
    <div>
        영화예매완료<br>
        영화를 예매 해주셔서 감사합니다
        <span>예매 내역은 마이페이지에서 확인과 취소가 가능합니다.</span>
    </div>
<div class="ticket">
    <div>
    <p>예매번호 : ${reservation.ticketCode}</p>
    <p>상영일 : ${reservation.movieDate}</p>
    <p>상영시간 : ${reservation.reservationTime}</p>
    <p>상영관  : ${reservation.theaterPlace} ${reservation.theater}</p>
    <p>가격 : ${reservation.ticketPrice}</p>
    </div>
    <div>
    <p>영화명 : ${reservation.movieTitle}</p>
    <p>좌석 : ${reservation.seats}</p>
    </div>
</div>
</body>
</html>
