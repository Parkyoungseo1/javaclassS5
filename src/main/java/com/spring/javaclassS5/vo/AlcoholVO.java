package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class AlcoholVO {
	private int idx;
	private String mid;
	private String title;
	private String content;
	private int price;
	private int readNum;
	private String wDate;
	private int good;
	private String part;

	private String thumbnail; // 썸네일
	
	private int hour_diff;	// 게시글을 24시간 경과유무 체크변수
	private int date_diff;	// 게시글을 일자 경과유무 체크변수
	
}
