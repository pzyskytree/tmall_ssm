package org.pzy.tmall.service;

import java.util.List;
import org.pzy.tmall.pojo.ProductImage;

public interface ProductImageService {

    String typeSingle = "type_single";
    String typeDetail = "type_detail";

    void add(ProductImage productImage);

    void delete(int id);

    void update(ProductImage productImage);

    ProductImage get(int id);

    List list(int pid, String type);

}
