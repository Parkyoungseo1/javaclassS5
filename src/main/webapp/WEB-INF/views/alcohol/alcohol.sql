show tables;

create table alcohol (
	idx int not null auto_increment,		/* 게시글의 고유번호 */
	mid varchar(20) not null,						/* 게시글 올린이 아이디 */
	title varchar(100) not null,				/* 게시글 제목 */
	content text not null,							/* 글 내용 */
	price   int not null,								/* 가격 */
	readNum int default 0,							/* 글 조회수 */
	wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  part  varchar(20) not null,					
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member(mid)
);

desc alcohol;