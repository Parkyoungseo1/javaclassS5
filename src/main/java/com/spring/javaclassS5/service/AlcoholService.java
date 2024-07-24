package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.vo.AlcoholVO;

public interface AlcoholService {

	public ArrayList<AlcoholVO> getAlcoholList();

	public int setAlcoholInput(AlcoholVO vo);

	public AlcoholVO getAlcoholContent(int idx);

	public ArrayList<AlcoholVO> getAlcoholList(int startIndexNo, int pageSize, String part);

	public void setReadNumPlus(int idx);

	public AlcoholVO getPreNexSearch(int idx, String str);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setAlcoholUpdate(AlcoholVO vo);

	public int setAlcoholDelete(int idx);

	public List<AlcoholVO> getAlcoholSearchList(int startIndexNo, int pageSize, String search, String searchString);

	public String setThumbnailCreate(MultipartFile file);

}
