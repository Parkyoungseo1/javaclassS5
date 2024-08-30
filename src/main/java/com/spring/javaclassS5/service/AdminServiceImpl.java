package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.javaclassS5.dao.AdminDAO;
import com.spring.javaclassS5.vo.AdminVO;
import com.spring.javaclassS5.vo.AlcoholVO;
import com.spring.javaclassS5.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int getMemberTotRecCnt(int level) {
		return adminDAO.getMemberTotRecCnt(level);
	}

//	@Override
//	public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level) {
//		return adminDAO.getMemberList(startIndexNo, pageSize, level);
//	}

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public String setLevelSelectCheck(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDAO.setMemberLevelCheck(Integer.parseInt(idx), levelSelect);
			str = "1";
		}
		return str;
	}

	@Override
	public int setMemberDeleteOk(int idx) {
		return adminDAO.setMemberDeleteOk(idx);
	}

	@Override
	public int setUserboardComplaintInput(AdminVO vo) {
		return adminDAO.setUserboardComplaintInput(vo);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public ArrayList<AlcoholVO> getAlcoholList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getAlcoholList(startIndexNo, pageSize, level);
	}

	@Override
	public int setflavorComplaintInput(AdminVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int setUserComplaint(int idx) {
		return adminDAO.setUserComplaint(idx);
	}

	@Override
	public List<AdminVO> getComplaintList(int startIndexNo, int pageSize, String part) {
		return adminDAO.getComplaintList(startIndexNo, pageSize, part);
	}


	
	
}
