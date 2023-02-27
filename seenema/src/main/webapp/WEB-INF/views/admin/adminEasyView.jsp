<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 관리자 좌측메뉴 css를 위한 자바스크립트 -->
<script type="text/javascript" src="/js/adminMenu.js"></script>
<!-- 관리자 메인메뉴 css를 위한 메인메뉴 -->
<link rel="stylesheet" href="/css/adMainEasyView.css">
<!-- 제이쿼리 -->
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<body>
<div class="main_view">
			<div id="doToday_menu">
				<div id="doToday_title">
					<p style="margin: 20px 0 5px 45px;">오늘의 할일</p>
					<hr>
					<div id="doToday_detail">
						<div>상영중인 영화</div>
						<div>예매자 수</div>
						<div>예매 취소</div>
						<div>금일 문의글</div>
						<div>답변 대기</div>
						<div>답변 완료</div>
						<div>금일 상품 판매</div>
						<div>상품 구매 취소</div>
					</div>
				</div>
				<div id="chart_div"></div>
			</div>
			<div id="simpleView">
				<div style="margin-top:15px; margin-right:16px;">
					<div id="sm1">
						<h4>일자별 요약</h4>
						<hr>
					</div>
					<div id="sm2" style="margin-top:15px;">
						<h4>문의</h4>
						<hr>
						<div id="qnaView_box"></div>
					</div>
				</div>

				<div style="margin-top:15px;  margin-left:16px;">
					<div id="sm3">
						<h4>한줄평</h4>
						<hr>
						<div id="replyView_box"></div>
					</div>
					<div id="sm4" style="margin-top:15px;">
						<h4>최근 예매 내역</h4>
						<hr>
						<div id="reservationView_box"></div>
					</div>
				</div>
			</div>
		</div>
		<script>
		
         $(document).ready(function(){
        	//qna출력
            $.ajax({
               url : "qnaMainView",
               type : "get",
               dataType : "text",
               
               success : function(data){
                  var bar = '|';  
                  let obj = JSON.parse(data);
                  let i = 0;
                  for(i; i < 6; i ++){
                     var resultDate = obj[i].regiDate.substring(0, 10);
                     var resultTime = obj[i].regiDate.substring(11, 16);
                     $("#qnaView_box").append("<br>" + obj[i].title + "<br>"
                                 + obj[i].id 
                                 + "&nbsp;&nbsp;&nbsp;" + bar + "&nbsp;&nbsp;&nbsp;" 
                                 + resultDate + "&nbsp;&nbsp;" + resultTime
                                 + "<br>");
                  }
               }
            });
          //reply출력
            $.ajax({
                url : "replyMainView",
                type : "get",
                dataType : "text",
                
                success : function(data){
                   var bar = '|';  
                   let obj = JSON.parse(data);
                   let i = 0;
                   for(i; i < 3; i ++){
                  
                      $("#replyView_box").append("<br>" + obj[i].comment + "<br>"
                                  + obj[i].id 
                                  + "&nbsp;&nbsp;&nbsp;" + bar + "&nbsp;&nbsp;&nbsp;" 
                                  + obj[i].movieTitle + "&nbsp;&nbsp;" + obj[i].rate
                                  + "<br>");
                   }
                }
             });
          //최근예매내역출력
            $.ajax({
                url : "reservationMainView",
                type : "get",
                dataType : "text",
                
                success : function(data){
                   var bar = '|';  
                   let obj = JSON.parse(data);
                   let i = 0;
                   for(i; i < 3; i ++){
                	   
                      $("#reservationView_box").append("<br>" + obj[i].movieTitle +  "&nbsp;&nbsp;&nbsp;" + bar + "&nbsp;&nbsp;&nbsp;" 
                                  + obj[i].theater + "<br>");
              
                   }
                   $("#reservationView_box").css("width", "200px;")
                },error : function(){
                	
                }
             });
         });

         
      
      </script>
</body>
