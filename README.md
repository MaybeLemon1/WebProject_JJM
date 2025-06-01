# 📌 회원제 게시판 프로젝트 (JSP / Servlet)

> JSP와 Servlet을 기반으로 구현한 커뮤니티 웹사이트입니다.  
> **회원가입, 로그인, 게시판, 댓글, 파일 업로드(자료실)** 등 웹 서비스에서 자주 사용되는 핵심 기능을 직접 설계하고 구현하였습니다.  
> 프레임워크 없이 HTTP 요청/응답 흐름, 세션/쿠키 관리, 파일 업로드 등 웹 애플리케이션의 핵심 동작 원리를 이해하고자 한 프로젝트입니다.
---

## 💻 개발 기간

- **2024.11.14 ~ 2024.11.21 (7일)**
---

## 🛠 개발 환경

- ☕ **언어**: Java  
- 📦 **JDK 버전**: Java SE 21  
- 🖥️ **개발 도구(IDE)**: Eclipse IDE for Enterprise Java (JEE 2024-09)  
- 🎨 **프론트엔드**: JSP  
- 🔧 **백엔드**: Servlet  
- 🗄️ **데이터베이스**: Oracle DB 11xe  
- 🚀 **서버**: Apache Tomcat 10.1  

---

| 기능명 | 설명 |
|--------|------|
| 🔐 로그인 | 세션 관리 + 아이디 저장(쿠키 사용) |
| 🆕 회원가입 | 아이디 중복 체크, 비밀번호 확인, 이메일 형식 검증 |
| ✏️ 회원정보 수정 | 아이디/이름 제외 정보 수정 가능 |
| 📝 자유게시판 | 회원만 글 작성 가능, 게시글 리스트/내용 보기 |
| 💬 Q&A 게시판 | 게시글 + 댓글 기능 구현 |
| 📎 자료실 | 파일 첨부 기능 (파일 업로드 구현) |
---

## 📸 구현 화면

<details>
	<summary>🔐 로그인</summary>

  ![로그인](images/userLogin.png)
</details>

<details>
	<summary>🆕 회원가입</summary>
  
  ![회원가입](images/signUp.png)
</details>

<details>
	<summary>✍️ 회원정보 수정</summary>
  
  ![회원정보 수정](images/userEdit.png)
</details>

<details>
	<summary>📝 자유게시판</summary>
  
  ![자유게시판 리스트](images/freeboardList.png)
  ![자유게시판 내용](images/freeboardView.png)
</details>

<details>
	<summary>💬 Q&A 게시판</summary>
  
  ![Q&A 게시판](images/qnaboardView.png)
</details>

<details>
	<summary>📎 자료실</summary>

  ![자료실 글쓰기](images/libraryWrite.png)
  ![자료실 내용](images/libraryView.png)
</details>

---

## 🗂 ERD 
<details>
	<summary>🗂 ERD</summary>
	
  ![ERD](images/WebProject_JJM_ERD.png)
</details>


