<%@page import="model2.qnaboard.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="model2.qnaboard.MVCBoardDAO"%>
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
<script>
    // 댓글 수정 폼을 표시하는 함수
    function showEditForm(commentId, content) {
        // 수정 폼을 표시하고 기존 내용을 텍스트 영역에 채운다
        let formId = "edit-form-" + commentId;
        document.getElementById(formId).style.display = "table-row";  // 폼을 보여줌
    }

    // 댓글 수정 폼을 숨기는 함수
    function hideEditForm(commentId) {
        let formId = "edit-form-" + commentId;
        document.getElementById(formId).style.display = "none";  // 폼을 숨김
    }

    // 댓글 삭제 확인
    function commentDeleteConfirm(commentId, boardId) {
        if (confirm('정말 삭제하시겠습니까?')) {
            location.href = 'view.do?commentId=' + commentId + '&idx=' + boardId;  // 댓글 ID와 게시물 ID를 함께 전달
        }
    }
</script>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 게시판</title>
</head>
<body>
<jsp:include page="../Main.jsp" />
<h2>Q&A 게시판 - 상세 보기(View)</h2>
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
        onclick="location.href='../qnaboard/edit.do?idx=${ param.idx }';">
            수정하기
        </button>
        </c:if>
		<script>
			let deleteConfirm = (idx) => {
				if(confirm('삭제하겠습니까?'))
					location.href='../qnaboard/delete.do?idx='+idx;
			}
		</script>
		<c:if test="${sessionScope.UserId == dto.id}">
			<button type="button" onclick="deleteConfirm(${ param.idx });">
			    삭제하기
			</button>
		</c:if>
        <button type="button" 
        onclick="location.href='../qnaboard/listPage.do';">
            목록 바로가기
        </button>
        </td>
    </tr>
</table>

<!-- 댓글 목록 출력 -->
<table border="1" width="90%">
	<colgroup>
        <col style="width: 10%;">
        <col style="width: 60%;">
        <col style="width: 14%;">
        <col style="width: 8%;">
        <col style="width: 8%;">
    </colgroup>
    <tr>
        <th style="text-align: center; vertical-align: middle;">작성자</th>
        <th style="text-align: center; vertical-align: middle;">내용</th>
        <th style="text-align: center; vertical-align: middle;">작성일</th>
        <th style="text-align: center; vertical-align: middle;">수정</th>
        <th style="text-align: center; vertical-align: middle;">삭제</th>
    </tr>
    <c:forEach var="comment" items="${comments}">
        <tr>
            <td style="text-align: center; vertical-align: middle;">${comment.userId}</td>
            <td><c:out value="${comment.content}"/></td>
            <td style="text-align: center; vertical-align: middle;">${comment.postdate}</td>
            
            <!-- 댓글 수정 폼을 위한 버튼과 숨겨진 폼 -->
            <td style="text-align: center; vertical-align: middle;">
                <c:if test="${sessionScope.UserId == comment.userId}">
                    <button type="button" onclick="showEditForm(${comment.commentId}, '${comment.content}')">수정</button>
                </c:if>
            </td>

            <td style="text-align: center; vertical-align: middle;">
                <c:if test="${sessionScope.UserId == comment.userId}">
                    <button type="button" onclick="commentDeleteConfirm(${comment.commentId}, ${dto.idx});">
                        삭제
                    </button>
                </c:if>
            </td>
        </tr>

        <!-- 댓글 수정 폼 (기본적으로 숨겨짐) -->
        <tr id="edit-form-${comment.commentId}" style="display:none;">
            <td colspan="5" style="text-align: center;">
                <form action="view.do?idx=${dto.idx}" method="post">
                    <input type="hidden" name="commentIdForUpdate" value="${comment.commentId}" />
                    <textarea name="updatedContent" rows="4" cols="50">${comment.content}</textarea><br>
                    <button type="submit">댓글 수정</button>
                    <button type="button" onclick="hideEditForm(${comment.commentId})">취소</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<!-- 댓글 작성 폼 -->
<table border="1" width="90%">
    <colgroup>
        <col style="width: 10%;">
        <col style="width: 60%;">
        <col style="width: 30%;">
    </colgroup>
    <tr>
        <th style="text-align: center; vertical-align: middle;">댓글</th>
        <th style="text-align: center; vertical-align: middle;">
            <form action="view.do?idx=${dto.idx}" method="post">
                <input type="hidden" name="boardId" value="${dto.idx}" />
                <textarea name="content" rows="4" cols="50" placeholder="댓글을 입력하세요" required></textarea>
        </th>
        <th style="text-align: center; vertical-align: middle;">
            <button type="submit">댓글 작성</button>
            </form> <!-- form 종료 -->
        </th>
    </tr>
</table>

</body>
</html>
