package model2.freeboard;

import java.io.IOException;

import fileupload.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.JSFunction;

@WebServlet("/freeboard/edit.do")
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest req, 
    		HttpServletResponse resp)
    				throws ServletException, IOException {
    	//로그인 확인
    	HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../Form/LoginForm.jsp");
			return;
		}
		
		//게시물 얻어오기
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectView(idx);
		
		//작성자 본인 확인
		if(!dto.getId().equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다.");
			return;
		}
		
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/FreeBoard/Edit.jsp")
        	.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, 
    		HttpServletResponse resp)
    			throws ServletException, IOException {
    	//로그인 확인
    	HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../Form/LoginForm.jsp");
			return;
		}	
		
		//작성자 본인 확인
		if(!req.getParameter("id").equals(session.getAttribute("UserId")
				.toString())) {
			JSFunction.alertBack(resp, "작성자 본인만 수정할 수 있습니다.");
			return;
		}
	

        // 2. 파일 업로드 외 처리 =============================
        // 수정 내용을 매개변수에서 얻어옴
        String idx = req.getParameter("idx");

        String title = req.getParameter("title");
        String content = req.getParameter("content");            

        // DTO에 저장
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setIdx(idx);
        dto.setId(session.getAttribute("UserId").toString());
        dto.setTitle(title);
        dto.setContent(content);


        // DB에 수정 내용 반영
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.updatePost(dto);
        dao.close();

        // 성공 or 실패?
        if (result == 1) {  // 수정 성공
            resp.sendRedirect("../freeboard/view.do?idx=" + idx);
        }
        else {  // 수정 실패
            JSFunction.alertLocation(resp, "비밀번호 검증을 다시 진행해주세요.",
                "../freeboard/view.do?idx=" + idx);
        }
    }
}



