package org.pzy.tmall.controller;

import com.github.pagehelper.PageHelper;
import java.util.List;

import com.github.pagehelper.PageInfo;
import org.pzy.tmall.util.Page;
import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.pojo.Property;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.service.PropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("")
public class PropertyController {
    @Autowired
    PropertyService propertyService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "properties", method = RequestMethod.POST)
    public String add(Property p){
        propertyService.add(p);
        return "redirect:/properties?cid="+p.getCid();
    }

    @RequestMapping(value = "properties/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") int id){
        Property p = propertyService.get(id);
        propertyService.delete(id);
        return "redirect:/properties?cid=" + p.getCid();
    }

    @RequestMapping(value = "properties/{id}/edit", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable("id") int id){
        Property p = propertyService.get(id);
        Category c = categoryService.get(p.getCid());
        p.setCategory(c);
        model.addAttribute("property", p);
        return "admin/editProperty";
    }

    @RequestMapping(value = "properties/{id}", method = RequestMethod.POST)
    public String update(Property p){
        propertyService.update(p);
        return "redirect:/properties?cid=" + p.getCid();
    }

    @RequestMapping(value = "properties", method = RequestMethod.GET)
    public String list(@RequestParam("cid") int cid, Model model, Page page){
        Category c = categoryService.get(cid);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Property> properties = propertyService.list(c.getId());
        int total = (int) new PageInfo<>(properties).getTotal();
        page.setTotal(total);
        page.setParam("&cid=" + c.getId());
        model.addAttribute("properties", properties);
        model.addAttribute("page", page);
        model.addAttribute("category", c);
        return "admin/listProperty";
    }

}
