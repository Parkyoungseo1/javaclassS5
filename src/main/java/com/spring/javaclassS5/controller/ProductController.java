//package com.spring.javaclassS5.controller;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.spring.javaclassS5.service.ProductService;
//import com.spring.javaclassS5.vo.ProductVO;
//
//@Controller
//@RequestMapping("/product")
//public class ProductController {
//	
//  @Autowired
//  ProductService productService;
//
//  @RequestMapping(value = "/products" , method = RequestMethod.GET)
//  public String productsListGet(Model model) {
//  	List<ProductVO> mainVOS = productService.getAllProducts();
//  	
//      model.addAttribute("mainVOS", mainVOS);
//      return "product/productList";
//  }
//
//  @RequestMapping(value = "/products", method = RequestMethod.GET)
//  public String productDetails(int id, Model model) {
//      model.addAttribute("product", productService.getProductById(id));
//      return "productDetails";
//  }
//}
