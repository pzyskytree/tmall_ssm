package org.pzy.tmall.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.github.pagehelper.PageHelper;
import org.pzy.tmall.comparator.*;
import org.pzy.tmall.pojo.*;
import org.pzy.tmall.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class ForeController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    ProductService productService;
    @Autowired
    UserService userService;
    @Autowired
    ProductImageService productImageService;
    @Autowired
    PropertyValueService propertyValueService;
    @Autowired
    PropertyService propertyService;
    @Autowired
    OrderService orderService;
    @Autowired
    OrderItemService orderItemService;
    @Autowired
    ReviewService reviewService;

    @RequestMapping(value = "home", method = RequestMethod.GET)
    public String home(HttpSession session){
        List<Category> categoryList = categoryService.list();
        productService.fill(categoryList);
        productService.fillByRow(categoryList);
        session.setAttribute("categories", categoryList);
        return "fore/home";
    }

    @RequestMapping(value = "foreRegister", method = RequestMethod.POST)
    public String register(Model model, User user){
        String name = user.getName();
        name =  HtmlUtils.htmlEscape(name);
        user.setName(name);
        boolean exist = userService.isExist(name);
        System.out.println(user.getName() + user.getName().length());
        if (exist) {
            String m = "The user name has been used";
            model.addAttribute("msg", m);
            model.addAttribute("user", null);
            return "fore/register";
        }
        userService.add(user);
        return "redirect:registerSuccessPage";
//        return "fore/registerSuccess";
    }

    @RequestMapping(value="foreLogin", method = RequestMethod.POST)
    public String login(Model model, HttpSession session, User user){
        String name = HtmlUtils.htmlEscape(user.getName());
        User newUser = userService.get(name, user.getPassword());
        if (null == newUser){
            model.addAttribute("msg", "Account or Password Error");
            return "fore/login";
        }
        session.setAttribute("user", newUser);
        return "redirect:home";
    }

    @RequestMapping(value="foreLogout", method= RequestMethod.GET)
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:home";
    }

    @RequestMapping(value = "foreProduct/{pid}", method=RequestMethod.GET)
    public String product(@PathVariable("pid") int pid, Model model){
        Product product = productService.get(pid);
        List<ProductImage> productSingleImages = productImageService.list(pid, ProductImageService.typeSingle);
        List<ProductImage> productDetailImages = productImageService.list(pid, ProductImageService.typeDetail);
        product.setProductSingleImages(productSingleImages);
        product.setProductDetailImages(productDetailImages);
        List<PropertyValue> propertyValues = propertyValueService.list(pid);
        List<Review> reviews = reviewService.list(pid);
        productService.setSaleAndReviewNumber(product);
        model.addAttribute("reviews", reviews);
        model.addAttribute("propertyValues", propertyValues);
        model.addAttribute("product", product);
        return "fore/product";
    }
    @RequestMapping(value = "foreCheckLogin", method = RequestMethod.GET)
    @ResponseBody
    public String checkLogin(HttpSession session){
        User user = (User)session.getAttribute("user");
        return (user == null ? "fail" : "success");
    }

    @RequestMapping(value = "foreLoginAjax", method = RequestMethod.GET)
    @ResponseBody
    public String loginAjax(@RequestParam("name") String name, @RequestParam("password") String password, HttpSession session){
        name = HtmlUtils.htmlEscape(name);
        User user = userService.get(name, password);
        if (null == user){
            return "fail";
        }
        session.setAttribute("user", user);
        return "success";
    }

    @RequestMapping(value = "foreCategory/{cid}", method = RequestMethod.GET)
    public String category(@PathVariable("cid") int cid, String sort, Model model){
        Category category = categoryService.get(cid);
        productService.fill(category);
        productService.setSaleAndReviewNumber(category.getProducts());
        if (null != sort){
            switch(sort){
                case "review":
                    Collections.sort(category.getProducts(), new ProductReviewComparator());
                    break;
                case "date":
                    Collections.sort(category.getProducts(), new ProductDateComparator());
                    break;
                case "saleCount":
                    Collections.sort(category.getProducts(), new ProductSaleCountComparator());
                    break;
                case "price":
                    Collections.sort(category.getProducts(), new ProductPriceComparator());
                    break;
                case "all":
                    Collections.sort(category.getProducts(), new ProductAllComparator());
                    break;
            }
        }
        model.addAttribute("category", category);
        return "fore/category";
    }

    @RequestMapping(value = "foreSearch", method = RequestMethod.POST)
    public String search(String keyword, Model model){
        PageHelper.offsetPage(0, 20);
        List<Product> products = productService.search(keyword);
        productService.setSaleAndReviewNumber(products);
        model.addAttribute("products", products);
        return "fore/searchResult";

    }

    @RequestMapping(value = "foreBuyone/{pid}", method = RequestMethod.GET)
    public String buyone(@PathVariable("pid") int pid, @RequestParam("num") int num, HttpSession session){
        Product product = productService.get(pid);
        int orderItemId = 0;

        User user = (User)session.getAttribute("user");
        boolean found = false;
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem : orderItems){
            if (orderItem.getProduct().getId().intValue() == pid){
                orderItem.setNumber(orderItem.getNumber() + num);
                orderItemService.update(orderItem);
                found = true;
                orderItemId = orderItem.getId();
                break;
            }
        }
        if (!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setUid(user.getId());
            orderItem.setPid(pid);
            orderItem.setNumber(num);
            orderItemService.add(orderItem);
            orderItemId = orderItem.getId();
        }
        return "redirect:/foreBuy/" + orderItemId;
    }

    @RequestMapping(value = "foreBuy/{orderItemId}", method = RequestMethod.GET)
    public String buy(@PathVariable("orderItemId") String[] orderItemIds, HttpSession session, Model model){
        List<OrderItem> orderItems = new ArrayList<>();
        float total = 0.0f;
        for (String strid : orderItemIds){
            int id = Integer.parseInt(strid);
            OrderItem orderItem = orderItemService.get(id);
            total += orderItem.getProduct().getPromotePrice() * orderItem.getNumber();
            orderItems.add(orderItem);
        }
        session.setAttribute("orderItems", orderItems);
        model.addAttribute("total", total);
        return "fore/buy";
    }

}
