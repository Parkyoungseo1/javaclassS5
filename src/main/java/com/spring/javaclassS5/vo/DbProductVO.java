package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class DbProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private int mainPrice;
	private String fSName;
	private String content;
	private String categoryMainCode;
	private String categoryMainName;
}
