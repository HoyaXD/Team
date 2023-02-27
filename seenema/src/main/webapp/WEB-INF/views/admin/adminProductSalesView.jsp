<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Admin Product Sales View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/css/adminMenu2.css">
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {

		$.ajax({

			url : "monthTotalPirce",
			type : "get",
			dataType : "text",

			success : function(data) {
				let obj = JSON.parse(data);
				let i = 0;

				for (i; i < 12; i++) {
					var jan = obj[0].totalPrice;
					var feb = obj[1].totalPrice;
					/* var mar = obj[2].totalPrice;
					var apr = obj[3].totalPrice;
					var may = obj[4].totalPrice;
					var jun = obj[5].totalPrice;
					var jul = obj[6].totalPrice;
					var aug = obj[7].totalPrice;
					var sep = obj[8].totalPrice;
					var oct = obj[9].totalPrice;
					var nov = obj[10].totalPrice;
					var dec = obj[11].totalPrice; */

					// Some raw data (not necessarily accurate)
					var data2 = google.visualization
							.arrayToDataTable([ [ 'Month', '상품 매출' ],
									[ '1월', jan ], [ '2월', feb ], ]);/* , [ '3월', mar ],
																																					[ '4월', apr ], [ '5월', may ],
																																					[ '6월', jun ], [ '7월', jul ],
																																					[ '8월', aug ], [ '9월', sep ],
																																					[ '10월', oct ], [ '11월', nov ],
																																					[ '12월', dec ], ]); */
				}

				var options = {
					seriesType : 'bars',
					hAxis : {
						format : 'decimal'
					},
					fontSize : 12,
					height : 400,
					series : {
						1 : {
							type : 'line'
						}
					}
				};
				var chart = new google.visualization.ComboChart(document
						.getElementById('chart_div'));
				chart.draw(data2, options);
			}
		});
	}
</script>
<!-- 원통차트 -->
<script type="text/javascript">
	google.charts.load("current", {
		packages : [ "corechart" ]
	});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		$.ajax({
			url : "productTotalView",
			type : "get",
			dataType : "text",

			success : function(data) {
				let obj = JSON.parse(data);
				let i = 0;
				for (i; i < obj.length; i++) {
					var data = google.visualization.arrayToDataTable([
							[ 'Task', '상품별 판매 차트' ],
							[ obj[0].productName, obj[0].total_count ],
							[ obj[1].productName, obj[1].total_count ],
							[ obj[2].productName, obj[2].total_count ],
							[ obj[3].productName, obj[3].total_count ],
							[ obj[4].productName, obj[4].total_count ] ]);

					var options = {
						title : 'Top5 상품 비율',
						is3D : true,
					};
				}
				var chart = new google.visualization.PieChart(document
						.getElementById('piechart_3d'));
				chart.draw(data, options);
			}
		});
	}
</script>
<!-- 성별차트 -->
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);
	
	$.ajax({
		
		url : "productManView",
		type : "get",
		dataType : "text",
		
		success : function(data){
			let obj = JSON.parse(data);
			let i = 0;

			for(i; i < obj.length; i++){
				$("#m_box").append('<td>'+ obj[i].total_count + '</td>');
				$("#mTotalPrice_box").append('<td>'+ obj[i].total_price + '</td>');

			} 
		},
		error : function (){}	
	});
	$.ajax({
		
		url : "productWomanView",
		type : "get",
		dataType : "text",
		
		success : function(data){
			let obj = JSON.parse(data);
			let i = 0;
			const womonMonth1 = obj[0].total_count;
			const womonMonth2 = obj[1].total_count;

		},
		error : function (){}	
	});
	function drawChart() {
		
		var man1 = Number($("#man0").text());
		var man2 = Number($("#man1").text());
		var woman1 = Number($("#woman0").text());
		var woman2 = Number($("#woman1").text());
		/* var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text();		
		var woman1 = $("#woman0").text();
		var woman1 = $("#woman0").text(); */
		var data = google.visualization.arrayToDataTable([ [ '달', '남자', '여자' ],
				[ '1월', man1,woman1 ], [ '2월', man2, woman2 ],/*  [ '3월', 44, 25 ],
				[ '4월', 57, 55 ], [ '5월', 62, 84 ], [ '6월', 79, 94 ],
				[ '7월', 124, 135 ], [ '8월', 142, 121 ], [ '9월', 216, 195 ],
				[ '10월', 184, 152 ], [ '11월', 201, 240 ], [ '12월', 46, 46 ], */

		]);

		var options = {
			title : '성별에 따른 상품 수익률',
			curveType : 'function',
			legend : {
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('curve_chart'));

		chart.draw(data, options);
	}
</script>

<style>
.main_view {
	overflow: scroll;
	height: auto;
}

#month_box {
	margin-top: 20px;
	width: 1040px;
	border: 1px red solid;
}

table {
	margin-left: 20px;
	margin-top: 20px;
	float: left;
	width: 300px;
	height: auto;
	float: left;
	margin-top: 20px;
	text-align: center;
}

table, td, th {
	border: 1px solid black;
	border-collapse: collapse;
	max-height: 380px;
}

;
#month_box>table>tr>th {
	width: 50px;
}

#month_box>table>tr>td {
	width: 250px;
}

