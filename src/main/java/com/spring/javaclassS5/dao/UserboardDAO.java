package com.spring.javaclassS5.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.UserboardReplyVO;
import com.spring.javaclassS5.vo.UserboardVO;

public interface UserboardDAO {

	public ArrayList<UserboardVO> getUserboardList();

	public int setUserboardInput(@Param("vo") UserboardVO vo);

	public UserboardVO getUserboardContent(@Param("idx") int idx);

	public int totRecCnt();

	public ArrayList<UserboardVO> getUserboardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setReadNumPlus(@Param("idx") int idx);

	public UserboardVO getPreNexSearch(@Param("idx") int idx, @Param("str") String str);

	public int setUserboardUpdate(@Param("vo") UserboardVO vo);

	public int setUserboardDelete(@Param("idx") int idx);

	public UserboardReplyVO getUserboardParentReplyCheck(@Param("userboardIdx") int userboardIdx);

	public int setUserboardReplyInput(@Param("replyVO") UserboardReplyVO replyVO);

	public List<UserboardReplyVO> getUserboardReply(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("userboardIdx") int userboardIdx, @Param("re_order") int re_order);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<UserboardVO> getUserboardSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int totRecCnt(@Param("part") String part);

	public int setUserboardReplyDelete(int idx);

	public int setUserboardComplaintInput(int idx);
	
}
