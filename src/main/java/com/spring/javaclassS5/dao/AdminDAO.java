package com.spring.javaclassS5.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.AdminVO;
import com.spring.javaclassS5.vo.AlcoholVO;
import com.spring.javaclassS5.vo.MemberVO;

public interface AdminDAO {

	public int getMemberTotRecCnt(@Param("level") int level);

	//public ArrayList<GuestVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int levelSelect);

	public int setMemberDeleteOk(@Param("idx") int idx);

	public int setUserboardComplaintInput(@Param("vo") AdminVO vo);

	public ArrayList<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public ArrayList<AlcoholVO> getAlcoholList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

}
