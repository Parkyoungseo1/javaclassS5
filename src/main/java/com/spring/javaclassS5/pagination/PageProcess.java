package com.spring.javaclassS5.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS5.dao.AlcoholDAO;
import com.spring.javaclassS5.vo.PageVO;

@Service
public class PageProcess {

	@Autowired
	AlcoholDAO alcoholDAO;

	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("alcohol")) {
			if(searchString.equals("")) {
				totRecCnt = alcoholDAO.totRecCnt(part);
			}
			else {
				search = part;
				totRecCnt = alcoholDAO.totRecCntSearch(search, searchString);
			}
		}		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearh(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
				
		return pageVO;
	}
	
	
}
