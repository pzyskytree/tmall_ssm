package org.pzy.tmall.service;

import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.util.Page;

import java.util.List;

public interface CategoryService {

    List<Category> list();

    void add(Category category);

    void delete(int id);

    Category get (int id);

    void update (Category category);
}
