package org.pzy.tmall.service;

import java.util.List;
import org.pzy.tmall.pojo.Review;

public interface ReviewService {

    void add(Review review);

    void delete(int id);

    void update(Review review);

    Review get(int id);

    List list(int pid);

    int getCount(int pid);

}
