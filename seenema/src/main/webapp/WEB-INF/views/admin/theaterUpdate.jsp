<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>영화관 정보 수정 페이지</h1>
<hr>
<form action="theaterUpdate.do" method="post">
	<table border="1">
		<tr>
			<th>영화관 코드</th>
				<td><input type="text" name="theaterCode" id="theaterCode" value="${theater.theaterCode }" readonly></td>
		</tr>
		<tr>
			<th>영화관 지역</th>
				<td>
					<select name="theaterPlace" size="1">
						<option value="${theater.theaterPlace }">${theater.theaterPlace }</option>
						<option value="서울특별시">서울특별시</option>
						<option value="인천광역시">인천광역시</option>
						<option value="대전광역시">대전광역시</option>
						<option value="대구광역시">대구광역시</option>
						<option value="부산광역시">부산광역시</option>
						<option value="광주광역시">광주광역시</option>
						<option value="창원특례시">창원특례시</option>	
					</select>
				</td>
		</tr>
		<tr>
			<th>상영관 이름</th>
				<td><input type="text" name="theaterName" id="theaterName" value="${theater.theaterName }"></td>
		</tr>
		<tr>
			<th>상영관 주소</th>
				<td><input type="text" name="theaterAddress" id="theaterAddress" value="${theater.theaterAddress }"></td>
		</tr>
		<tr>
			<th>상영관 연락처</th>
				<td><input type="text" name="theaterTel" id="theaterTel" value="${theater.theaterTel }"></td>
		</tr>
		<tr>
			<th>상영관 좌석수</th>
				<td><input type="text" name="theaterSeats" value="${theater.theaterSeats }">석</td>
		</tr>
		<tr>
			<th rowspan="2">상영관 위도/경도</th>
				<td>위도 : <input type="text" name="latitude" id="latitude" value="${theater.latitude }"></td>
		</tr>
		<tr>
			<td>경도 : <input type="text" name="longitude" id="longitude" value="${theater.longitude }"></td>
		</tr>
		<tr>
			<th>상영관 지도</th>
			<td id="map" style="width:350px;height:350px;"></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="button" value="삭제하기" id="delBtn" onclick="delete();">
				<input type="submit" value="수정하기">
			</th>
		</tr>
	</table>
</form>
<script>
	$("#delBtn").on("click", function(){
		location.href="theaterDelete.do?theaterCode=" + $("#theaterCode").val();
	})
</script>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e2cb63af5ce21e3e335968b15d8713a"></script>
<script>
	let latitude = $("#latitude").val();
	let longitude = $("#longitude").val();
	let theaterName = $("#theaterName").val();
	let theaterTel = $("#theaterTel").val();
	let theaterAddress = $("#theaterAddress").val();
	

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	var iwContent = '<div style="padding:5px;">'+theaterName+'<br>'
			+'<a href="https://map.kakao.com/link/map/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <큰지도보기></a> '
			+'<a href="https://map.kakao.com/link/to/'+theaterName+','+latitude+','+ longitude+'" style="color:blue; font-size:10pt;" target="_blank"> <길찾기></a></div>',
	    iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치입니다
	
	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker);  
	
</script>


</body>
</html>