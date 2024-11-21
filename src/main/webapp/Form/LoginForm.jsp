<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%
	// 페이지에 진입하면 loginId라는 쿠키가 있는지 확인한다.
	String loginId = CookieManager.readCookie(request, "loginId");
	
	// 이미 생성된 쿠키가 있다면 체크박스가 체크된 상태로 페이지를 로드한다.
	String cookieCheck = "";
	if (!loginId.equals("")) {
		// 이를 위해 checked 속성값을 추가한다.
		cookieCheck = "checked";
	}
%>
<html>
<head><title>Session</title></head>
<body>

	<jsp:include page="../Main.jsp" />
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;">
	    <!-- 삼항연산자를 통해 조건 분기 --> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg") %>
    </span>
    
<%
/* session영역에 해당 속성값이 있는지 확인한다. 즉, session영역에
저장된 속성이 없다면 '로그아웃' 상태이므로 로그인 폼을 웹브라우저에 출력해야
한다. */
if (session.getAttribute("UserId") == null) { 
%>
    <script>
    /* 로그인 폼의 입력값을 서버로 전송하기전에 검증하기 위해 정의한 함수.
    입력값이 빈값인지 확인하여 경고창을 띄워준다. */
    function validateForm(form) {
    	/*
    	매개변수로 전달된 <form>태그의 DOM을 통해 하위태그인 <input>에 
    	접근할 수 있다. 접근시에는 name속성값을 사용하고, value는 입력된
    	값을 가리키게된다. 
    	*/
        if (!form.user_id.value) {
        	//입력된 값이 없다면 경고창을 띄우고..
            alert("아이디를 입력하세요.");
        	//입력을 위해 포커스를 이동하고..
            form.user_id.focus();
        	//submit 이벤트핸들러 쪽으로 false를 반환한다. 
            return false;
        	//그러면 서버로의 전송은 취소(중단)된다. 
        }
    	/* 빈값에 대한 체크는 !(부정연산자)와 아래의 방식 2가지를 모두
    	사용할 수 있다. */
        if (form.user_pw.value == "") {
            alert("패스워드를 입력하세요.");
            form.user_pw.focus();
            return false;
        }
    }
    </script>	
    <!--  
    로그인 폼에서 아이디, 비번을 입력한 후 submit버튼을 누르면 action에 
    설정된 경로로 폼값이 전송된다. 
    submit 버튼을 누를때 이벤트핸들러를 통해 Javascript 함수를 호출하게
    되는데 이때 전달되는 인수 this는 <form>태그의 DOM을 가리킨다. 
    -->
    <form action="LoginProcess.jsp" method="post" 
    	name="loginFrm" onsubmit="return validateForm(this);">
    	아이디 : <input type="text" name="user_id" value="<%= loginId%>" tabindex="1" /> 
		<input type="checkbox" name="save_check" value="Y" <%= cookieCheck%> tabindex="3" /> 
		아이디 저장하기
		<br />
        패스워드 : <input type="password" name="user_pwd" /><br />
        <input type="submit" value="로그인하기" />
    </form>
<%
} 
%>
</body>
</html>



