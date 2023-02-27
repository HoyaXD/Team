<%--
  Created by IntelliJ IDEA.
  User: beomsu
  Date: 2023/02/10
  Time: 5:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 - 시네마</title>
    <style>
        table {
            border-collapse: collapse;
            margin: auto;
            width: 50%;
            font-family: Arial, sans-serif;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            width: 250px;
        }

        input[type="text"], input[type="password"], input[type="date"] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        input[type="submit"] {
            background-color: #373837;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 150px;
            height: 50px;
            float: right;
        }

        input[type="submit"]:hover {
            background-color: #474847;
        }

        #idcheck {
            position: relative;
        }

        h1{
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="mainContainer">
    <header>
        <%@ include file="header.jsp"%>
    </header>
    <h1>회원가입</h1>
    <br>
    <table>

        <form action="reg.do" method="post" name="frm">

            <tr>
                <th>아이디</th>
                <td id ="idcheck">
                    <input type="text" name="id" placeholder="6글자 이상, 영문과 숫자로 이루어진 아이디를 입력해주세요.">
                    <span id="idCheckComment"></span>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><input type="password" name="pw" placeholder="영문과 숫자를 포함한 8자 이상, 20자 이하의 비밀번호를 입력해주세요. "></td>
            </tr>
            <tr>
                <th>비밀번호확인</th>
                <td>
                    <input type="password" name="pw2" id="pwCheck">
                    <span id="pwCheckComment"></span>
                </td>
            </tr>

            <tr>
                <th>이름</th>
                <td><input type="text" name="name"></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="tel" placeholder="- 을 제외하고 숫자만 입력해주세요"></td>
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
                <td colspan="2"> <input type="submit" value="회원등록" onclick="return check()"></td>
            </tr>
        </form>
    </table>
</div>
<%@ include file="footer.jsp"%>

<script>

    $('#pwCheck').focusout(function() {  //비밀번호 확인
        let passRule = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
        let pw = document.frm.pw.value;
        if(document.frm.pw2.value != ""){
            if (pw.length < 8) {
                document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 8글자 이상이어야 합니다.</span>";
            }else if (pw.length > 20) {
                document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 20글자를 초과할 수 없습니다.</span>";
            }else if (!passRule.test(pw)) {
                document.getElementById("pwCheckComment").innerHTML ="<span style='color:red'>비밀번호는 특수문자,영문,숫자 모두 포함해야 합니다.</span>";
            }
            else if(document.frm.pw.value == document.frm.pw2.value){
                document.getElementById("pwCheckComment").innerHTML = "<span style='color:green'>비밀번호 일치</span>";
            } else {
                document.getElementById("pwCheckComment").innerHTML = "<span style='color:red'>비밀번호가 일치하지 않습니다</span>";
            }
        }
    });

    $('#idcheck').focusout(function (){ // 아이디입력 후 중복확인 메서드 실행
        const id = document.frm.id.value;
        if (document.frm.id.value == "") {
            $('#idCheckComment').text("");
        }else if (id.length < 6) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 6글자 이상이어야 합니다.</span>";
        }else if (id.length > 12) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 12글자를 초과할 수 없습니다.</span>";
        }else if (!/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/.test(id)) {
            document.getElementById("idCheckComment").innerHTML ="<span style='color:red'>아이디는 특수문자를 포함할 수 없고 영문과 숫자를 모두 포함해야 합니다.</span>";
        }else {
            idcheck();
        }
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
        } else if (document.frm.tel.value.length != 11) {
            alert("'-'를 제외한 전화번호를 입력해주세요");
            document.frm.tel.focus();
            return false;
        }else if (document.getElementById("idCheckComment").innerText != "사용가능") {
            alert("아이디 중복체크를 하세요.");
            document.frm.id.focus();
            return false;
        } else if(document.getElementById("pwCheckComment").innerText != "비밀번호 일치"){
            alert("비밀번호가 일치하지 않습니다");
            document.frm.pw.focus();
            return false;
        }else {
            return true;
        }
    }
</script>
</body>
</html>
