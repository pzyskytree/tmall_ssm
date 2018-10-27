package org.pzy.tmall.service.impl;

import org.pzy.tmall.mapper.OrderMapper;
import org.pzy.tmall.pojo.*;
import org.pzy.tmall.service.OrderItemService;
import org.pzy.tmall.service.OrderService;
import org.pzy.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;
    @Autowired
    UserService userService;
    @Autowired
    OrderItemService orderItemService;

    @Override
    public void add(Order order) {
        orderMapper.insert(order);
    }

    @Override
    public void delete(int id) {
        orderMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Order order) {
        orderMapper.updateByPrimaryKeySelective(order);
    }

    @Override
    public Order get(int id) {
        Order order = orderMapper.selectByPrimaryKey(id);
        setUser(order);
        return order;
    }

    @Override
    public List list() {
        OrderExample orderExample = new OrderExample();
        orderExample.setOrderByClause("id desc");
        List<Order> orders = orderMapper.selectByExample(orderExample);
        setUser(orders);
        return orders;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, rollbackForClassName = "Exception")
    public float add(Order order, List<OrderItem> orderItems) {
        float total = 0.0f;
        add(order);
        if (false)
            throw new RuntimeException();
        for (OrderItem orderItem : orderItems){
            orderItem.setOid(order.getId());
            orderItemService.update(orderItem);
            total += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
        }
        return total;
    }

    public void setUser(List<Order> orders){
        for (Order order : orders){
            setUser(order);
        }
    }
    public void setUser(Order order){
        User user = userService.get(order.getUid());
        order.setUser(user);
    }
}
