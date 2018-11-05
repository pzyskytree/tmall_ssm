package org.pzy.tmall.interceptor;

import org.apache.commons.lang.StringUtils;
import org.pzy.tmall.pojo.User;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.basic.BasicInternalFrameTitlePane;
import java.util.Arrays;

public class LoginInterceptor extends HandlerInterceptorAdapter {
    @Autowired
    CategoryService categoryService;
    @Autowired
    OrderItemService orderItemService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        HttpSession session = request.getSession();
        String contextPath = session.getServletContext().getContextPath();
        String[] noNeedAuthPage = { "home", "checkLogin", "Register", "LoginAjax", "Login", "Product", "Category", "Search"};
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri,contextPath);
        if (uri.startsWith("/fore")){
            String method = StringUtils.substringAfterLast(uri, "/fore");
            if (!Arrays.asList(noNeedAuthPage).contains(method)){
                User user = (User)session.getAttribute("user");
                if (user == null){
                    response.sendRedirect(contextPath + "/loginPage");
                    return false;
                }
            }
        }
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) throws Exception{

    }

}
