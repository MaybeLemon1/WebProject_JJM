<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 회원가입 폼에서 전달된 파라미터 값 받기
    String userId = request.getParameter("id");
    String userPwd = request.getParameter("pwd");
    String userName = request.getParameter("name");
    String userEmail = request.getParameter("email");
    String userPhone = request.getParameter("phone");

    // DTO 객체 생성하여 입력값 저장
    MemberDTO dto = new MemberDTO();
    dto.setId(userId);
    dto.setPwd(userPwd);
    dto.setName(userName);
    dto.setEmail(userEmail);
    dto.setPhone(userPhone);

    // DB 연결 및 회원가입 처리
    String oracleDriver = application.getInitParameter("OracleDriver");
    String oracleURL = application.getInitParameter("OracleURL");
    String oracleId = application.getInitParameter("OracleId");
    String oraclePwd = application.getInitParameter("OraclePwd");

    MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
    int result = dao.insertMember(dto);  // insertMember 메서드 호출

    // 회원가입 성공 여부에 따라 처리
    if (result > 0) {
        out.print("<script>alert('회원가입이 성공적으로 완료되었습니다.'); location.href='login.jsp';</script>");
    } else {
        out.print("<script>alert('회원가입에 실패했습니다.'); history.back();</script>");
    }

    dao.close();  // DB 연결 종료
%>
