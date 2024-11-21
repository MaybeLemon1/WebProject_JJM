<%@ page import="membership.MemberDTO" %>
<%@ page import="membership.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션에서 로그인된 사용자 정보 가져오기
    String userId = (String) session.getAttribute("UserId");
    String userName = (String) session.getAttribute("UserName");
    String userEmail = (String) session.getAttribute("UserEmail");
    String userPhone = (String) session.getAttribute("UserPhone");

%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script type="text/javascript">
        // 폼 제출 전 유효성 검사
        function validateForm() {     
            if (document.registerForm.pwd.value == "") {
                alert("비밀번호를 입력하세요.");
                return false;
            }

            if (document.registerForm.pwd.value != document.registerForm.pwdCheck.value) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            return true;  // 모든 검사를 통과하면 폼 제출
        }
    </script>
</head>
<body>
<jsp:include page="../Main.jsp" />
<h1>회원정보 수정</h1>
<form name="registerForm" method="post" action="MemberEditProcess.jsp" onsubmit="return validateForm()">
    <input type="hidden" name="userId" value="<%= userId %>">
    <label>아이디: <%= userId %></label><br>
    <label>비밀번호: <input type="password" name="pwd" required></label><br>
    <label>비밀번호 확인: <input type="password" name="pwdCheck" required></label><br>
    <input type="hidden" name="userName" value="<%= userName %>">
    <label>이름: <%= userName %></label><br>
    <label>이메일: <input type="email" name="email" value="<%= userEmail %>" required></label><br>
    <label>전화번호: <input type="text" name="phone" value="<%= userPhone %>" required></label><br>
    <input type="submit" value="수정하기">
</form>
</body>
</html>
