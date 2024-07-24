package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class PageVO {
	private int pag;
	private int pageSize;
	private int totRecCnt;
	private int totPage;
	private int startIndexNo;
	private int curScrStartNo;
	private int blockSize;
	private int curBlock;
	private int lastBlock;
	
	private String searh;
	private String searchString;
	private String part;
}
