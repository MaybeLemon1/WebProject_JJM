<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
	<table border="1" width="90%"> 
    <tr>
        <td align="center">
        <!-- 로그인 여부에 따른 메뉴 변화. session영역에 인증관련
        속성이 없다면 로그아웃 상태이므로 '로그인' 링크 출력 -->
        <% if (session.getAttribute("UserId") == null) { %>
        	<a href="<%= request.getContextPath() %>/Web/Form/LoginForm.jsp">로그인</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="<%= request.getContextPath() %>/Web/Form/RegisterForm.jsp">회원가입</a>
        <% } else { %>
        	<%= session.getAttribute("UserName") %> 회원님
        	&nbsp;&nbsp;&nbsp; 
        	<a href="<%= request.getContextPath() %>/Web/Form/MemberEdit.jsp">회원정보 수정</a>
        	&nbsp;&nbsp;&nbsp; 
            <a href="<%= request.getContextPath() %>/Web/Form/Logout.jsp">로그아웃</a>
        <% } %>
            <!-- 모델2 방식의 파일첨부 게시판 -->
            &nbsp;&nbsp;&nbsp; 
            <a href="<%= request.getContextPath() %>/Web/mvcboard/list.do">자유게시판</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="./mvcboard/listPage.do">Q&A 게시판</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="<%= request.getContextPath() %>/Web/mvcboard/listpage.do">자료실</a>
        </td>
    </tr>
</table>
</body>
</html>