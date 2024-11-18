package model2.mvcboard;

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
@WebServlet("/mvcboard/view.do")
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
        dao.updateVisitCount(idx);
        //일련번호에 해당하는 게시물 인출 
        MVCBoardDTO dto = dao.selectView(idx);
        dao.close();

        // 줄바꿈 처리 : 웹브라우저에서 출력할때는 <br>태그로 변경해야한다. 
        dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
        
        
        //첨부파일 확장자 추출 및 이미지 타입 확인
        String ext = null, fileName = dto.getSfile(), mimeType = null;
        if(fileName!=null) {
        	ext = fileName.substring(fileName.lastIndexOf(".")+1);
        }
        
        String[] extArray1 = {"png","jpg","gif","pcx","bmp"};
        String[] extArray2 = {"mp3","wav"};
        String[] extArray3 = {"mp4","avi","wmv"};
        
        if(mimeContains(extArray1, ext)) {
        	mimeType = "img";
        }
        else if(mimeContains(extArray2, ext)) {
        	mimeType = "audio";
        }
        else if(mimeContains(extArray3, ext)) {
        	mimeType = "video";
        } 
        System.out.println("MIME타입="+ mimeType);
        req.setAttribute("mimeType", mimeType);
        
                
        // 게시물(dto) 저장 후 뷰로 포워드
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/14MVCBoard/View.jsp")
        	.forward(req, resp);
    }
    
    public boolean mimeContains(String[] strArr, String ext) {
    	boolean retValue = false; 
    	for(String s : strArr) {
    		if(s.equalsIgnoreCase(ext))
    			retValue = true;
		}
    	return retValue;
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
