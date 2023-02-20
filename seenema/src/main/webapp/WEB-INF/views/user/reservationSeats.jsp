<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/16
  Time: 10:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>좌석예매 - 시네마</title>
    <script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/reservationSeats.css">
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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
            ${reservation.movieDate} ${reservation.reservationTime}<br>
            가격 : <span id="totalPrice">0</span> <br>
        </div>

        <form action="reservation.do" method="post" name="frm">
            <input type="hidden" name="movieCode" id="movieCode" value="${reservation.movieCode}">
            <input type="hidden" name="ticketCode" id="ticketCode" value="123">
            <input type="hidden" name="movieTitle" id="movieTitle" value="${reservation.movieTitle}">
            <input type="hidden" name="id" value="${sessionScope.logid}">
            <input type="hidden" name="theaterPlace" id="theaterPlace" value="${reservation.theaterPlace}">
            <input type="hidden" name="theater" id="theater" value="${reservation.theater}">
            <input type="hidden" name="ticketPrice" id="ticketPrice" value="${reservation.ticketPrice}">
            <input type="hidden" name="movieDate" id="movieDate" value="${reservation.movieDate}">
            <input type="hidden" name="reservationTime" id="reservationTime" value="${reservation.reservationTime}">
            <input type="hidden" name="visitors" id="visitors">
            <input type="hidden" name="seats" id="seats">
            <input type="submit" value="예매등록 테스트" id="regBtn" onclick="return f();">
            <div class="buyNowBtn" >결제하기</div>
        </form>

    </div>



    <div id="screen">Screen</div>
    <div id="seats-container"></div>
</div>

<footer>
    <%@ include file="footer.jsp"%>
</footer>


<script>

    //성인 청소년 선택
    let adultsInput = document.getElementById('adults');
    let youthInput = document.getElementById('youth');
    let visitors = document.getElementById('visitors');
    let seats = document.getElementById('seats');

    function f(){
        if(visitors.value != selectedSeats.length){
            alert("선택하신 인원 수와 좌석수가 일치하지 않습니다. 인원수와 좌석을다시 확인해주세요");
            return false;
        }else {
            return true;
        }
    }

    $("#adults").on("change", function(){ //옵션값 변경 시 가격 자동 계산
        if(parseInt(adultsInput.value) + parseInt(youthInput.value) >6){
            alert('성인과 청소년을 합쳐 최대 6명까지 선택 가능합니다');
            adultsInput.value = 0;
        }
        //selected value
        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('ticketPrice').value = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('visitors').value = parseInt(adultsInput.value) + parseInt(youthInput.value); //인원수에 값넣기
    });

    $("#youth").on("change", function(){  //옵션값 변경 시 가격 자동 계산

        if(parseInt(adultsInput.value) + parseInt(youthInput.value) >6){
            alert('성인과 청소년을 합쳐 최대 6명까지 선택 가능합니다');
            youthInput.value = 0;
        }
        //selected value
        document.getElementById('totalPrice').innerText = parseInt(adultsInput.value)*15000 + parseInt(youthInput.value)*11000;  //가격 계산
        document.getElementById('visitors').value = parseInt(adultsInput.value) + parseInt(youthInput.value); //인원수에 값넣기
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
                        seats.value = "";
                        for (let i = 0 ; i <selectedSeats.length; i++){
                            if(i != selectedSeats.length -1){
                                seats.value += selectedSeats[i] + ",";
                            }else {
                                seats.value += selectedSeats[i];
                            }
                        }

                    } else {
                        if(parseInt(adultsInput.value) + parseInt(youthInput.value) == 0){
                            alert('인원수를 먼저 선택해주세요.');
                        }
                        else if (selectedSeats.length < parseInt(adultsInput.value) + parseInt(youthInput.value)) {
                            seatEl.classList.add('selected');
                            selectedSeats.push(row[j]);
                            seats.value = "";
                            for (let i = 0 ; i <selectedSeats.length; i++){
                                if(i != selectedSeats.length -1){
                                    seats.value += selectedSeats[i] + ",";
                                }else {
                                    seats.value += selectedSeats[i];
                                }
                            }

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


    const IMP = window.IMP;
    IMP.init("imp58206540");

    // 결제 하기
    $(document).on("click", ".buyNowBtn", function(){
        if(visitors.value != selectedSeats.length){
            alert("선택하신 인원 수와 좌석수가 일치하지 않습니다. 인원수와 좌석을다시 확인해주세요");
            return false;
        }
        let ticketCode = parseInt(new Date().getTime(), 10);	// 주문번호
        let movieTitle = document.getElementById('movieTitle').value;	// 영화제목
        let ticketPrice = document.getElementById('ticketPrice').value;	// 결제 금액
        let userName = "김범수";	//유저 이름

        IMP.request_pay({
            pg: "html5_inicis",
            pay_method: "card",
            merchant_uid: ticketCode,   // 주문번호
            name: movieTitle,
            amount: 100,  //ticketPrice로 수정해야함
            buyer_name: userName,
        },  function (rsp) { // callback
            if (rsp.success) {
                // 결제 성공
                alert('결제 성공!');
                document.frm.submit();
            } else {
                // 결제 실패
                alert("결제를 취소하였습니다.");
                console.log(rsp);
            }
        });
    });
</script>
</body>
</html>
