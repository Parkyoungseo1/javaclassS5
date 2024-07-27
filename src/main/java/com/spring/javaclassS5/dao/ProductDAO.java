package com.spring.javaclassS5.dao;

import com.spring.javaclassS5.vo.ProductVO;
import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {

	List<ProductVO> getAllProducts() throws SQLException;
}
