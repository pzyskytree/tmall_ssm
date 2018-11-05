package org.pzy.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.pzy.tmall.pojo.Order;
import org.pzy.tmall.service.OrderItemService;
import org.pzy.tmall.service.OrderService;
import org.pzy.tmall.util.Page;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;

    @RequestMapping(value = "orders", method = RequestMethod.GET)
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Order> orders = orderService.list();
        if (page.getTotal() == 0){
            page.setTotal((int)new PageInfo<>(orders).getTotal());
        }
        orderItemService.fill(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("page", page);
        return "admin/listOrder";
    }

    @RequestMapping(value = "orders/delivery/{oid}", method = RequestMethod.GET)
    public String delivery(@PathVariable int oid){
        Order order = orderService.get(oid);
        order.setDeliveryDate(new Date());
        order.setStatus(OrderService.waitConfirm);
        orderService.update(order);
        return "redirect:/orders";
    }

}
