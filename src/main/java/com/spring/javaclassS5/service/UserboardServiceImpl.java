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

import com.spring.javaclassS5.dao.UserboardDAO;
import com.spring.javaclassS5.vo.UserboardReplyVO;
import com.spring.javaclassS5.vo.UserboardVO;

@Service
public class UserboardServiceImpl implements UserboardService {
	
	@Autowired
	UserboardDAO userboardDAO;

	@Override
	public ArrayList<UserboardVO> getUserboardList() {
		return userboardDAO.getUserboardList();
	}

	@Override
	public int setUserboardInput(UserboardVO vo) {
		return userboardDAO.setUserboardInput(vo);
	}

	@Override
	public UserboardVO getUserboardContent(int idx) {
		return userboardDAO.getUserboardContent(idx);
	}

	@Override
	public ArrayList<UserboardVO> getUserboardList(int startIndexNo, int pageSize, String part) {
		return userboardDAO.getUserboardList(startIndexNo, pageSize, part);
	}

	@Override
	public void setReadNumPlus(int idx) {
		userboardDAO.setReadNumPlus(idx);
	}

	@Override
	public UserboardVO getPreNexSearch(int idx, String str) {
		return userboardDAO.getPreNexSearch(idx, str);
	}

	// content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'user'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3         4 
		//                012345678901234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS5/resources/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/resources/data/user/240717155448_lights.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "user/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 user폴더위치로 복사처리하는 메소드.
			
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
		// <p><img alt="" src="/javaclassS5/resources/data/user/240717155448_lights.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "user/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 user폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS5/resources/data/user/240716155157_p2.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "user/" + imgFile;
			
			fileDelete(origFilePath);	// user폴더의 그림파일 삭제한다.
			
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
	public int setUserboardUpdate(UserboardVO vo) {
		return userboardDAO.setUserboardUpdate(vo);
	}

	@Override
	public int setUserboardDelete(int idx) {
		return userboardDAO.setUserboardDelete(idx);
	}

	@Override
	public UserboardReplyVO getUserboardParentReplyCheck(int userboardIdx) {
		return userboardDAO.getUserboardParentReplyCheck(userboardIdx);
	}

	@Override
	public int setUserboardReplyInput(UserboardReplyVO replyVO) {
		return userboardDAO.setUserboardReplyInput(replyVO);
	}

	@Override
	public List<UserboardReplyVO> getUserboardReply(int idx) {
		return userboardDAO.getUserboardReply(idx);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		userboardDAO.setReplyOrderUpdate(boardIdx, re_order);
	}

	@Override
	public List<UserboardVO> getUserboardSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return userboardDAO.getUserboardSearchList(startIndexNo, pageSize, search, searchString);
	}
	
	//게시글 삭제
	@Override
	public int setUserboardReplyDelete(int idx) {
		return userboardDAO.setUserboardReplyDelete(idx);
	}
	
	// 게시글 신고
	@Override
	public int setUserboardComplaintInput(int idx) {
		return userboardDAO.setUserboardComplaintInput(idx);
	}


	@Override
	public List<UserboardVO> getComplaintList() {
		return userboardDAO.getComplaintList();
	}

	@Override
	public int getUserboardCount() {
		return userboardDAO.getUserboardCount();
	}
	
}
