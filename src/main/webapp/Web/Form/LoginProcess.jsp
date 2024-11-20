<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String userId = request.getParameter("user_id");
    String userPwd = request.getParameter("user_pwd");  // 암호화된 비밀번호는 MemberDAO에서 처리

    // DB 연결 정보
    String oracleDriver = application.getInitParameter("OracleDriver");
    String oracleURL = application.getInitParameter("OracleURL");
    String oracleId = application.getInitParameter("OracleId");
    String oraclePwd = application.getInitParameter("OraclePwd");

    // DAO 객체로 로그인 인증 처리
    MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
    MemberDTO dto = dao.getMemberDTO(userId, userPwd);  // 평문 비밀번호를 사용 (암호화는 DAO에서 처리)

    dao.close();

    // 로그인 성공 여부 체크
    if (dto != null && dto.getId() != null) {
        // 로그인 성공 시 세션에 사용자 정보 저장
        session.setAttribute("UserId", dto.getId());
        session.setAttribute("UserName", dto.getName());
        session.setAttribute("UserEmail", dto.getEmail());
        session.setAttribute("UserPhone", dto.getPhone());
        response.sendRedirect("../Main.jsp");
    } else {
        // 로그인 실패 시 오류 메시지 출력
        request.setAttribute("LoginErrMsg", "아이디 또는 비밀번호가 잘못되었습니다.");
        request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
    }
%>

