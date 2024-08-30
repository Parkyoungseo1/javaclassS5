package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS5.vo.AdminVO;
import com.spring.javaclassS5.vo.AlcoholVO;
import com.spring.javaclassS5.vo.MemberVO;

public interface AdminService {

	public int getMemberTotRecCnt(int level);

	//public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level);

	public int setMemberLevelCheck(int idx, int level);

	public String setLevelSelectCheck(String idxSelectArray, int levelSelect);

	public int setMemberDeleteOk(int idx);

	public int setUserboardComplaintInput(AdminVO vo);

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	public ArrayList<AlcoholVO> getAlcoholList(int startIndexNo, int pageSize, int level);

	public int setflavorComplaintInput(AdminVO vo);

	public int setUserComplaint(int idx);

	public List<AdminVO> getComplaintList(int startIndexNo, int pageSize, String part);



}
