package org.pzy.tmall.service.impl;

import org.pzy.tmall.mapper.ReviewMapper;
import org.pzy.tmall.pojo.Review;
import org.pzy.tmall.pojo.User;
import org.pzy.tmall.pojo.ReviewExample;
import org.pzy.tmall.service.ReviewService;
import org.pzy.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceIml implements ReviewService {

    @Autowired
    ReviewMapper reviewMapper;

    @Autowired
    UserService userService;
    @Override
    public void add(Review review) {
        reviewMapper.insert(review);
    }

    @Override
    public void delete(int id) {
        reviewMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Review review) {
        reviewMapper.updateByPrimaryKey(review);
    }

    @Override
    public Review get(int id) {
        return reviewMapper.selectByPrimaryKey(id);
    }

    @Override
    public List list(int pid) {
        ReviewExample reviewExample = new ReviewExample();
        reviewExample.createCriteria().andPidEqualTo(pid);
        reviewExample.setOrderByClause("id desc");
        List<Review> reviews = reviewMapper.selectByExample(reviewExample);
        setUser(reviews);
        return reviews;
    }

    public void setUser(List<Review> reviews){
        for (Review review : reviews){
            setUser(review);
        }
    }

    public void setUser(Review review){
        int uid = review.getUid();
        User user = userService.get(uid);
        review.setUser(user);
    }

    @Override
    public int getCount(int pid) {
        return list(pid).size();
    }
}
