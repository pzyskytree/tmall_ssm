package org.pzy.tmall.service;

import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {

    void init (Product product);

    void update(PropertyValue propertyValue);

    PropertyValue get(int ptid, int pid);

    List<PropertyValue> list(int pid);
}
