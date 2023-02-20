<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seenema AD MainPage</title>
<!-- 그래프 -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 그래프2 -->
<script type="text/javascript">
	//메인에 보여줄 그래프 
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable([
				[ '예매율', '슬램덩크', '해리포터', '반지의 제왕', '아바타', '평균' ],
				[ '2004/05', 165, 938, 522, 998, 450 ],
				[ '2005/06', 135, 1120, 599, 1268, 288 ],
				[ '2006/07', 157, 1167, 587, 807, 397 ],
				[ '2007/08', 139, 1110, 615, 968, 215 ],
				[ '2008/09', 136, 691, 629, 1026, 366 ] ]);

		var options = {
			title : '금일 영화 예매율',
			hAxis : {
				title : '예매율'
			},
			seriesType : 'bars',
			series : {
				4 : {
					type : 'line'
				}
			}
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>
</head>
<body>
	<div class="gamut">
		<!-- 좌측메뉴 jsp -->
		<%@ include file="adminMenu.jsp"%>
		<!-- 메인메뉴 보여주는 파일 jsp -->
		<%@ include file="adminEasyView.jsp"%>
	</div>
</body>
</html>