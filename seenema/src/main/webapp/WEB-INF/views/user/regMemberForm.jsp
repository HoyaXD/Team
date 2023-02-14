<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/10
  Time: 5:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="mainContainer">
    <h1>회원가입</h1>
    <br>
    <table>

        <form action="reg.do" method="post" name="frm">

            <tr>
                <th>아이디</th>
                <td id ="idcheck"><input type="text" name="id"></td>
            </tr>
            <tr>
                <th></th>
                <td><span id="idCheckComment"></span></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name="pw"></td>
            </tr>
            <tr>
                <th>비밀번호확인</th>
                <td><input type="password" name="pw2" id="pwCheck"></td>
            </tr>
            <tr>
                <th></th>
                <td><span id="pwCheckComment"></span></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="tel"></td>
            </tr>
            <tr>
                <th>성별</th>
                <td>
                    <input type="radio" value="남자" name="gender" checked>남자
                    <input type="radio" value="여자" name="gender">여자
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td><input type="date" name="birthday"></td>
            </tr>
            <tr>
                <th>보안문자<span id="code"><%=(int) (Math.random() * 100000) + 12 %></span></th>
                <td><input type="text" name="secure"></td>
            </tr>
            <tr>
                <th></th>
                <td > <input type="submit" value="등록" onclick="return check()"></td>
            </tr>
        </form>
    </table>
</div>
<script>

    $('#pwCheck').focusout(function() {  //비밀번호 확인
        if(document.frm.pw2.value != ""){
            if(document.frm.pw.value == document.frm.pw2.value){
                document.getElementById("pwCheckComment").innerText = "비밀번호 일치";
            }else {
                document.getElementById("pwCheckComment").innerText = "비밀번호가 일치하지 않습니다";
            }
        }
    });

    $('#idcheck').focusout(function (){ // 아이디입력 후 중복확인 메서드 실행
        idcheck();
    })

    function idcheck() {  // 아이디 중복체크

        let param = document.frm.id.value;
        let url = "idcheck.do?id=" + param;
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function () {
            if (this.responseText == 1) {
                document.getElementById("idCheckComment").innerHTML = "사용가능";
            } else {
                document.getElementById("idCheckComment").innerHTML = "사용불가";
            }
            document.getElementById("idCheckComment").innerHTML = this.responseText;
        }
        xhttp.open("GET", url, true);
        xhttp.send(); //submit
    }

    function check() {           //중복확인 유효성검사

        if (document.frm.id.value == "") {
            alert("아이디가 입력되지 않았습니다.");
            document.frm.id.focus();
            return false;
        } else if (document.frm.pw.value == "") {
            alert("비밀번호가 입력되지 않았습니다.");
            document.frm.pw.focus();
            return false;
        } else if (document.frm.name.value == "") {
            alert("이름이 입력되지 않았습니다.");
            document.frm.name.focus();
            return false;
        } else if (document.frm.tel.value == "") {
            alert("전화번호가 입력되지 않았습니다.");
            document.frm.tel.focus();
            return false;
        } else if (document.getElementById("idCheckComment").innerText != "사용가능") {
            alert("아이디 중복체크를 하세요.");
            document.frm.id.focus();
            return false;
        } else if(document.getElementById("pwCheckComment").innerText != "비밀번호 일치"){
            alert("비밀번호가 일치하지 않습니다");
            document.frm.pw.focus();
            return false;
        } else if (document.frm.secure.value != document.getElementById("code").innerText) {
            alert("보안문자를 확인해주세요");
            return false;
        } else {
            alert("회원가입이 완료되었습니다.");
            return true;
        }
    }
</script>
</body>
</html>
