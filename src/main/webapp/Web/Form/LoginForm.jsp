<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
<h1>로그인 페이지</h1>

<form action="LoginProcess.jsp" method="post">
    <p>아이디 : <input type="text" name="user_id"></p>
    <p>비밀번호 : <input type="password" name="user_pw"></p>
    <p><input type="submit" value="로그인"></p>
</form>

</body>
</html>
