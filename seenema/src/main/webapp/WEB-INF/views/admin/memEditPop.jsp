<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seenema Member Management Edit View</title>
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>회원 수정 윈도우 창</h1>
<hr>
   <div class="editBox">
      <form id="edit_frm" name="form_name" method="post">
      <c:forEach items="${list}" var="member">
         <div>
            <h3><label for="id">아이디</label></h3>
            <input type="text" id="editId" name="id" value="${member.id}" readonly>
         </div>
         <div>
            <h3><label for="pw">비밀번호</label></h3>
            <input type="text" id="editPw" name="pw" value="${member.pw}">
         </div>
         <div>
            <h3><label for="name">이름</label></h3>
            <input type="text" id="editName" name="name" value="${member.name}">
         </div>
         <div>
            <h3><label for="tel">연락처</label></h3>
            <input type="text" id="editTel" name="tel" value="${member.tel}">
         </div>
         <div>
            <h3><label for="gender">성별</label></h3>
            <c:if test="${member.gender eq '남자'}">
               <input type="radio" id="editGender" name="gender" value="남자" checked>남자
               <input type="radio" id="editGender" name="gender" value="여자">여자
            
            </c:if>
            <c:if test="${member.gender eq '여자'}">
               <input type="radio" id="editGender" name="gender" value="남자">남자
               <input type="radio" id="editGender" name="gender" value="여자" checked>여자
            </c:if>
         </div>
         <div>
            <h3><label for="birthday">생년월일</label></h3>
            <input type="text" id="editBirthday" name="birthday" value="${member.birthday}" readonly>
         </div>
         <div>
            <h3><label for="grade">등급</label></h3>
            <input type="text" id="editGrade" name="grade" value="${member.grade}">
         </div>
      </c:forEach>
         <div>
            <input type="button" value="회원정보수정" onclick="edit_btn()">
            <input type="button" value="닫기" onclick="popClose()">
         </div>
     </form>
   </div>
</body>
<script>

   function popClose(){
     opener.location.reload();
      window.close();
   }

    function edit_btn(){
      var form = $("#edit_frm").serialize();
      $.ajax({
        
          type : "post",
          url : "editInfo",
          data : form,
          dataType : "json",
          success : function(json){
             alert("회원목록을 수정하였습니다.");
             //한명의 회원목록 수정창을 닫음
             window.close();
             //회원목록을 보여주는 창을 새로고침
             opener.location.reload();
             
         },
         error : function(request, status, error){
              alert("회원수정실패");
         }
            
         
      });
      
   }
      //alert(formData);
      /*
      $.ajax({
        
         url : "editInfo",
         type : "POST",
         data : $("#edit_frm").serialize();
         dataType : 'json',
         contentType : "application/x-www-form-urlencoded; charset=utf-8",
         
         success : function(data){
          alert("성공");  
         },
         error : function(request, status, error){
            alert("실패");
         }
         
         
      });
   }*/
   /*
   function editAfterClose(){
      $(document).on("click", "edit_btn", function(e){
            window.opener.location.reload();    //부모창 reload
            window.close();    //현재 팝업창 Close
      });
      // alert("수정이 완료되었습니다.");
   }*/
   
   

</script>
</html>