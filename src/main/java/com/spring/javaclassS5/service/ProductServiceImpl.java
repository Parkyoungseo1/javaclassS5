package com.spring.javaclassS5.service;

import com.spring.javaclassS5.dao.ProductDAO;
import com.spring.javaclassS5.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO dao;

	@Override
	public List<ProductVO> getAllProducts() throws SQLException {
		return dao.getAllProducts();
	}
}
