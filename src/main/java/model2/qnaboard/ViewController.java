package model2.qnaboard;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//열람하기(어노테이션을 이용한 매핑)
@WebServlet("/qnaboard/view.do")
public class ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/*
	서블릿의 수명주기 메서드 중 요청을 받아 get/post방식을 판단하는 service() 
	메서드를 통해 모든 방식의 요청을 처리할 수 있다. 
	 */
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // 게시물 불러오기
        MVCBoardDAO dao = new MVCBoardDAO();
        //파라미터로 전달된 일련번호 받기 
        String idx = req.getParameter("idx");
        //조회수 1 증가
        // dao.updateVisitCount(idx);
        //일련번호에 해당하는 게시물 인출 
        
        if(req.getMethod().equals("POST")) {
        	String commentContent = req.getParameter("content");  // 댓글 내용 받기
            String userId = (String) req.getSession().getAttribute("UserId");  // 로그인한 사용자 ID
            
            
            if (commentContent != null && !commentContent.trim().isEmpty()) {
                 // 댓글 추가
                 int result = dao.insertComment(Integer.parseInt(idx), userId, commentContent);

                 // 댓글 추가 결과 처리
                 if (result > 0) {
                     resp.sendRedirect("view.do?idx=" + idx);
                     return;
                 } else {
                     req.setAttribute("error", "댓글 추가 실패");
                 }
             }
        }
        
        // 댓글 수적 처리
        String updatedCommentContent = req.getParameter("updatedContent");
        String commentIdForUpdate = req.getParameter("commentIdForUpdate");

        if (updatedCommentContent != null && !updatedCommentContent.trim().isEmpty() 
                && commentIdForUpdate != null && !commentIdForUpdate.trim().isEmpty()) {
            try {
                int commentId = Integer.parseInt(commentIdForUpdate);
                int result = dao.updateComment(commentId, updatedCommentContent);  // 댓글 수정
                if (result > 0) {
                    resp.sendRedirect("view.do?idx=" + idx);  // 댓글 수정 후 페이지 새로 고침
                    return;
                } else {
                    req.setAttribute("error", "댓글 수정 실패");
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "잘못된 댓글 ID입니다.");
            }
        }
        
        // 댓글 삭제 처리
        String deleteCommentId = req.getParameter("commentId");
        if (deleteCommentId != null) {
            try {
                int commentId = Integer.parseInt(deleteCommentId);
                dao.deleteComment(commentId);  // 댓글 삭제
                resp.sendRedirect("view.do?idx=" + idx);
                return;
            } catch (NumberFormatException e) {
                req.setAttribute("error", "잘못된 댓글 ID입니다.");
                req.getRequestDispatcher("/QnABoard/View.jsp").forward(req, resp);
            }
        }

        MVCBoardDTO dto = dao.selectView(idx);
        
        List<CommentDTO> comments = dao.getCommentsByBoardId(Integer.parseInt(idx));
        dao.close();

        // 줄바꿈 처리 : 웹브라우저에서 출력할때는 <br>태그로 변경해야한다. 
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
        
        req.setAttribute("dto", dto);
        req.setAttribute("comments", comments);
        req.getRequestDispatcher("/QnABoard/View.jsp")
        	.forward(req, resp);
    }
        
}







/*
        //첨부파일 확장자 추출 및 이미지 타입 확인
        String ext = null, fileName = dto.getSfile();
        if(fileName!=null) {
        	ext = fileName.substring(fileName.lastIndexOf(".")+1);
        }
        String[] mimeStr = {"png","jpg","gif"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;
        if(ext!=null && mimeList.contains(ext.toLowerCase())) {
        	isImage = true;
        }
        
         
		req.setAttribute("isImage", isImage);
*/