#month_box table {
	margin-top: 40px;
	height: auto;
}

#productView_box {
	margin-top: 20px;
	width: 1040px;
	border: 1px red solid;
}

#piechart_3d {
	margin-top: 20px;
	float: right;
	width: 650px;
	height: 400px;
	margin-right: 35px;
}

#gender_box {
	margin-top: 20px;
	width: 1040px;
	display: inline-block;
}

#gender_box>table {
	margin-top: 20px;
	margin-left: 10px;
	width: 1035px;
}

#curve_chart {
	margin-top: 200px;
	width: 950px;
	height: 300px
}
</style>
</head>
<body>
	<div class="gamut">
		<!-- 좌측메뉴 jsp -->
		<%@ include file="adminMenu.jsp"%>
		<!--상단바-->
		<div class="main_view">

			<div id="month_box">
				<table>
					<thead>
						<tr>
							<th>월별</th>
							<th>총 매출</th>
						</tr>
					</thead>
					<tbody id="monthView">
						<!-- 여기서 매출을 출력 -->
					</tbody>
				</table>
				<div id="chart_div" style="width: 650px; height: 400px;"></div>
			</div>
			<div id="productView_box">
				<table>
					<thead>
						<tr>
							<th colspan="3">이번달 상품별 매출</th>
						</tr>
						<tr>
							<th>이름</th>
							<th>판매갯수</th>
							<th>매출</th>
						</tr>
					</thead>
					<tbody id="productView">
						<!-- 상품갯수 총 매출 -->
					</tbody>

				</table>
				<div id="piechart_3d"></div>
			</div>
			<div id="gender_box">
				<table>
					<tr>
						<th colspan="13">성별에 따른 총 판매 갯수</th>
					</tr>
					<tr>
						<th></th>
						<th>1월</th>
						<th>2월</th>
						<th>3월</th>
						<th>4월</th>
						<th>5월</th>
						<th>6월</th>
						<th>7월</th>
						<th>8월</th>
						<th>9월</th>
						<th>10월</th>
						<th>11월</th>
						<th>12월</th>
					</tr>
					<tbody >
						<tr id="m_box"><td> 남자 </td></tr>
					</tbody>
					<tbody>
						<tr id="w_box"><td> 여자 </td></tr>
					</tbody>
					<tbody>
						<tr  id="mTotalPrice_box"><td>남자 총 매출액</td></tr>
					</tbody>
					<tbody>
						<tr  id="wTotalPrice_box"><td>여자 총 매출액</td></tr>
					</tbody>
					<tbody>
						<tr id="totalPrice_box"><td>합산</td></tr>
					</tbody>
				</table>
				<div id="curve_chart" style="width: 950px; height: 650px"></div>
			</div>

		</div>
	</div>

	<script>
		monthView();
		productTotalView();
		productManView();
		productWomanView();
		
		totalPrice();
		function monthView() {

			$.ajax({

				url : "monthTotalPirce",
				type : "get",
				dataType : "text",

				success : function(data) {
					let obj = JSON.parse(data);
					let i = 0;
					for (i; i < obj.length; i++)
						$("#monthView").append(
								'<tr><th>' + obj[i].month + "월" + "</th><td>"
										+ obj[i].totalPrice.toLocaleString()
										+ "</td></tr>")
				},
				error : function() {

				}
			});
		}
		function productTotalView(){
			$.ajax({

				url : "productTotalView",
				type : "get",
				dataType : "text",

				success : function(data) {
					let obj = JSON.parse(data);
					let i = 0;
					for (i; i < obj.length; i++)
						$("#productView").append(
								'<tr><th>' + obj[i].productName + "</th><td>"
										+ obj[i].total_count + "</th><td>"
										+ obj[i].totalPrice.toLocaleString()
										+ "</td></tr>")
				},
				error : function() {

				}
			});
		}
		function productManView(){
			$.ajax({
				
				url : "productManView",
				type : "get",
				dataType : "text",
				
				success : function(data){
					let obj = JSON.parse(data);
					let i = 0;
		
					for(i; i < obj.length; i++){
						$("#m_box").append('<td>'+ obj[i].total_count + '</td>');
						$("#mTotalPrice_box").append('<td  id="man'+ i +'">'+ obj[i].total_price + '</td>');

					} 
				},
				error : function (){}	
			});
		}
		
		function productWomanView(){
			$.ajax({
				
				url : "productWomanView",
				type : "get",
				dataType : "text",
				success : function(data){
					let obj = JSON.parse(data);
					let i = 0;
					
					for(i; i < obj.length; i++){
			
						$("#w_box").append('<td>'+ obj[i].total_count + '</td>');
						$("#wTotalPrice_box").append('<td id="woman'+ i +'">'+ obj[i].total_price + '</td>');

					} 
					
				},
				error : function (){}
			});
		}
		
		function totalPrice(){
			$.ajax({
				
				url : "genderTotalPriceView",
				type : "get",
				dataType : "text",
				success : function(data){
					let obj = JSON.parse(data);
					
					let i = 0;
					for(i; i < obj.length; i++){
						$("#totalPrice_box").append('<td>'+ obj[i].totalPrice + '</td>');

					} 
				},
				error : function (){}	
			});
		}
		
	</script>
</body>
</html>