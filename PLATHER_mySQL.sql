CREATE DATABASE plather; -- db 생성
CREATE USER plather@localhost; -- 사용자 생성

GRANT all privileges on  *.* TO plather@localhost; -- 권한부여
ALTER USER 'plather'@'localhost'
identified WITH mysql_native_password BY '12345';
flush privileges;
----------------------------------------------------------------
use plather;
------------------------------------------------------------------
/* DROP TABLE*/
-------------------------------------------------------------------
drop table tbl_board;
drop table tbl_song;
drop table tbl_member;
drop table tbl_comment;
drop table tbl_notice;
drop table tbl_like;

------------------------------------------------------------------
/* SELECT TABLE*/
-------------------------------------------------------------------
select * from tbl_board;
select * from tbl_song;
select * from tbl_member;
select * from tbl_like;
select * from tbl_comment;

------------------------------------------------------------------
/* CREATE TABLE*/
-------------------------------------------------------------------
create table tbl_board(
b_code	bigint	auto_increment	PRIMARY KEY, 
b_title	VARCHAR(125)	NOT NUll	,
b_content	VARCHAR(4000)	NOT NUll,	
b_date	timestamp default now(),
b_moddate timestamp default current_timestamp on update now(), -- 수정 날짜 
b_id	VARCHAR(125)	NOT NUll	, -- membercode
b_nick varchar(20) NOT NUll,
b_hit	INT default 0,
b_like	INT default 0	);


create table tbl_song(
s_seq bigint auto_increment primary key,
s_bcode bigint NOT NUll,
s_title varchar(125) NOT NUll,
s_singer varchar(125) NOT NUll);


CREATE table tbl_notice (
	n_code	CHAR(5)		PRIMARY KEY,
	n_title	VARCHAR(125)	NOT NULL,	
	n_content	VARCHAR(4000)	NOT NULL,	
	n_date	CHAR(10)	NOT NULL,	
	n_time	CHAR(8)	NOT NULL,	
	n_id	VARCHAR(125) NOT NULL default 'master',	
	n_hit	INT	 default '0'
);
CREATE table tbl_member(
	
	m_id	VARCHAR(125) primary key,	
	m_pw	VARCHAR(50)	NOT NULL,	
	m_nickname	VARCHAR(20)	NOT NULL,	
	m_birth	CHAR(10) NOT NUll,		
	m_name	VARCHAR(125) NOT NUll,		
	m_gender	CHAR(1) NOT NUll,		
	m_level	INT	NOT NULL default 0,	
	m_profile	INT	NOT NUll	
);


CREATE TABLE tbl_comment(
	c_seq	BIGINT	AUTO_INCREMENT	PRIMARY KEY,
	c_bcode	bigint NOT NUll,
	c_id	VARCHAR(125)	NOT NULL,	
	c_comment	VARCHAR(500) NOT NUll,
  c_date CHAR(10) NOT NUll,
	c_title varchar(125) ,
	c_singer varchar(125)
);

create table tbl_like(
l_seq bigint auto_increment primary key,
l_id VARCHAR(125)	NOT NUll,
l_bcode bigint NOT NUll,
l_likecheck int default 0
);
------------------------------------------------------------------
/* CREATE VIEW*/
-------------------------------------------------------------------
-- create view view_myboard as(
-- SELECT  M.m_id as m_id , M.m_pw as m_pw, M.m_nickname as m_nickname,M.m_birth as m_birth, M.m_name as m_name,
--  M.m_gender as m_gender , M.m_level as m_level, M.m_profile as m_profile,
-- B.b_code as b_code , B.b_title as b_title, B.b_nick as b_nick,B.b_date as b_date, B.b_moddate as b_moddate, B.b_hit as b_hit
-- FROM tbl_member M 
-- LEFT JOIN tbl_board B
-- ON M.m_id = B.b_id);

DROP VIEW view_clist;
CREATE VIEW view_clist AS
(
SELECT
	C.c_seq AS c_seq,
    C.c_bcode AS c_bcode,
	C.c_id AS c_id,
	M.m_profile  AS c_profile,
    M.m_nickname  AS c_nickname,
	C.c_comment AS c_comment,
	C.c_date AS c_date,
	C.c_title AS c_title,
	C.c_singer AS c_singer
FROM tbl_comment C
LEFT JOIN tbl_member M
			ON M.m_id = C.c_id
            );
            
CREATE VIEW view_nlist AS
(
	SELECT
		 N.n_code AS n_code,
         M.m_nickname  AS n_nickname,
         N.n_title  AS n_title,
         N.n_content AS n_content,
         N.n_date AS n_date,
         N.n_time AS n_time,
         N.n_hit AS n_hit
    FROM tbl_notice N
		LEFT JOIN tbl_member M
			ON M.m_id = N.n_id
);

---------------------------------------------------------------------------------------------------------------------------------
-- FK  등 제약조건 지정
----------------------------------------------------------------------------------------------------------------------------------
-- tbl_member 와 tbl_board / tbl_comment / tbl_like (1:N)  제약조건 설정
---------------------------------------------------------------------------
ALTER TABLE tbl_board 
ADD CONSTRAINT fk_b_id
FOREIGN KEY (b_id)
REFERENCES tbl_member(m_id)
ON DELETE CASCADE;

ALTER TABLE tbl_comment
ADD CONSTRAINT fk_c_id
FOREIGN KEY (c_id)
REFERENCES tbl_member(m_id)
ON DELETE CASCADE;

ALTER TABLE tbl_like 
ADD CONSTRAINT fk_l_id
FOREIGN KEY (l_id)
REFERENCES tbl_member(m_id)
ON DELETE CASCADE;

---------------------------------------------------------------------------------------
-- tbl_board 와 tbl_comment / tbl_like / tbl_song (1 : N) 제약조건 설정
--------------------------------------------------------------------------------------
ALTER TABLE tbl_comment
ADD CONSTRAINT fk_c_bcode
FOREIGN KEY (c_bcode)
REFERENCES tbl_board(b_code)
ON DELETE CASCADE;

ALTER TABLE tbl_song
ADD CONSTRAINT fk_s_bcode
FOREIGN KEY (s_bcode)
REFERENCES tbl_board(b_code)
ON DELETE CASCADE;

ALTER TABLE tbl_like
ADD CONSTRAINT fk_l_bcode
FOREIGN KEY (l_bcode)
REFERENCES tbl_board(b_code)
ON DELETE CASCADE;

---------------------------------------------------------------------------------------
-- fk delete
--------------------------------------------------------------------------------------

alter table tbl_board drop foreign key fk_b_id;

alter table tbl_comment drop foreign key fk_c_id;

alter table tbl_like drop foreign key fk_l_id;

alter table tbl_comment drop foreign key fk_c_bcode;

alter table tbl_song drop foreign key fk_s_bcode;

alter table tbl_like drop foreign key fk_l_bcode;


