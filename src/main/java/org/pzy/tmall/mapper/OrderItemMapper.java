package org.pzy.tmall.mapper;

import java.util.List;
import org.pzy.tmall.pojo.OrderItem;
import org.pzy.tmall.pojo.OrderItemExample;

public interface OrderItemMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    List<OrderItem> selectByExample(OrderItemExample example);

    OrderItem selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OrderItem record);

    int updateByPrimaryKey(OrderItem record);
}