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
values (seq_board.nextval, '�׽�Ʈ ����', '�׽�Ʈ ����', 'user00');

insert into tbl_board (bno, title, content, writer)
values (1, '������ �׽�Ʈ', '����', 'oh e t');

-- 2��° ������
select rn,bno,title,content
from
(select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where ROWNUM <= 20)
where rn >10;

-- rownum�� �ݵ�� 1�� ���ԵǾ�� �Ѵ�.
select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where ROWNUM <= 20;

-- �ƹ� ����� ������ �ʴ´�.
select /*+ Index_desc(tbl_board pk_board)*/
rownum rn, bno, title, content from tbl_board where rownum >10 and ROWNUM <= 20;

-- 10���� ���������
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
--��� ���縦 ���ؼ� �������� ������ �ø���. �ݺ��ؼ� ���� �� ����
insert into tbl_board(bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select * from TBL_BOARD order by bno;

select * from TBL_BOARD order by bno+1 desc;

select * from tbl_board order by bno desc;

-- index�� ����ؼ� ���ľ��� ����� ������ �Ҽ��ִ�.
select /*+index_desc(tbl_board pk_board)*/
* from tbl_board;

select /*+index_asc(tbl_board pk_board)*/
* from tbl_board where bno >0;

--FULL ��Ʈ
select /*+ FULL(tbl_board)*/
* from tbl_board order by bno desc;

select * from TBL_BOARD;

select bno, title, content, writer, regdate, updatedate from (select /*+index_desc(tbl_board pk_board) */
  		rownum rn, bno, title, content, writer, regdate, updatedate from tbl_board where rownum <= 20)
  		where rn > 10;
        
commit;