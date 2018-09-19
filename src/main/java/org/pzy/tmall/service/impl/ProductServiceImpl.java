package org.pzy.tmall.service.impl;

import org.pzy.tmall.controller.ProductImageController;
import org.pzy.tmall.mapper.ProductMapper;
import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.pojo.ProductExample;
import org.pzy.tmall.pojo.ProductImage;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.service.ProductImageService;
import org.pzy.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;

    @Override
    public void add(Product product) {
        productMapper.insert(product);
    }

    @Override
    public void delete(int id) {
        productMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Product product) {
        productMapper.updateByPrimaryKeySelective(product);
    }

    @Override
    public Product get(int id) {
        Product product = productMapper.selectByPrimaryKey(id);
        setCategory(product);
        setFirstProductImage(product);
        return product;
    }

    @Override
    public List list(int cid) {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria().andCidEqualTo(cid);
        productExample.setOrderByClause("id desc");
        List products = productMapper.selectByExample(productExample);
        setCategory(products);
        setFirstProductImage(products);
        return products;
    }

    @Override
    public void setFirstProductImage(Product product) {
        List<ProductImage> productImages = productImageService.list(product.getId(), productImageService.typeSingle);
        if (!productImages.isEmpty()){
            ProductImage productImage = productImages.get(0);
            product.setFirstProductImage(productImage);
        }
    }

    public void setFirstProductImage(List<Product> products){
        for (Product product : products){
            setFirstProductImage(product);
        }

    }

    public void setCategory(Product product){
        Category category = categoryService.get(product.getCid());
        product.setCategory(category);
    }

    public void setCategory(List<Product> products){
        for (Product product : products)
            setCategory(product);
    }
}
