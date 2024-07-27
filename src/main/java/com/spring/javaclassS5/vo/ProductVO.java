package com.spring.javaclassS5.vo;

import lombok.Data;

@Data
public class ProductVO {
  private int id;
  private String name;
  private double price;
  private String description;
  private String thumbnailUrl;
  private String imageUrl;
}
