package org.pzy.tmall.controller;

import java.util.List;

import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.pojo.PropertyValue;
import org.pzy.tmall.service.ProductService;
import org.pzy.tmall.service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody ;

@Controller
@RequestMapping("")
public class PropertyValueController {
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    ProductService productService;

    @RequestMapping(value = "propertyValues/{pid}/edit", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable("pid") int pid){
        Product product = productService.get(pid);
        propertyValueService.init(product);
        List<PropertyValue> propertyValues = propertyValueService.list(pid);
        model.addAttribute("propertyValues", propertyValues);
        model.addAttribute("product", product);
        return "admin/editPropertyValue";
    }

    @RequestMapping(value = "propertyValues/{pid}", method = RequestMethod.POST)
    @ResponseBody
    public String update(PropertyValue propertyValue){
        propertyValueService.update(propertyValue);
        return  "success";
    }
}
