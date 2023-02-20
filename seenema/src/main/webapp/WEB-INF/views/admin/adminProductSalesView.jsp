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
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable([
				[ 'Month', '상품 매출' ], [ '1월', 1720000000 ],
				[ '2월', 1350000000 ], [ '3월', 1570000000 ],
				[ '4월', 1394200000 ], [ '5월', 1361000000 ],
				[ '6월', 1650000000 ], [ '7월', 1352150000 ],
				[ '8월', 1576421000 ], [ '9월', 1391130000 ],
				[ '10월', 1361000000 ], [ '11월', 1390000000 ],
				[ '12월', 1360000000 ], ]);

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
		chart.draw(data, options);
	}
</script>
<!-- 원통차트 -->
<script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', '상품별 판매 차트'],
          ['팝콘',     222],
          ['콜라',      312],
          ['나쵸',  150],
          ['1인세트', 406],
          ['2인세트',    1200]
        ]);

        var options = {
          title: '상품별 판매 차트',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
<!-- 성별차트 -->
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['달', '남자', '여자'],
          [ '1월', 84, 95],
          [ '2월', 24, 55],
          [ '3월', 44, 25],
          [ '4월', 57, 55],
          [ '5월', 62, 84],
          [ '6월', 79, 94],
          [ '7월', 124, 135],
          [ '8월', 142, 121],
          [ '9월', 216, 195],
          [ '10월', 184, 152],
          [ '11월', 201, 240],
          [ '12월', 46	, 46],
          
			
        ]);

        var options = {
          title: '성별에 따른 상품 판매 개수',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
    </script>

<style>
#left_box {
	float: left;
	width: 300px;
}

table {
	margin-left: 20px;
	margin-top: 20px;
	float: left;
	width: 300px;
	height: 300px;
	float: left;
	margin-top: 20px;
}

#chart_box {
	margin-top: 20px;
	float: right;
	width: 700px;
	height: 400px;
}

#month_box table {
	margin-top: 40px;
	height: 550px;
}

#piechart_3d {
	margin: 40px 10px 0 0;
	width: 400px;
	height: 250px;
}
</style>
</head>
<body>
	<div class="gamut">
		<!-- 좌측메뉴 jsp -->
		<%@ include file="adminMenu.jsp"%>
		<!--상단바-->
		<div class="main_view">
			<div id="left_box">
				<div id="table_box">
					<table border="1" style="height: 200px;">
						<tr>
							<td>월</td>
							<td>상품 총 매출</td>
						</tr>
						<tr>
							<td>1월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>2월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>3월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>4월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>5월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>6월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>7월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>8월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>9월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>10월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>11월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>12월</td>
							<td>1720000000</td>
						</tr>
						<tr>
							<td>총합</td>
							<td>20640000000</td>
						</tr>
					</table>
				</div>
				<div id="month_box">
					<table border="1">
						<tr>
							<td colspan="3">이번달 상품별 매출</td>
						</tr>
						<tr>
							<td>이름</td>
							<td>판매갯수</td>
							<td>매출</td>
						</tr>
						<tr>
							<td>팝콘</td>
							<td>222</td>
							<td>1470000</td>
						</tr>
						<tr>
							<td>콜라</td>
							<td>312</td>
							<td>6120000</td>
						</tr>
						<tr>
							<td>나쵸</td>
							<td>222</td>
							<td>4220000</td>
						</tr>
						<tr>
							<td>나쵸</td>
							<td>222</td>
							<td>4220000</td>
						</tr>
						<tr>
							<td>나쵸</td>
							<td>222</td>
							<td>4220000</td>
						</tr>
						<tr>
							<td>나쵸</td>
							<td>222</td>
							<td>4220000</td>
						</tr>
					</table>

				</div>
			</div>
			<div id="chart_box">
				<div id="chart_div" style="width: 650px; height: 400px;"></div>
				<div id="piechart_3d"></div>
				<div id="curve_chart" style="width: 900px; height: 500px"></div>
			</div>




		</div>
	</div>
</body>
</html>