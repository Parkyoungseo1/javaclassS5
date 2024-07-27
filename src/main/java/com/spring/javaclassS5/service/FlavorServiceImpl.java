package com.spring.javaclassS5.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.common.JavaclassProvide;
import com.spring.javaclassS5.dao.FlavorDAO;
import com.spring.javaclassS5.vo.FlavorReplyVO;
import com.spring.javaclassS5.vo.FlavorVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class FlavorServiceImpl implements FlavorService {
	
	@Autowired
	FlavorDAO flavorDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@Override
	public ArrayList<FlavorVO> getFlavorList() {
		return flavorDAO.getFlavorList();
	}

	@Override
	public int setFlavorInput(FlavorVO vo) {
		return flavorDAO.setFlavorInput(vo);
	}

	@Override
	public FlavorVO getFlavorContent(int idx) {
		return flavorDAO.getFlavorContent(idx);
	}

	@Override
	public ArrayList<FlavorVO> getFlavorList(int startIndexNo, int pageSize, String part) {
		return flavorDAO.getFlavorList(startIndexNo, pageSize, part);
	}

	@Override
	public void setReadNumPlus(int idx) {
		flavorDAO.setReadNumPlus(idx);
	}

	@Override
	public FlavorVO getPreNexSearch(int idx, String str) {
		return flavorDAO.getPreNexSearch(idx, str);
	}

	// content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'flavor'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3         4 
		//                012345678901234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS5/resources/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/resources/data/flavor/240717155448_lights.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "flavor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 flavor폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void imgBackup(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS5/resources/data/flavor/240717155448_lights.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "flavor/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 flavor폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS5/resources/data/flavor/240716155157_p2.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "flavor/" + imgFile;
			
			fileDelete(origFilePath);	// flavor폴더의 그림파일 삭제한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 서버에 존재하는 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setFlavorUpdate(FlavorVO vo) {
		return flavorDAO.setFlavorUpdate(vo);
	}

	@Override
	public int setFlavorDelete(int idx) {
		return flavorDAO.setFlavorDelete(idx);
	}

	@Override
	public FlavorReplyVO getFlavorParentReplyCheck(int flavorIdx) {
		return flavorDAO.getFlavorParentReplyCheck(flavorIdx);
	}

	@Override
	public int setFlavorReplyInput(FlavorReplyVO replyVO) {
		return flavorDAO.setFlavorReplyInput(replyVO);
	}

	@Override
	public List<FlavorReplyVO> getFlavorReply(int idx) {
		return flavorDAO.getFlavorReply(idx);
	}

	@Override
	public void setReplyOrderUpdate(int flavorIdx, int re_order) {
		flavorDAO.setReplyOrderUpdate(flavorIdx, re_order);
	}

	@Override
	public List<FlavorVO> getFlavorSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return flavorDAO.getFlavorSearchList(startIndexNo, pageSize, search, searchString);
	}
	
	//게시글 삭제
	@Override
	public int setFlavorReplyDelete(int idx) {
		return flavorDAO.setFlavorReplyDelete(idx);
	}
	
	// 게시글 신고
	@Override
	public int setFlavorComplaintInput(int idx) {
		return flavorDAO.setFlavorComplaintInput(idx);
	}

	@Override
	public String setThumbnailCreate(MultipartFile file) {
		String res = "";
		try {
			String sFileName = javaclassProvide.newNameCreate(2) + "_" + file.getOriginalFilename();
			
			// 썸네일 파일이 저장될 경로설정
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
			File realFileName = new File(realPath + sFileName);
			file.transferTo(realFileName);
			
			// 썸메일 이미지 생성 저장하기
			String thumbnailSaveName = realPath + "s_" + sFileName;
			File thumbnailFile = new File(thumbnailSaveName);
			
			int width = 160;
			int height = 120;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
			res = sFileName;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
