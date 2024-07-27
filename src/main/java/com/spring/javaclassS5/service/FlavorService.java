package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.vo.FlavorReplyVO;
import com.spring.javaclassS5.vo.FlavorVO;

public interface FlavorService {

	public ArrayList<FlavorVO> getFlavorList();

	public int setFlavorInput(FlavorVO vo);

	public FlavorVO getFlavorContent(int idx);

	public ArrayList<FlavorVO> getFlavorList(int startIndexNo, int pageSize, String part);

	public void setReadNumPlus(int idx);

	public FlavorVO getPreNexSearch(int idx, String str);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setFlavorUpdate(FlavorVO vo);

	public int setFlavorDelete(int idx);
	
	public FlavorReplyVO getFlavorParentReplyCheck(int flavorIdx);

	public int setFlavorReplyInput(FlavorReplyVO replyVO);

	public List<FlavorReplyVO> getFlavorReply(int idx);

	public void setReplyOrderUpdate(int flavorIdx, int re_order);

	public List<FlavorVO> getFlavorSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public int setFlavorReplyDelete(int idx);

	public int setFlavorComplaintInput(int idx);

	public String setThumbnailCreate(MultipartFile file);


}
