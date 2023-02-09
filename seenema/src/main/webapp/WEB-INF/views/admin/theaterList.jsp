<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>영화관 조회 페이지</h1>
<hr>
<table border="1">
	<tr>
		<th>영화관 코드</th>
		<th>영화관 지역</th>
		<th>상영관 이름</th>
		<th>상영관 연락처</th>
	</tr>
	<c:forEach var="theater" items="${tList }">
	<tr>
		<td>${theater.theaterCode }</td>
		<td>${theater.theaterPlace }</td>
		<td>
			<a href="theaterUpdate?theaterCode=${theater.theaterCode }">
				${theater.theaterName }
			</a>
		</td>
		
		<td>${theater.theaterTel }</td>
	</tr>
	</c:forEach>
	<tr>
		<th colspan="4">
			<button onclick="location.href='theaterReg'">영화관 등록하기</button>
		</th>
	</tr>
</table>

<c:if test="${param.insert_result == 1}">
	<script>
		alert("등록완료!");
	</script>
</c:if>
<c:if test="${param.insert_result == 0}">
	<script>
		alert("등록실패....");
	</script>
</c:if>

<c:if test="${param.update_result == 1}">
	<script>
		alert("수정완료!");
	</script>
</c:if>
<c:if test="${param.update_result == 0}">
	<script>
		alert("수정실패....");
	</script>
</c:if>

<c:if test="${param.del_result == 1}">
	<script>
		alert("삭제완료!");
	</script>
</c:if>
<c:if test="${param.del_result == 0}">
	<script>
		alert("삭제실패....");
	</script>
</c:if>
</body>
</html>