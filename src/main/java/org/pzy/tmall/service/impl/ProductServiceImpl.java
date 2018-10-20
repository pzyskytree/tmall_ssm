package org.pzy.tmall.service.impl;

import org.pzy.tmall.mapper.ProductMapper;
import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.pojo.ProductExample;
import org.pzy.tmall.pojo.ProductImage;
import org.pzy.tmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductMapper productMapper;
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;

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

    @Override
    public void fill(List<Category> categories) {
        for (Category category : categories){
            fill(category);
        }
    }

    @Override
    public void fill(Category category) {
        List<Product> products = list(category.getId());
        category.setProducts(products);
    }

    @Override
    public void fillByRow(List<Category> categories) {
        int productNumEachRow = 8;
        for (Category category : categories) {
            List<List<Product>> allProducts = new ArrayList<List<Product>>();
            List<Product> products = list(category.getId());
            for (int i = 0; i < products.size(); i += productNumEachRow) {
                int j = i + productNumEachRow > products.size() ? products.size() : i + productNumEachRow;
                List<Product> productsRow = products.subList(i, j);
                allProducts.add(productsRow);
            }
            category.setProductsByRow(allProducts);
        }

    }

    @Override
    public void setSaleAndReviewNumber(Product product) {
        int saleCount = orderItemService.getSaleCount(product.getId());
        product.setSaleCount(saleCount);
        int reviewCount = reviewService.getCount(product.getId());
        product.setReviewCount(reviewCount);
    }

    @Override
    public void setSaleAndReviewNumber(List<Product> products) {
        for (Product product : products){
            setSaleAndReviewNumber(product);
        }
    }

    @Override
    public List<Product> search(String keyword) {
        ProductExample productExample = new ProductExample();
        productExample.createCriteria().andNameLike("%" + keyword + "%");
        productExample.setOrderByClause("id desc");
        List<Product> result = productMapper.selectByExample(productExample);
        setFirstProductImage(result);
        setCategory(result);
        return result;
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
