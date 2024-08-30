package com.spring.javaclassS5.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.WebChattingVO;

public interface HomeDAO {

	public int setMsgInput(@Param("vo") WebChattingVO vo);

}
