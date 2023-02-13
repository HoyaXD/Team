<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
</head>
<body>
<h1>매출현황페이지</h1>
<hr>
<h3>영화예매율</h3>
<table border="1">
	<tr>
		<th>순위</th>
		<th>영화코드</th>
		<th>예매율</th>
		<th>포스터</th>
		<th>영화 제목</th>
		<th>개봉일</th>
	</tr>
	<c:forEach var="m" items="${mList }" varStatus="status">
	<tr>
		<td>${status.count}</td>
		<td>${m.movieCode }</td>
		<td>${m.hit }</td>
		<td><img src="/resources/imgs/${m.postFileName }" width="100px"></td>
		<td>${m.movieTitle }</td>
		<td>${m.releaseDate }</td>
	</tr>
	</c:forEach>
</table>
<hr>
<h3>상품판매량</h3>
<table border="1">
	<tr>
		<th>순위</th>
		<th>상품코드</th>
		<th>판매량</th>
		<th>이미지</th>
		<th>상품명</th>
		<th>상품가격</th>
	</tr>
	<c:forEach var="p" items="${pList }" varStatus="status">
	<tr>
		<td>${status.count}</td>
		<td>${p.productCode }</td>
		<td id="productSales">${p.productSales }</td>
		<td><img src="/resources/imgs/${p.productImage }" width="100px"></td>
		<td id="productName">${p.productName }</td>
		<td>${p.price }</td>
	</tr>
	</c:forEach>
</table>

    <div style="width: 400px; height: 500px;">
        <canvas id="chart"></canvas>
    </div>
    
    <script>
    let pName = document.querySelectorAll("#productName");
    let productName = new Array();
  	for(let i = 0; i < pName.length; i++){
  		productName[i] = pName[i].innerText;
  	}
  	
  	let pSales = document.querySelectorAll("#productSales");
  	
  	let productSales = new Array();
  	for(let i = 0; i < pSales.length; i++){
  		productSales[i] = pSales[i].innerText;
  		
  	}
  	
    $(function() {
        var ctx = document.getElementById('chart').getContext('2d');
        var chart = new Chart(ctx, {
            
            // The type of chart we want to create
            type: 'bar',
        
            data: {
            	// 배열 값 넣기
                labels: productName,
                datasets: [{
                    label: '판매량',
                    type : 'bar',
                    fill : false,
                    lineTension : 0.2,
                    pointRadius : 3.5,
                    backgroundColor: '#00a2be',
                    borderColor: '#00a2be', // 그래프 선,
                    // 배열 값 넣기
                    data: productSales,
                    
                }]
            },
        
            // Configuration options
            options: {
            	tooltips: {
    				enabled: false
    			},
    			hover: {
    				animationDuration: 0
    			},
    			animation: {
    				duration: 1,
    				onComplete: function () {
    					var chartInstance = this.chart,
    						ctx = chartInstance.ctx;
    					ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
    					ctx.fillStyle = 'purple';
    					ctx.textAlign = 'center';
    					ctx.textBaseline = 'bottom';

    					this.data.datasets.forEach(function (dataset, i) {
    						var meta = chartInstance.controller.getDatasetMeta(i);
    						meta.data.forEach(function (bar, index) {
    							var data = dataset.data[index];							
    							ctx.fillText(data, bar._model.x, bar._model.y - 5);
    						});
    					});
    				}
    			},
                legend: {
                     labels: {
                          fontColor: 'black' // label color
                         }
                      },
                scales: {
                    // y축
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            fontColor:'black' // y축 폰트 color
                        }
                     }],
                     // x축
                     xAxes: [{
                         stacked: true,
                        ticks: {
                            fontColor:'black' // x축 폰트 color
                        }
                     }]
                }
            }
        });
    });
    </script>
</body>
</html>