package org.pzy.tmall.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import com.github.pagehelper.PageHelper;
import org.apache.commons.lang.math.RandomUtils;
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
    public String home(Model model){
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

    @RequestMapping(value = "foreBuy", method = RequestMethod.GET)
    public String buy(@RequestParam("oiId") String[] orderItemIds, HttpSession session, Model model){
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

    @RequestMapping(value = "foreAddCart", method = RequestMethod.GET)
    @ResponseBody
    public String addCart(@RequestParam("pid") int pid, @RequestParam("num") int num, Model model, HttpSession session){
        Product product = productService.get(pid);
        User user = (User)session.getAttribute("user");
        boolean found = false;
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem : orderItems){
            if (orderItem.getPid().intValue() == pid){
                orderItem.setNumber(orderItem.getNumber() + num);
                orderItemService.update(orderItem);
                found = true;
                break;
            }
        }
        if (!found){
            OrderItem orderItem = new OrderItem();
            orderItem.setNumber(num);
            orderItem.setUid(user.getId());
            orderItem.setPid(pid);
            orderItemService.add(orderItem);
        }
        return "success";
    }

    @RequestMapping(value = "foreCart", method = RequestMethod.GET)
    public String cart(Model model, HttpSession session){
        User user = (User) session.getAttribute("user");
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        model.addAttribute("orderItems", orderItems);
        return "/fore/cart";
    }

    @RequestMapping(value = "foreChangeOrderItem", method=RequestMethod.POST)
    @ResponseBody
    public String changeOrderItem(HttpSession session, @RequestParam("pid") int pid,  @RequestParam("number") int number){
        User user = (User) session.getAttribute("user");
        if (null == user){
            return "fail";
        }
        List<OrderItem> orderItems = orderItemService.listByUser(user.getId());
        for (OrderItem orderItem : orderItems){
            if (orderItem.getPid() == pid){
                orderItem.setNumber(number);
                orderItemService.update(orderItem);
                break;
            }
        }
        return "success";
    }

    @RequestMapping(value = "foreDeleteOrderItem", method = RequestMethod.POST)
    @ResponseBody
    public String deleteOrderItem(HttpSession session,  @RequestParam("oiId") int orderItemId){
        User user = (User) session.getAttribute("user");
        if (null == user)
            return "fail";
        orderItemService.delete(orderItemId);
        return "success";
    }

    @RequestMapping(value="foreCreateOrder", method=RequestMethod.POST)
    public String createOrder(Model model, Order order, HttpSession session){
        User user = (User)session.getAttribute("user");
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt();
        order.setOrderCode(orderCode);
        order.setCreateDate(new Date());
        order.setUid(user.getId());
        order.setStatus(OrderService.waitPay);
        List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("orderItems");
        float total = orderService.add(order, orderItems);
        return "redirect:foreAlipay?orderId=" + order.getId() + "&total=" + total;
    }

    @RequestMapping(value = "forePayed", method = RequestMethod.GET)
    public String payer(Model model, @RequestParam("orderId") int orderId, @RequestParam("total") float total){
        Order order = orderService.get(orderId);
        order.setStatus(OrderService.waitDelivery);
        order.setPayDate(new Date());
        orderService.update(order);
        model.addAttribute("order", order);
        return "fore/payed";
    }


}
