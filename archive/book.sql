alter table tbl_board add (replycnt number default 0);
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

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
-------------------------------------------
SELECT DBMS_XDB.GETHTTPPORT() from dual;
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

select * from TBL_BOARD;
select bno, title, content, writer, regdate, updatedate from (select /*+index_desc(tbl_board pk_board) */
  		rownum rn, bno, title, content, writer, regdate, updatedate from tbl_board where rownum <= 20)
  		where rn > 10;
        
commit;