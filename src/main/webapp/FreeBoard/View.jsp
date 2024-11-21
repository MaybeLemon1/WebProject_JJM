<%@page import="model2.freeboard.MVCBoardDAO"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<%
    String idx = request.getParameter("idx"); // 게시물 ID

    String cookieName = "viewCount_" + idx; // 각 게시물마다 고유한 쿠키를 사용

    boolean isFirstVisit = CookieManager.increaseViewCount(request, response, cookieName);

    if (isFirstVisit) {
        MVCBoardDAO dao = new MVCBoardDAO();
        dao.updateVisitCount(idx);
    }
  	
%>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>
</head>
<body>
<h2>자유 게시판 - 상세 보기(View)</h2>

<table border="1" width="90%">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup>
    <tr>
        <td>번호</td> <td>${ dto.idx }</td>
        <td>작성자</td> <td>${ dto.name }</td>
    </tr>
    <tr>
        <td>작성일</td> <td>${ dto.postdate }</td>
        <td>조회수</td> <td>${ dto.visitcount }</td>
    </tr>
    <tr>
        <td>제목</td>
        <td colspan="3">${ dto.title }</td>
    </tr>
    <tr>
        <td>내용</td>
        <td colspan="3" height="100">
        	${ dto.content }
        </td>
    </tr>
    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
        <c:if test="${sessionScope.UserId == dto.id}">
        <button type="button" 
        onclick="location.href='../freeboard/edit.do?idx=${ param.idx }';">
            수정하기
        </button>
        </c:if>
		<script>
			let deleteConfirm = (idx) => {
				if(confirm('삭제하겠습니까?'))
					location.href='../freeboard/delete.do?idx='+idx;
			}
		</script>
		<c:if test="${sessionScope.UserId == dto.id}">
			<button type="button" onclick="deleteConfirm(${ param.idx });">
			    삭제하기
			</button>
		</c:if>
        <button type="button" 
        onclick="location.href='../freeboard/listPage.do';">
            목록 바로가기
        </button>
        </td>
    </tr>
</table>
</body>
</html>
