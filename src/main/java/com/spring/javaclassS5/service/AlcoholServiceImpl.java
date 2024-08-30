package com.spring.javaclassS5.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.common.JavaclassProvide;
import com.spring.javaclassS5.dao.AlcoholDAO;
import com.spring.javaclassS5.vo.AlcoholVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class AlcoholServiceImpl implements AlcoholService {
	
	@Autowired
	AlcoholDAO alcoholDAO;
	
	JavaclassProvide javaclassProvide;
	
	@Override
	public ArrayList<AlcoholVO> getAlcoholList() {
		return alcoholDAO.getAlcoholList();
	}

	@Override
	public int setAlcoholInput(AlcoholVO vo) {
		return alcoholDAO.setAlcoholInput(vo);
	}

	@Override
	public AlcoholVO getAlcoholContent(int idx) {
		return alcoholDAO.getAlcoholContent(idx);
	}

	@Override
	public ArrayList<AlcoholVO> getAlcoholList(int startIndexNo, int pageSize, String part) {
		return alcoholDAO.getAlcoholList(startIndexNo, pageSize, part);
	}

	@Override
	public void setReadNumPlus(int idx) {
		alcoholDAO.setReadNumPlus(idx);
	}

	@Override
	public AlcoholVO getPreNexSearch(int idx, String str) {
		return alcoholDAO.getPreNexSearch(idx, str);
	}

	// content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'alcohol'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3         4
		//                012345678901234567890123456789012345678901234
		// <p><img alt="" src="/javaclassS5/resources/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/resources/data/alcohol/240712172140_X RATED LIQUEUR.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 42;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "alcohol/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 alcohol폴더위치로 복사처리하는 메소드.
			
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
		//                0         1         2         3         4
		//                01234567890123456789012345678901234567890123456
		// <p><img alt="" src="/javaclassS5/resources/data/alcohol/240712172140_X RATED LIQUEUR.jpg"" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS5/resources/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 41;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "alcohol/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 alcohol폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public void imgDelete(String content) {
		//                0         1         2         3         4
		//                01234567890123456789012345678901234567890123456789
		// <p><img alt="" src="/javaclassS5/resources/data/alcohol/240712172140_X RATED LIQUEUR.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 41;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "alcohol/" + imgFile;
			
			fileDelete(origFilePath);	// alcohol폴더의 그림파일 삭제한다.
			
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
	public int setAlcoholUpdate(AlcoholVO vo) {
		return alcoholDAO.setAlcoholUpdate(vo);
	}

	@Override
	public int setAlcoholDelete(int idx) {
		return alcoholDAO.setAlcoholDelete(idx);
	}

	@Override
	public List<AlcoholVO> getAlcoholSearchList(int startIndexNo, int pageSize, String search, String searchString) {
		return alcoholDAO.getAlcoholSearchList(startIndexNo, pageSize, search, searchString);
	}

	// 썸네일 저장
	@Override
	public String setThumbnailCreate(MultipartFile file) {
		String res = "";
		try {
			//System.out.println("ddd === " + file.getOriginalFilename());
			//System.out.println("ccc :" + newNameCreate22(2));
			String sFileName = newNameCreate22(2) + "_" + file.getOriginalFilename();
			
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
	
	public String newNameCreate22(int lenChar) {
		System.out.println("333333");
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String newName = sdf.format(today);
		newName += RandomStringUtils.randomAlphanumeric(lenChar) + "_";
		System.out.println("newN : " + newName);
		return newName;
	}

	@Override
	public int getAlcoholCount() {
		return alcoholDAO.getAlcoholCount();
	}
	
}
