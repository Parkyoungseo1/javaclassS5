package com.spring.javaclassS5.controller;

import java.sql.SQLException;
import java.util.List;

import com.spring.javaclassS5.service.ProductService;
import com.spring.javaclassS5.vo.ProductVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/product")
public class ProductController {

  @Autowired
  private ProductService productService;

  @RequestMapping(value = "/productList" , method = RequestMethod.GET)
  public String productsListGet(Model model) throws SQLException {
      List<ProductVO> productVOS = productService.getAllProducts();
      model.addAttribute("productVOS", productVOS);
      return "dbShop/dbProductList";
  }

}