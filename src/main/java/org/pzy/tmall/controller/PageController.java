package org.pzy.tmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("")
public class PageController {

    @RequestMapping(value = "registerPage", method = RequestMethod.GET)
    public String registerPage(){
        return "fore/register";
    }

    @RequestMapping(value = "registerSuccessPage", method = RequestMethod.GET)
    public String registerSuccessPage(){
        return "fore/registerSuccess";
    }

    @RequestMapping(value = "loginPage", method = RequestMethod.GET)
    public String loginPage(){
        return "fore/login";
    }

    @RequestMapping(value = "foreAlipay", method = RequestMethod.GET)
    public String alipay(){
        return "fore/alipay";
    }

}
