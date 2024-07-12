package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class UserboardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String part;
	private String content;
	private int readNum;
	private String hostIp;
	private String openSw;
	private String wDate;
	private int good;
	private String complaint;
	
	private int hour_diff;	// 게시글을 24시간 경과유무 체크변수
	private int date_diff;	// 게시글을 일자 경과유무 체크변수
	private int replyCnt;
}
