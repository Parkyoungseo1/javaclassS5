package com.spring.javaclassS5.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS5.vo.DbBaesongVO;
import com.spring.javaclassS5.vo.DbCartVO;
import com.spring.javaclassS5.vo.DbOptionVO;
import com.spring.javaclassS5.vo.DbOrderVO;
import com.spring.javaclassS5.vo.DbProductVO;

public interface DbShopService {

	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	public int setCategoryMainInput(DbProductVO vo);

	public List<DbProductVO> getCategoryMain();

	public DbProductVO getCategoryMiddleOne(DbProductVO vo);

	public int setCategoryMainDelete(String categoryMainCode);

	public int setCategoryMiddleInput(DbProductVO vo);

	public List<DbProductVO> getCategoryMiddle();

	public DbProductVO getCategorySubOne(DbProductVO vo);

	public int setCategoryMiddleDelete(String categoryMiddleCode);

	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode);

	public List<DbProductVO> getCategorySub();

	public int setCategorySubInput(DbProductVO vo);

	public DbProductVO getCategoryProductName(DbProductVO vo);

	public int setCategorySubDelete(String categorySubCode);

	public int imgCheckProductInput(MultipartFile file, DbProductVO vo);

	public List<DbProductVO> getSubTitle();

	public List<DbProductVO> getDbShopList(String part, String mainPrice);

	public DbProductVO getDbShopProduct(int idx);

	public List<DbOptionVO> getDbShopOption(int idx);

	public DbProductVO getProductInfor(String productName);

	public List<DbOptionVO> getOptionList(int productIdx);

	public List<DbProductVO> getCategoryProductNameAjax(String categoryMainCode);

	public int getOptionSame(int productIdx, String optionName);

	public int setDbOptionInput(DbOptionVO vo);

	public int setOptionDelete(int idx);

	public DbProductVO getCategoryProductNameOne(String productName);

	public DbProductVO getCategoryProductNameOneVO(DbProductVO imsiVO);

	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid);

	public int dbShopCartUpdate(DbCartVO vo);

	public int dbShopCartInput(DbCartVO vo);

	public List<DbCartVO> getDbCartList(String mid);

	public int dbCartDelete(int idx);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(int idx);

	public void setDbOrder(DbOrderVO vo);

	public void setDbCartDeleteAll(int cartIdx);

	public void setDbBaesong(DbBaesongVO baesongVO);

	public void setMemberPointPlus(int point, String mid);

	public int getTotalBaesongOrder(String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(String orderIdx);

}
