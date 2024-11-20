package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckAuth {

	public static String getSessionId(HttpServletRequest req, HttpServletResponse resp) {
		String userId = "";
		HttpSession session = req.getSession();		
		if(session.getAttribute("UserId")!=null) {
			userId = session.getAttribute("UserId").toString();
		}
		return userId;
	}
}
