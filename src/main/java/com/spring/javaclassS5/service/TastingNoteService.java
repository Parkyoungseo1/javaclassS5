package com.spring.javaclassS5.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS5.vo.TastingNoteVO;

public interface TastingNoteService {

	public int imgCheck(TastingNoteVO vo, String realPath);

	public List<TastingNoteVO> getTastingNoteList(int startIndexNo, int pageSize, String part, String choice);

	public void setTastingNoteReadNumPlus(int idx);

	public TastingNoteVO getTastingNoteIdxSearch(int idx);

	public ArrayList<TastingNoteVO> getTastingNoteReply(int idx);

	public List<String> getTastingNotePhotoList(String content);

	public int setTastingNoteReplyInput(TastingNoteVO vo);

	public int setTastingNoteReplyDelete(int idx);

	public void setTastingNoteGoodPlus(int idx);

	public int setTastingNoteDelete(int idx);

	public List<TastingNoteVO> setTastingNoteSingle(int startIndexNo, int pageSize);

	public int getTastingNoteCount();

}
