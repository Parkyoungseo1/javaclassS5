show tables;

create table flavor (
	idx int not null auto_increment,		
	mid varchar(20) not null,		
	nickName varchar(20) not null,
	title varchar(100) not null,				
  part  varchar(20) not null,		
	content text not null,															
	readNum int default 0,	
	hostIp  varchar(40) not null,
	openSw	char(2)  default 'OK',
	wDate		datetime default now(),			
  good		int default 0,
  complaint char(2) default 'NO',
  thumbnail varchar(100) not null,
  primary key(idx),										
  foreign key(mid) references member(mid)
);

create table flavorReply (
  idx       int not null auto_increment,	
  flavorIdx  int not null,						
  re_step   int not null, 					
  re_order	int not null,						
  mid				varchar(20) not null,		
  nickName	varchar(20) not null,		
  wDate			datetime	default now(),
  hostIp		varchar(50) not null,		
  content		text not null,				
  primary key(idx),
  foreign key(flavorIdx) references flavor(idx)
);
