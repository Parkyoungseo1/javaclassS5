package com.spring.javaclassS5.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.FlavorReplyVO;
import com.spring.javaclassS5.vo.FlavorVO;
import com.spring.javaclassS5.vo.UserboardReplyVO;
import com.spring.javaclassS5.vo.UserboardVO;

public interface FlavorDAO {

	public ArrayList<FlavorVO> getFlavorList();

	public int setFlavorInput(@Param("vo") FlavorVO vo);

	public FlavorVO getFlavorContent(@Param("idx") int idx);

	public int totRecCnt();

	public ArrayList<FlavorVO> getFlavorList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public FlavorVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str);

	public int setFlavorUpdate(@Param("vo") FlavorVO vo);

	public int setFlavorDelete(@Param("idx") int idx);

	public FlavorReplyVO getFlavorParentReplyCheck(@Param("flavorIdx") int flavorIdx);

	public int setFlavorReplyInput(@Param("replyVO") FlavorReplyVO replyVO);

	public List<FlavorReplyVO> getFlavorReply(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("flavorIdx") int flavorIdx, @Param("re_order") int re_order);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<FlavorVO> getFlavorSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int totRecCnt(@Param("part") String part);

	public int setFlavorReplyDelete(int idx);

	public int setFlavorComplaintInput(int idx);
	
}
