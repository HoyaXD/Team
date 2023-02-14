<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/10
  Time: 4:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>로그인</h1>
    <hr>
    <form action="login.do" method="post" name="frm">
        <input type="text" name="id" placeholder="아이디">
        <input type="password" name="pw">
        <input type="submit" value="로그인" onclick="return check();">
    </form>

<script>
    function check(){
        if (document.frm.id.value == "") {
            alert("아이디가 입력되지 않았습니다.");
            document.frm.id.focus();
            return false;
        } else if (document.frm.pw.value == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            document.frm.pw.focus();
            return false;
        }else{
            return true;
        }
    }
</script>
</body>
</html>
