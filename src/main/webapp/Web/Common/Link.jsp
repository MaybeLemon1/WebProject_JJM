<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table border="1" width="90%"> 
    <tr>
        <td align="center">
        <!-- 로그인 여부에 따른 메뉴 변화. session영역에 인증관련
        속성이 없다면 로그아웃 상태이므로 '로그인' 링크 출력 -->
        <% if (session.getAttribute("UserId") == null) { %>
            <a href="../Form/Login.jsp">로그인</a>
        <% } else { %>
            <a href="../06Session/Logout.jsp">로그아웃</a>
        <% } %>
            <!-- 모델2 방식의 파일첨부 게시판 -->
            &nbsp;&nbsp;&nbsp; 
            <a href="../mvcboard/list.do">게시판(페이징X)</a>
            &nbsp;&nbsp;&nbsp; 
            <a href="../mvcboard/listPage.do">게시판(페이징O)</a>
        </td>
    </tr>
</table>
