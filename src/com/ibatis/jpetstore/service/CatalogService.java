/**
 *    Copyright 2010-2017 the original author or authors.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */
package com.ibatis.jpetstore.service;

import com.ibatis.common.util.PaginatedList;
import com.ibatis.dao.client.DaoManager;
import com.ibatis.jpetstore.domain.Category;
import com.ibatis.jpetstore.domain.Item;
import com.ibatis.jpetstore.domain.Product;
import com.ibatis.jpetstore.persistence.iface.CategoryDao;
import com.ibatis.jpetstore.persistence.iface.ItemDao;
import com.ibatis.jpetstore.persistence.iface.ProductDao;
import com.ibatis.jpetstore.persistence.DaoConfig;

import java.util.List;

public class CatalogService {

  private CategoryDao categoryDao;
  private ItemDao itemDao;
  private ProductDao productDao;

  public CatalogService() {
    DaoManager daoManager = DaoConfig.getDaoManager();
    categoryDao = (CategoryDao) daoManager.getDao(CategoryDao.class);
    productDao = (ProductDao) daoManager.getDao(ProductDao.class);
    itemDao = (ItemDao) daoManager.getDao(ItemDao.class);
  }

  public CatalogService(CategoryDao categoryDao, ItemDao itemDao, ProductDao productDao) {
    this.categoryDao = categoryDao;
    this.itemDao = itemDao;
    this.productDao = productDao;
  }

  public List getCategoryList() {
    return categoryDao.getCategoryList();
  }

  public Category getCategory(String categoryId) {
    return categoryDao.getCategory(categoryId);
  }

  public Product getProduct(String productId) {
    return productDao.getProduct(productId);
  }

  public PaginatedList getProductListByCategory(String categoryId) {
    return productDao.getProductListByCategory(categoryId);
  }

  public PaginatedList searchProductList(String keywords) {
    return productDao.searchProductList(keywords);
  }

  public PaginatedList getItemListByProduct(String productId) {
    return itemDao.getItemListByProduct(productId);
  }

  public Item getItem(String itemId) {
    return itemDao.getItem(itemId);
  }

  public boolean isItemInStock(String itemId) {
    return itemDao.isItemInStock(itemId);
  }

}