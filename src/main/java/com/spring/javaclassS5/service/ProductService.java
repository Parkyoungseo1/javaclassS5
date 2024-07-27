package com.spring.javaclassS5.service;

import com.spring.javaclassS5.vo.ProductVO;

import java.sql.SQLException;
import java.util.List;

public interface ProductService {

    List<ProductVO> getAllProducts() throws SQLException;
}