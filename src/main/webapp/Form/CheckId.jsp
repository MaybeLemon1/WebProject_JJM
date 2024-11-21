<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = request.getParameter("userId");

    if (userId == null || userId.trim().isEmpty()) {
        out.print("<script>alert('아이디를 입력해주세요.'); window.close();</script>");
        return;
    }

    // DB 연결
    String oracleDriver = application.getInitParameter("OracleDriver");
    String oracleURL = application.getInitParameter("OracleURL");
    String oracleId = application.getInitParameter("OracleId");
    String oraclePwd = application.getInitParameter("OraclePwd");

    MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

    // 아이디 중복 체크
    boolean isDuplicate = dao.checkIdExists(userId);

    if (isDuplicate) {
        out.print("<script>");
        out.print("alert('이미 존재하는 아이디입니다.');");
        out.print("window.close();");
        out.print("</script>");
    } else {
        out.print("<script>");
        out.print("alert('사용 가능한 아이디입니다.');");
        // 부모 창에 아이디와 중복 확인 상태를 설정
        out.print("window.opener.document.getElementsByName('id')[0].value = '" + userId + "';");
        out.print("window.opener.isIdChecked = true;");  // 중복 확인 상태 true로 설정
        out.print("window.close();");
        out.print("</script>");
    }

    dao.close();
%>
