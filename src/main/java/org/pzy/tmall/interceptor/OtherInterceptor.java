package org.pzy.tmall.interceptor;

import java.util.List;

import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.pojo.OrderItem;
import org.pzy.tmall.pojo.User;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.service.OrderItemService;
import org.pzy.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OtherInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ProductService productService;

    public boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)throws Exception{
        List<Category> categories = categoryService.list();
        productService.fill(categories);
        productService.fillByRow(categories);
        HttpSession session = request.getSession();
        session.setAttribute("categories", categories);

        String contextPath = session.getServletContext().getContextPath();
        session.setAttribute("contextPath", contextPath);

        User user = (User)session.getAttribute("user");
        int cartTotalItemNumber = 0;
        if (user != null){
            List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
            for (OrderItem orderItem : orderItems){
                cartTotalItemNumber += orderItem.getNumber();
            }
        }
        session.setAttribute("cartTotalItemNumber", cartTotalItemNumber);
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }
}
