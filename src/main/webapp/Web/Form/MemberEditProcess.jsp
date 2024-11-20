<%@ page import="membership.MemberDAO" %>
<%@ page import="membership.MemberDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 회원 수정 폼에서 전달된 파라미터 값 받기
    String userId = request.getParameter("userId");
    String userPwd = request.getParameter("pwd");
    String userName = request.getParameter("userName");
    String userEmail = request.getParameter("email");
    String userPhone = request.getParameter("phone");

    // DTO 객체 생성하여 입력값 저장
    MemberDTO dto = new MemberDTO();
    dto.setId(userId);
    dto.setPwd(userPwd);
    dto.setName(userName);
    dto.setEmail(userEmail);
    dto.setPhone(userPhone);

    // DB 연결 및 회원 정보 수정 처리
    String oracleDriver = application.getInitParameter("OracleDriver");
    String oracleURL = application.getInitParameter("OracleURL");
    String oracleId = application.getInitParameter("OracleId");
    String oraclePwd = application.getInitParameter("OraclePwd");

    MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
    
    // updateMember 호출
    int result = dao.updateMember(dto);  // updateMember 메서드 호출

    // 결과에 따라 처리
    if (result > 0) {
        out.print("<script>alert('회원정보가 성공적으로 수정되었습니다.'); location.href='MemberEdit.jsp';</script>");
    } else {
        out.print("<script>alert('회원정보 수정에 실패했습니다.'); history.back();</script>");
    }

    dao.close();  // DB 연결 종료
%>
