package org.pzy.tmall.controller;

import com.github.pagehelper.PageHelper;
import java.util.List;

import com.github.pagehelper.PageInfo;
import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.pzy.tmall.util.Page;

import java.util.Date;

@Controller
@RequestMapping("")
public class ProductController {

    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "products", method = RequestMethod.POST)
    public String add(Product product){
        product.setCreateDate(new Date());
        productService.add(product);
        return "redirect:/products?cid=" + product.getCid();
    }

    @RequestMapping(value = "products/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") int id){
        Product product = productService.get(id);
        productService.delete(id);
        return "redirect:/products?cid=" + product.getCid();
    }

    @RequestMapping(value = "products/{id}/edit", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable("id") int id){
        Product product = productService.get(id);
        Category category = categoryService.get(product.getCid());
        product.setCategory(category);
        model.addAttribute("product", product);
        return "admin/editProduct";
    }

    @RequestMapping(value = "products/{id}", method = RequestMethod.POST)
    public String update(Product product){
        productService.update(product);
        return "redirect:/products?cid=" + product.getCid();
    }

    @RequestMapping(value = "products", method = RequestMethod.GET)
    public String list(int cid, Model model, Page page){
        Category c = categoryService.get(cid);
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List products = productService.list(cid);
        int total = (int)new PageInfo<>(products).getTotal();
        page.setTotal(total);
        page.setParam("&cid=" + c.getId());
        model.addAttribute("products", products);
        model.addAttribute("page", page);
        model.addAttribute("category", c);
        return "admin/listProduct";
    }
}
