package org.pzy.tmall.service;

import java.util.List;
import org.pzy.tmall.pojo.Product;

public interface ProductService {
    void add(Product product);

    void delete(int id);

    void update(Product product);

    Product get(int id);

    List list(int cid);

    void setFirstProductImage(Product product);
}
