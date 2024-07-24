package com.spring.javaclassS5.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.AlcoholVO;

public interface AlcoholDAO {

	public ArrayList<AlcoholVO> getAlcoholList();

	public int setAlcoholInput(@Param("vo") AlcoholVO vo);

	public AlcoholVO getAlcoholContent(@Param("idx") int idx);

	public int totRecCnt(@Param("part") String part);

	public ArrayList<AlcoholVO> getAlcoholList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public AlcoholVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str);

	public int setAlcoholUpdate(@Param("vo") AlcoholVO vo);

	public int setAlcoholDelete(@Param("idx") int idx);

	public int totRecCntSearch(@Param("part") String part, @Param("searchString") String searchString);

	public List<AlcoholVO> getAlcoholSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);
	
}
