package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS5.vo.UserboardReplyVO;
import com.spring.javaclassS5.vo.UserboardVO;

public interface UserboardService {

	public ArrayList<UserboardVO> getUserboardList();

	public int setUserboardInput(UserboardVO vo);

	public UserboardVO getUserboardContent(int idx);

	public ArrayList<UserboardVO> getUserboardList(int startIndexNo, int pageSize, String part);

	public void setReadNumPlus(int idx);

	public UserboardVO getPreNexSearch(int idx, String str);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setUserboardUpdate(UserboardVO vo);

	public int setUserboardDelete(int idx);
	
	public UserboardReplyVO getUserboardParentReplyCheck(int userboardIdx);

	public int setUserboardReplyInput(UserboardReplyVO replyVO);

	public List<UserboardReplyVO> getUserboardReply(int idx);

	public void setReplyOrderUpdate(int userboardIdx, int re_order);

	public List<UserboardVO> getUserboardSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public int setUserboardReplyDelete(int idx);

	public int setUserboardComplaintInput(int idx);

	public List<UserboardVO> getComplaintList();

	public int getUserboardCount();



}
