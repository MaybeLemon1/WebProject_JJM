<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script type="text/javascript">
        // 기본적으로 아이디 중복 확인이 안된 상태
        var isIdChecked = false; // 중복 확인 여부 변수

        // 중복 확인 팝업을 여는 함수
        function fn_idCheck() {
            if (document.registerForm.id.value == "") {
                alert("아이디를 입력하세요.");
                return;
            }

            // 팝업 창을 열어 중복 체크
            window.open("CheckId.jsp?userId=" + document.registerForm.id.value, "", "width=300, height=150");
        }

        // 팝업 창에서 부모 페이지로 값이 돌아오면 isIdChecked를 업데이트
        window.onload = function() {
            // 부모 창의 isIdChecked가 true로 설정되면 값이 업데이트됨
            if (window.opener && window.opener.isIdChecked) {
                isIdChecked = window.opener.isIdChecked;
            }
        };

        // 폼 제출 전 중복 확인 여부 체크
        function validateForm() {
            if (!isIdChecked) {
                alert("아이디 중복 확인을 해주세요.");
                return false;  // 중복 확인이 안되었으면 제출하지 않음
            }

            // 추가적인 폼 유효성 검사를 여기에 추가
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

<h1>회원가입</h1>
<form name="registerForm" method="post" action="RegisterProcess.jsp" onsubmit="return validateForm()">
    <label>아이디: <input type="text" name="id"></label>
    <button type="button" onclick="fn_idCheck()">아이디 중복 확인</button><br>

    <label>비밀번호: <input type="password" name="pwd"></label><br>
    <label>비밀번호 확인: <input type="password" name="pwdCheck"></label><br>
    <label>이름: <input type="text" name="name"></label><br>
    <label>이메일: <input type="email" name="email"></label><br>
    <label>전화번호: <input type="text" name="phone"></label><br>

    <input type="submit" value="회원가입">
</form>
</body>
</html>

