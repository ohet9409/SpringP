-- 댓글수 컬럼 추가
alter TABLE TBL_BOARD add (replycnt number default 0);

-- 댓글 수를 테이블에 추가
update tbl_board set replycnt = (select count(rno) from TBL_REPLY where tbl_reply.bno = tbl_board.bno);

commit;
-- 트랜잭션의 실습
create table tbl_sample1(
    col1 varchar2(500)
);
create table tbl_sample2(
    col2 varchar2(50)
);

select * from TBL_SAMPLE1;
select * from TBL_SAMPLE2;
delete TBL_SAMPLE1;
delete TBL_SAMPLE2;

select * from TBL_BOARD order by bno desc;
create table tbl_attach(
    uuid VARCHAR2(100) not null,
    uploadPath varchar2(200) not null,
    fileName varchar2(100) not null,
    filetype char(1) default 'I',
    bno number(10,0)
);
insert into tbl_attach (uuid, uploadPath, fileName, fileType, bno)
		values ('2', 'a', '56', 'I', 5);
        
alter table tbl_attach add constraint pk_attach primary key(uuid);
alter table tbl_attach add constraint fk_board_attach foreign key(bno) REFERENCES tbl_board(bno);
select * from tbl_attach;

create index idx_reply on tbl_reply (bno desc, rno asc);
select rno, bno, reply, replyer, replydate, updatedate from(
select /*+index(tbl_reply idx_reply)*/
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply where bno = 1 and rno >0 and rownum <=20)
where rn >10;
--
--재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행
insert into tbl_reply(rno, bno, reply, replyer)
(select seq_reply.nextval, bno, reply, replyer from tbl_reply);
--
select /*+index(tbl_reply idx_reply*/
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply
where bno = 1
and rno > 0;
select rno, bno, reply, replyer, replyDate, updatedate from tbl_reply where bno = 18 order by rno asc;
select * from tbl_reply order by rno desc;
commit;
select * from tbl_board where rownum < 10 order by bno desc;
create SEQUENCE seq_reply;
create table tbl_reply(
    rno NUMBER(10,0),
    bno number(10,0) not null,
    reply varchar2(1000)not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date DEFAULT sysdate
);
alter table tbl_reply add constraint pk_reply primary key (rno);
alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board(bno);

create index idx_reply on tbl_reply (bno desc, rno asc);
select rno, bno, reply, replyer, replydate, updatedate from(
select /*+index(tbl_reply idx_reply)*/
rownum rn, bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply where bno = 18 and rno >0 and rownum <=20)
where rn >10;
select rno, bno, reply, replyer, replyDate, updatedate from tbl_reply where bno = 18 order by rno asc;
select * from tbl_reply order by rno desc;
commit;
select * from tbl_board where rownum < 10 order by bno desc;
drop SEQUENCE seq_reply;
drop table tbl_reply cascade CONSTRAINTS;
create SEQUENCE seq_reply;
create table tbl_reply(
    rno NUMBER(10,0),
    bno number(10,0) not null,
    reply varchar2(1000)not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date DEFAULT sysdate
);
alter table tbl_reply add constraint pk_reply primary key (rno);
alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board(bno);
------------------------------------------- 게시물
SELECT DBMS_XDB.GETHTTPPORT() from dual;
drop SEQUENCE seq_board;
drop table tbl_board cascade CONSTRAINTS;
create SEQUENCE seq_board;
create table tbl_board(
    bno number(10,0),
    title varchar2(200)not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date DEFAULT sysdate
);
alter TABLE tbl_board add constraint pk_board
primary key (bno);

insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '테스트 제목', '테스트 내용', 'user00');

insert into tbl_board (bno, title, content, writer)
values (1, '스프링 테스트', '시작', 'oh e t');

-- 2번째 페이지
select rn,bno,title,content
from
(select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where ROWNUM <= 20)
where rn >10;

-- rownum은 반드시 1이 포함되어야 한다.
select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where ROWNUM <= 20;

-- 아무 결과가 나오지 않는다.
select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where rownum >10 and ROWNUM <= 20;

-- 10개의 데이터출력
select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where rownum <=10;

select /*+ Index_asc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board;

select /*+ FULL(tbl_board)*/
rownum rn, bno, title from tbl_board where bno>0
order by bno;

select rownum rn, bno, title from tbl_board;

select * from tbl_board where bno =165;
select
/*+ index_desc(tbl_board pk_board)*/
* from tbl_board where bno >0;
rollback;
--재귀 복사를 통해서 데이터의 개수를 늘린다. 반복해서 여러 번 실행
insert into tbl_board(bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select * from TBL_BOARD order by bno;

select * from TBL_BOARD order by bno+1 desc;

select * from tbl_board order by bno desc;

-- index를 사용해서 정렬없이 출력을 빠르게 할수있다.
select /*+index_desc(tbl_board pk_board)*/
* from tbl_board where bno > 0;

select /*+index_asc(tbl_board pk_board)*/
* from tbl_board where bno >0;

--FULL 힌트
select /*+ FULL(tbl_board)*/
* from tbl_board order by bno desc;

select * from TBL_BOARD;

select bno, title, content, writer, regdate, updatedate from (select /*+index_desc(tbl_board pk_board) */
  		rownum rn, bno, title, content, writer, regdate, updatedate from tbl_board where rownum <= 20)
  		where rn > 10;
        
commit;