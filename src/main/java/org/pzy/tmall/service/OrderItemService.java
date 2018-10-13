package org.pzy.tmall.service;

import java.util.List;

import org.pzy.tmall.pojo.Order;
import org.pzy.tmall.pojo.OrderItem;

public interface OrderItemService {
    void add(OrderItem orderItem);

    void delete(int id);

    void update(OrderItem orderItem);

    OrderItem get(int id);

    List list();

    void fill(List<Order> orders);

    void fill(Order order);

    int getSaleCount(int pid);

}
