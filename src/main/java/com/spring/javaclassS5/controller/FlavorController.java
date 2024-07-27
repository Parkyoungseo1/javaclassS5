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
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.pagination.PageProcess;
import com.spring.javaclassS5.service.AdminService;
import com.spring.javaclassS5.service.FlavorService;
import com.spring.javaclassS5.vo.AdminVO;
import com.spring.javaclassS5.vo.FlavorReplyVO;
import com.spring.javaclassS5.vo.FlavorVO;
import com.spring.javaclassS5.vo.PageVO;

@Controller
@RequestMapping("/flavor")
public class FlavorController {
	
	@Autowired
	FlavorService flavorService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = "/flavorList", method = RequestMethod.GET)
	public String flavorListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "All", required = false) String part) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "flavor", part, "");
		
		ArrayList<FlavorVO> vos = flavorService.getFlavorList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "flavor/flavorList";
	}
	
	@RequestMapping(value = "/flavorInput", method = RequestMethod.GET)
	public String flavorInputGet() {
		return "flavor/flavorInput";
	}
	
	@RequestMapping(value = "/flavorInput", method = RequestMethod.POST)
	public String flavorInputPost(FlavorVO vo, MultipartFile file) {
		vo.setThumbnail(flavorService.setThumbnailCreate(file));
		System.out.println("vo : " + vo);
		
		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 user폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/flavor'폴더로 복사처리)
		if(vo.getContent().indexOf("src=\"/") != -1) flavorService.imgCheck(vo.getContent());
		
		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 flavor폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/flavor/"));
		// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
		int res = flavorService.setFlavorInput(vo);
		
		if(res != 0) return "redirect:/message/flavorInputOk";
		else  return "redirect:/message/flavorInputNo";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/flavorContent", method = RequestMethod.GET)
	public String boardContentPost(int idx, Model model, HttpServletRequest request,
			@RequestParam(name="flag", defaultValue = "", required = false) String flag,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 조회수 증가하기
		//userboardService.setReadNumPlus(idx);
		// 게시글 조회수 1씩 증가시키기(중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "flavor" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			flavorService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		FlavorVO vo = flavorService.getFlavorContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("flag", flag);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 이전글/다음글 가져오기
		FlavorVO preVo = flavorService.getPreNexSearch(idx, "preVo");
		FlavorVO nextVo = flavorService.getPreNexSearch(idx, "nextVo");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		// 댓글(대댓글) 추가 입력처리
		List<FlavorReplyVO> replyVos = flavorService.getFlavorReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "flavor/flavorContent";
	}
	
	@RequestMapping(value = "/flavorUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 수정화면으로 이동할시에는 기존 원본파일의 그림파일이 존재한다면, 현재폴더(flavor)의 그림파일을 ckeditor폴더로 복사시켜준다.
		FlavorVO vo = flavorService.getFlavorContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) flavorService.imgBackup(vo.getContent());
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("vo", vo);
		return "flavor/flavorUpdate";
	}
	
	@RequestMapping(value = "/flavorUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(FlavorVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
		FlavorVO origVo = flavorService.getFlavorContent(vo.getIdx());
		
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한것이기에, 그림파일 처리유무를 결정한다.
		if(!origVo.getContent().equals(vo.getContent())) {
			// 1.기존 user폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기전에 ckeditor폴더에 저장시켜두었다.)
			if(origVo.getContent().indexOf("src=\"/") != -1) flavorService.imgDelete(origVo.getContent());
			
			// 2.앞의 삭제 작업이 끝나면 'flavor'폴더를 'ckeditor'로 경로 변경한다.
			vo.setContent(vo.getContent().replace("/data/flavor/", "/data/ckeditor/"));
			
			// 1,2, 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
			// 즉, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 '/data/flavor/'폴더에 복사 저장처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) flavorService.imgCheck(vo.getContent());
			
			// 이미지들의 모든 복사작업을 마치면, 폴더명을 'ckeditor'에서 'user'폴더로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/user/"));
			
			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update 시켜준다.
		}
		int res = flavorService.setFlavorUpdate(vo);
	
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res != 0) return "redirect:/message/flavorUpdateOk";
		else return "redirect:/message/flavorUpdateNo";
	}
	
	@RequestMapping(value = "/flavorDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		FlavorVO vo = flavorService.getFlavorContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) flavorService.imgDelete(vo.getContent());
		
		// 사진작업을 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = flavorService.setFlavorDelete(idx);
		
		
		if(res != 0) return "redirect:/message/flavorDeleteOk";
		else return "redirect:/message/flavorDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 부모댓글 입력처리(원본글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/flavorReplyInput", method = RequestMethod.POST)
	public String flavorReplyInputPost(FlavorReplyVO replyVO) {
		// 부모댓글의 경우는 re_step=0, re_order=1로 처리.(단, 원본글의 첫번째 부모댓글은 re_order=1이지만, 2번이상은 마지막부모댓글의 re_order보다 +1처리 시켜준다.
		FlavorReplyVO replyParentVO = flavorService.getFlavorParentReplyCheck(replyVO.getFlavorIdx());
		
		if(replyParentVO == null) {
			replyVO.setRe_order(1);
		}
		else {
			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
		}
		replyVO.setRe_step(0);
		
		System.out.println("replyVO : "+replyVO);
		
		int res = flavorService.setFlavorReplyInput(replyVO);
		return res + "";
	}
	
	// 대댓글 입력처리(부모댓글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/flavorReplyInputRe", method = RequestMethod.POST)
	public String FlavorReplyInputRePost(FlavorReplyVO replyVO) {
		// 대댓글(답변글)의 1.re_step은 부모댓글의 re_step+1, 2.re_order는 부모의 re_order보다 큰 댓글은 모두 +1처리후, 3.자신의 re_order+1시켜준다.
		
		replyVO.setRe_step(replyVO.getRe_step() + 1);		// 1번처리
		
		flavorService.setReplyOrderUpdate(replyVO.getFlavorIdx(), replyVO.getRe_order());  // 2번 처리
		
		replyVO.setRe_order(replyVO.getRe_order() + 1);
		
		int res = flavorService.setFlavorReplyInput(replyVO);
		
		return res + "";
	}
	
	// 게시글 검색처리(검색기)
	@RequestMapping(value = "/flavorSearch")
	public String boardSearchGet(Model model, String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "flavor", search, searchString);
		
		List<FlavorVO> vos = flavorService.getFlavorSearchList(pageVO.getStartIndexNo(), pageSize, search, searchString);

		String searchTitle = "";
		if(pageVO.getSearh().equals("title")) searchTitle = "글제목";
		else if(pageVO.getSearh().equals("nickName")) searchTitle = "글쓴이";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("searchCount", vos.size());
		
		return "flavor/flavorSearchList";
	}
	
	// 게시글 댓글 삭제 
	@ResponseBody
	@RequestMapping(value = "/FlavorReplyDelete", method = RequestMethod.POST)
	public String flavorReplyDeletePost(int idx) {
	  int res = flavorService.setFlavorReplyDelete(idx);	    
	  return res + "";
	}
	
	// 게시글 신고하기
	@ResponseBody
	@RequestMapping(value = "/flavorComplaintInput", method = RequestMethod.POST)
	public String flavorComplaintInputPost(AdminVO vo) {
		int res = adminService.setflavorComplaintInput(vo);	    
		return res + "";
	}
}
