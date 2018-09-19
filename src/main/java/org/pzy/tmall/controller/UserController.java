package org.pzy.tmall.controller;

import com.github.pagehelper.PageHelper;
import java.util.List;

import com.github.pagehelper.PageInfo;
import org.pzy.tmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.pzy.tmall.util.Page;

@Controller
@RequestMapping("")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List users = userService.list();
        if (page.getTotal() == 0){
            page.setTotal((int)new PageInfo<>(users).getTotal());
        }
        model.addAttribute("users", users);
        model.addAttribute("page", page);
        return "admin/listUser";
    }


}
