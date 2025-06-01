
-- 멤버 테이블
create table member (
    user_id varchar2(20) primary key,
    user_pwd varchar2(100) not null,
    user_name varchar(20) not null,
    user_email varchar(50) not null,
    user_phone varchar(20) not null
);

-- 게시판 기본키 시퀀스
create sequence seq_board_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
-- 파일첨부형 게시판 테이블
create table libraryboard (
	idx number primary key, 
	user_id varchar2(30) not null,
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 
	ofile varchar2(200), 
	sfile varchar2(30), 
	downcount number(5) default 0 not null, 	
	visitcount number default 0 not null
);

alter table libraryboard
    add constraint board_mem_fk foreign key (user_id)
    references member (user_id);

-- 자유게시판 테이블
create table freeboard (
	idx number primary key, 
	user_id varchar2(30) not null,
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 	
	visitcount number default 0 not null
);

alter table freeboard
    add constraint board_mem_fk2 foreign key (user_id)
    references member (user_id);


-- Q&A 게시판
create table qnaboard (
	idx number primary key, 
	user_id varchar2(30) not null,
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 	
	visitcount number default 0 not null
);

alter table qnaboard
	add constraint qnaboard_user_fk foreign key (user_id)
	references member(user_id);

-- Q&A 댓글 기본키 시퀀스
create sequence seq_qnacomment_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

-- Q&A 댓글
CREATE TABLE qnacomment (
    comment_id NUMBER PRIMARY KEY,
    idx NUMBER NOT NULL,            
    user_id VARCHAR2(30) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    postdate DATE DEFAULT SYSDATE NOT NULL,
    FOREIGN KEY (idx) REFERENCES qnaboard(idx)
);
