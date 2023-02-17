<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/16
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <style>
        #screen{
            width: 800px;
            height: 50px;
            background-color: black;
            color: white;
            text-align: center;
            line-height: 50px;
            font-size: 36px;
            margin-bottom: 40px;
        }
        #seats-top{
            width: 800px;
            margin-top: 20px;
            height: 200px;
        }
        #seats-container {
            width: 800px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .seat {
            margin-bottom: 10px;
            width: 50px;
            height: 50px;
            border-radius: 5px;
            border: 2px solid #ccc;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .seat.selected {
            background-color: #f13f3f;
            color: #fff;
        }

        #seats-label {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
            font-weight: bold;
        }

        #seats-label span {
            margin: 0 5px;
        }

        input[type=number] {
            width: 50px;
            height: 30px;
            border-radius: 5px;
            border: 2px solid #ccc;
            padding: 5px;
            text-align: center;
        }

        label {
            font-weight: bold;
        }
        #select_people{
            display: inline-block;
        }
        #reservation_info{
            display: inline-block;
            float: right;
        }

    </style>
</head>
<body>
<header>
    <%@ include file="header.jsp"%>
</header>
<div>
    <div id="seats-top">
        <div id="select_people">
            <label for="adults">성인</label>
            <select id="adults">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select><br>
            <label for="youth">청소년</label>
            <select id="youth">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                <option value="6">6</option>
            </select>
        </div>
        <div id="reservation_info">
            ${reservation.movieTitle}<br>
            ${reservation.theaterPlace}<br>
            ${reservation.theater}<br>
            ${reservation.movieDate} ${reservation.reservateTime}<br>
            가격 : <span id="totalPrice"></span> <br>
        </div>


    </div>



    <div id="screen">Screen</div>
    <div id="seats-container"></div>
</div>




<script>
    //성인 청소년 선택
    const adultsInput = document.getElementById('adults');
    const youthInput = document.getElementById('youth');

    document.getElementById('totalPrice').innerText = parseInt(adultsInput.value) + parseInt(youthInput.value);

    $("#adults").on("change", function(){ //옵션값 변경 시 가격 자동 계산
        //selected value
        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;
    });

    $("#youth").on("change", function(){  //옵션값 변경 시 가격 자동 계산
        //selected value
        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;
    });
    //좌석 행, 열 정해주기
    let rows = 10;
    let cols = 10;

    //선택한 좌석을 저장할 배열
    let selectedSeats = [];

    //좌석배치 생성
    function generateSeatLayout(rows, cols) {
        const seatLayout = [];

        for (let i = 0; i < rows; i++) {
            const row = [];

            for (let j = 0; j < cols; j++) {
                const seat = String.fromCharCode(65 + j) + (i + 1);
                row.push(seat);
            }

            seatLayout.push(row);
        }

        return seatLayout;
    }



    //좌석 줄바꿈, 클릭이벤트
    function renderSeatLayout(seatLayout) {
        const seatsContainer = document.getElementById('seats-container');
        seatsContainer.innerHTML = '';

        for (let i = 0; i < seatLayout.length; i++) {
            const row = seatLayout[i];
            const rowEl = document.createElement('div');

            for (let j = 0; j < row.length; j++) {
                const seatEl = document.createElement('div');
                seatEl.classList.add('seat');
                seatEl.dataset.seat = row[j];
                seatEl.innerText = row[j];

                seatEl.addEventListener('click', () => {
                    if (seatEl.classList.contains('selected')) {
                        seatEl.classList.remove('selected');
                        selectedSeats = selectedSeats.filter(s => s !== row[j]);
                    } else {
                        if(parseInt(adultsInput.value) + parseInt(youthInput.value) == 0){
                            alert('인원수를 먼저 선택해주세요.');
                        }
                        else if (selectedSeats.length < parseInt(adultsInput.value) + parseInt(youthInput.value)) {
                            seatEl.classList.add('selected');
                            selectedSeats.push(row[j]);

                        } else {
                            alert('선택한 인원수를 초과하였습니다.');
                        }
                    }
                });

                rowEl.appendChild(seatEl);
            }

            seatsContainer.appendChild(rowEl);
        }
    }

    let seatLayout = generateSeatLayout(rows, cols);
    renderSeatLayout(seatLayout);




</script>
</body>
</html>
