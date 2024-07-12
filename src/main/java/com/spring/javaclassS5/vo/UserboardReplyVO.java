package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class UserboardReplyVO {
	private int idx;
	private int userboardIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String wDate;
	private String hostIp;
	private String content;
}
