package com.spring.javaclassS5.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS5.common.JavaclassProvide;
import com.spring.javaclassS5.pagination.PageProcess;
import com.spring.javaclassS5.service.TastingNoteService;
import com.spring.javaclassS5.vo.TastingNoteVO;

@Controller
@RequestMapping("/tastingNote")
public class TastingNoteController {
	
	@Autowired
	TastingNoteService tastingNoteService;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	// 사진 여러장 보기 List
	@RequestMapping(value = "/tastingNoteList", method = RequestMethod.GET)
	public String tastingNoteListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "tastingNote", part, choice);
		List<TastingNoteVO> vos = tastingNoteService.getTastingNoteList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		return "tastingNote/tastingNoteList";
	}
	
	// 사진 여러장보기에서, 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@RequestMapping(value = "/tastingNoteListPaging", method = RequestMethod.POST)
	public ModelAndView tastingNotePagingPost(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "tastingNote", part, choice);
		List<TastingNoteVO> vos = tastingNoteService.getTastingNoteList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		
		// ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("tastingNote/tastingNoteListPaging");
		return mv;
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기)
	@RequestMapping(value = "/tastingNoteSingle", method = RequestMethod.GET)
	public String tastingNoteSingleGet(Model modelModel, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<TastingNoteVO> vos = tastingNoteService.setTastingNoteSingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		return "tastingNote/tastingNoteSingle";
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기) - 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@RequestMapping(value = "/tastingNoteSinglePaging", method = RequestMethod.POST)
	public ModelAndView tastingNoteSinglePagingPost(Model modelModel, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
			) {
		int startIndexNo = (pag - 1) * pageSize;
		List<TastingNoteVO> vos = tastingNoteService.setTastingNoteSingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		
	  // ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("tastingNote/tastingNoteSinglePaging");
		return mv;
	}
	
	// 테이스팅 사진 등록하기 폼보기
	@RequestMapping(value = "/tastingNoteInput", method = RequestMethod.GET)
	public String tastingNoteInputGet() {
		return "tastingNote/tastingNoteInput";
	}
	
	// 테이스팅 사진 등록처리
	@RequestMapping(value = "/tastingNoteInput", method = RequestMethod.POST)
	public String tastingNoteInputPost(TastingNoteVO vo, HttpServletRequest request) {
		System.out.println("vo : " + vo);
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		int res = tastingNoteService.imgCheck(vo, realPath);
		if(res != 0) return "redirect:/message/tastingNoteInputOk";
		else return "redirect:/message/tastingNoteInputNo";
	}
	
	// 개별항목 상세보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/tastingNoteContent", method = RequestMethod.GET)
	public String tastingNoteContentGet(HttpSession session, int idx, Model model, HttpServletRequest request) {
		// 게시글 조회수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "tastingNote" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			tastingNoteService.setTastingNoteReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);

		// 조회자료 1건 담아서 내용보기로 보낼 준비
		TastingNoteVO vo = tastingNoteService.getTastingNoteIdxSearch(idx);
		model.addAttribute("vo", vo);
		
		// ckeditor의 사진정보만 뽑아서 넘겨주기(content화면에서 여러장의 사진을 보이고자 함)
		List<String> photoList = tastingNoteService.getTastingNotePhotoList(vo.getContent());
		request.setAttribute("photoList", photoList);
		
		// 댓글 처리
		ArrayList<TastingNoteVO> replyVos = tastingNoteService.getTastingNoteReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "tastingNote/tastingNoteContent";
	}

	// 댓글달기
	@ResponseBody
	@RequestMapping(value = "/tastingNoteReplyInput", method = RequestMethod.POST)
	public String tastingNoteReplyInputPost(TastingNoteVO vo) {
		return tastingNoteService.setTastingNoteReplyInput(vo) + "";
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/tastingNoteReplyDelete", method = RequestMethod.POST)
	public String tastingNoteReplyDeletePost(int idx) {
		return tastingNoteService.setTastingNoteReplyDelete(idx) + "";
	}
	
	// 좋아요수 증가
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/tastingNoteGoodCheck", method = RequestMethod.POST)
	public String tastingNoteGoodCheckPost(HttpSession session, int idx) {
		String res = "0";
		// 좋아요 클릭수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "tastingNote" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			tastingNoteService.setTastingNoteGoodPlus(idx);
			contentReadNum.add(imsiContentReadNum);
			res = "1";
		}
		session.setAttribute("sContentGood", contentReadNum);
		return res;
	}

	// 내용 삭제하기
	@RequestMapping(value = "/tastingNoteDelete", method = RequestMethod.GET)
	public String tastingNoteDeleteGet(int idx) {
		tastingNoteService.setTastingNoteDelete(idx);

		return "redirect:/message/tastingNoteDeleteOk";
	  
	}

	
}
