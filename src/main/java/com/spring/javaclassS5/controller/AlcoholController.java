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
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.pagination.PageProcess;
import com.spring.javaclassS5.service.AlcoholService;
import com.spring.javaclassS5.vo.AlcoholVO;
import com.spring.javaclassS5.vo.PageVO;

@Controller
@RequestMapping("/alcohol")
public class AlcoholController {
	
	@Autowired
	AlcoholService alcoholService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/alcoholList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "ALL", required = false) String part) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "alcohol", part, "");
		
		ArrayList<AlcoholVO> vos = alcoholService.getAlcoholList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "alcohol/alcoholList";
	}
	
	@RequestMapping(value = "/alcoholInput", method = RequestMethod.GET)
	public String alcoholInputGet(Model model) {
		return "alcohol/alcoholInput";
	}
	
	@RequestMapping(value = "/alcoholInput", method = RequestMethod.POST)
	public String alcoholInputPost(AlcoholVO vo, MultipartFile file) {
		vo.setThumbnail(alcoholService.setThumbnailCreate(file));
		
		System.out.println("썸네일 : " + vo.getThumbnail());
		
		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
		if(vo.getContent().indexOf("src=\"/") != -1) alcoholService.imgCheck(vo.getContent());
		
		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 board폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/alcohol/"));
		
		// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
		int res = alcoholService.setAlcoholInput(vo);
		
		if(res != 0) return "redirect:/message/alcoholInputOk";
		else  return "redirect:/message/alcoholInputNo";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/alcoholContent", method = RequestMethod.GET)
	public String alcoholContentPost(int idx, Model model, HttpServletRequest request,
			@RequestParam(name="flag", defaultValue = "", required = false) String flag,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 조회수 증가하기
		//alcoholService.setReadNumPlus(idx);
		// 게시글 조회수 1씩 증가시키기(중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "alcohol" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			alcoholService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		AlcoholVO vo = alcoholService.getAlcoholContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("flag", flag);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 이전글/다음글 가져오기
		AlcoholVO preVo = alcoholService.getPreNexSearch(idx, "preVo");
		AlcoholVO nextVo = alcoholService.getPreNexSearch(idx, "nextVo");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);
		
		return "alcohol/alcoholContent";
	}
	
	@RequestMapping(value = "/alcoholUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "ALL", required = false) String part) {
		// 수정화면으로 이동할시에는 기존 원본파일의 그림파일이 존재한다면, 현재폴더(alcohol)의 그림파일을 ckeditor폴더로 복사시켜준다.
		AlcoholVO vo = alcoholService.getAlcoholContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) alcoholService.imgBackup(vo.getContent());
		
		model.addAttribute("pag", pag);
		model.addAttribute("part", part);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("vo", vo);
		return "alcohol/alcoholUpdate";
	}
	
	@RequestMapping(value = "/alcoholUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(AlcoholVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "ALL", required = false) String part) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
		AlcoholVO origVo = alcoholService.getAlcoholContent(vo.getIdx());
		System.out.println("0");
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한것이기에, 그림파일 처리유무를 결정한다.
		if(!origVo.getContent().equals(vo.getContent())) {
			// 1.기존 alcohol폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기전에 ckeditor폴더에 저장시켜두었다.)
			if(origVo.getContent().indexOf("src=\"/") != -1) alcoholService.imgDelete(origVo.getContent());
			System.out.println("1");
			
			// 2.앞의 삭제 작업이 끝나면 'alcohol'폴더를 'ckeditor'로 경로 변경한다.
			vo.setContent(vo.getContent().replace("/data/alcohol/", "/data/ckeditor/"));
			System.out.println("2");
			
			// 1,2, 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
			// 즉, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 '/data/alcohol/'폴더에 복사 저장처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) alcoholService.imgCheck(vo.getContent());
			
			// 이미지들의 모든 복사작업을 마치면, 폴더명을 'ckeditor'에서 'alcohol'폴더로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/alcohol/"));
			
			System.out.println("3.변경완료");
			// content안의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update 시켜준다.
		}
		int res = alcoholService.setAlcoholUpdate(vo);
	
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("part", part);
		model.addAttribute("pageSize", pageSize);
		
		if(res != 0) return "redirect:/message/alcoholUpdateOk";
		else return "redirect:/message/alcoholUpdateNo";
	}
	
	@RequestMapping(value = "/alcoholDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		AlcoholVO vo = alcoholService.getAlcoholContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) alcoholService.imgDelete(vo.getContent());
		
		// 사진작업을 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = alcoholService.setAlcoholDelete(idx);
		
		
		if(res != 0) return "redirect:/message/alcoholDeleteOk";
		else return "redirect:/message/alcoholDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 게시글 검색처리(검색기)
	@RequestMapping(value = "/alcoholSearch")
	public String alcoholSearchGet(Model model, String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "alcohol", search, searchString);
		
		List<AlcoholVO> vos = alcoholService.getAlcoholSearchList(pageVO.getStartIndexNo(), pageSize, search, searchString);

		String searchTitle = "";
		if(pageVO.getSearh().equals("title")) searchTitle = "글제목";
		else if(pageVO.getSearh().equals("part")) searchTitle = "종류";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("searchCount", vos.size());
		
		return "alcohol/alcoholSearchList";
	}
	
}
