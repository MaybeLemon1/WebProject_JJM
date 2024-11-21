<%@page import="model2.libraryboard.MVCBoardDAO"%>
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
<title>자료실</title>
</head>
<body>
<h2>자료실 - 상세 보기(View)</h2>

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
        	<c:if test="${ not empty dto.ofile }">
        		<br />
        		<c:choose>
        			<c:when test="${ mimeType eq 'img' }">
        				<img src="../Uploads/${ dto.sfile }" style="max-width:600px" />
        			</c:when>
        			<c:when test="${ mimeType eq 'audio' }">
        				<audio controls="controls">
        					<source src="../Uploads/${ dto.sfile }" type="audio/mp3" />
        				</audio>
        			</c:when>
        			<c:when test="${ mimeType eq 'video' }">
        				<video controls>
        					<source src="../Uploads/${ dto.sfile }" type="video/mp4" />
        					Yout browser does not support the video tag.
        				</video>
        			</c:when>
        		</c:choose>
         	</c:if>
        </td>
    </tr>

    <!-- 첨부파일 -->
    <tr>
        <td>첨부파일</td>
        <td>
            <c:if test="${ not empty dto.ofile }">
            ${ dto.ofile }
            <a href="../libraryboard/download.do?ofile=${ dto.ofile }&sfile=${ dto.sfile }&idx=${ dto.idx }">
                [다운로드]
            </a>
            </c:if>
        </td>
        <td>다운로드수</td>
        <td>${ dto.downcount }</td>
    </tr>

    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
        <c:if test="${sessionScope.UserId == dto.id}">
	        <button type="button" 
	        onclick="location.href='../libraryboard/edit.do?idx=${ param.idx }';">
	            수정하기
	        </button>
        </c:if>
		<script>
			let deleteConfirm = (idx) => {
				if(confirm('삭제하겠습니까?'))
					location.href='../libraryboard/delete.do?idx='+idx;
			}
		</script>
		<c:if test="${sessionScope.UserId == dto.id}">
			<button type="button" onclick="deleteConfirm(${ param.idx });">
			    삭제하기
			</button>
		</c:if>
        <button type="button" 
        onclick="location.href='../libraryboard/listPage.do';">
            목록 바로가기
        </button>
        </td>
    </tr>
</table>
</body>
</html>
