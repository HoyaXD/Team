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
					</div>
					<div id="sm4" style="margin-top:15px;">
						<h4>한줄평2</h4>
						<hr>
					</div>
				</div>
			</div>
		</div>
		<script>
         $(document).ready(function(){
            alert("메인페이지 실행!");
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
         });
      
      </script>
</body>
