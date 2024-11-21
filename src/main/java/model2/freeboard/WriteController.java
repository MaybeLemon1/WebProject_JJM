package model2.freeboard;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CheckAuth;
import utils.JSFunction;


public class WriteController extends HttpServlet {
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
		
        req.getRequestDispatcher("/FreeBoard/Write.jsp")
        	.forward(req, resp);
    }

	
    @Override
    protected void doPost(HttpServletRequest req, 
    		HttpServletResponse resp)
    				throws ServletException, IOException {
    	req.setCharacterEncoding("UTF-8");
    	
    	//로그인 확인
    	HttpSession session = req.getSession();
		if(session.getAttribute("UserId")==null) {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../Form/LoginForm.jsp");
			return;
		}	

        // 폼값을 DTO에 저장
        MVCBoardDTO dto = new MVCBoardDTO(); 
        dto.setId(session.getAttribute("UserId").toString());
        System.out.println(session.getAttribute("UserId").toString());
        System.out.println(req.getParameter("title"));
        System.out.println(req.getParameter("content"));
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        

        // DAO를 통해 DB에 게시 내용 저장
        MVCBoardDAO dao = new MVCBoardDAO();
        int result = dao.insertWrite(dto);
        dao.close();

        // 성공 or 실패?
        if (result == 1) {  // 글쓰기 성공
            resp.sendRedirect("../freeboard/listPage.do");
        }
        else {  // 글쓰기 실패
        	 JSFunction.alertLocation(resp, "글쓰기에 실패했습니다.",
                     "../freeboard/write.do");
        }
    }
}









