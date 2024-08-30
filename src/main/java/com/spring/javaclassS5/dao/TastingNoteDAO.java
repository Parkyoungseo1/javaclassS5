package com.spring.javaclassS5.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS5.vo.TastingNoteVO;

public interface TastingNoteDAO {

	public int tastingNoteInput(@Param("vo") TastingNoteVO vo);

	public List<TastingNoteVO> getTastingNoteList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("choice") String choice);

	public void setTastingNoteReadNumPlus(@Param("idx") int idx);

	public TastingNoteVO getTastingNoteIdxSearch(@Param("idx") int idx);

	public ArrayList<TastingNoteVO> getTastingNoteReply(@Param("idx") int idx);

	public int setTastingNoteReplyInput(@Param("vo") TastingNoteVO vo);

	public int setTastingNoteReplyDelete(@Param("idx") int idx);

	public void setTastingNoteGoodPlus(@Param("idx") int idx);

	public int setTastingNoteDelete(@Param("idx") int idx);

	public int[] getTastingNoteIdxList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public TastingNoteVO setTastingNoteSingle(@Param("idx") int idx);

	public int getTastingNoteCount();

}
