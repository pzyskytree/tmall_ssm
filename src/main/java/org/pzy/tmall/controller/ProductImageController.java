package org.pzy.tmall.controller;

import org.pzy.tmall.pojo.Product;
import org.pzy.tmall.pojo.ProductImage;
import org.pzy.tmall.service.ProductImageService;
import org.pzy.tmall.service.ProductService;
import org.pzy.tmall.util.ImageUtil;
import org.pzy.tmall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("")
public class ProductImageController {
    @Autowired
    ProductService productService;
    @Autowired
    ProductImageService productImageService;

    @RequestMapping(value = "productImages", method = RequestMethod.POST)
    public String add(ProductImage productImage, HttpSession session, UploadedImageFile uploadedImageFile){
        productImageService.add(productImage);
        String imageName = productImage.getId() + ".jpg",imageFolder, imageFolderSmall = null, imageFolderMiddle = null;
        if (productImageService.typeSingle.equals(productImage.getType())){
            imageFolder = session.getServletContext().getRealPath("img/productSingle");
            imageFolderSmall = session.getServletContext().getRealPath("img/productSingleSmall");
            imageFolderMiddle = session.getServletContext().getRealPath("img/productSingleMiddle");
        }else{
            imageFolder = session.getServletContext().getRealPath("img/productDetail");
        }
        File img = new File(imageFolder, imageName);
        img.getParentFile().mkdirs();
        try{
            uploadedImageFile.getImage().transferTo(img);
            BufferedImage bufferedImage = ImageUtil.changeToJpg(img);
            ImageIO.write(bufferedImage,"jpg", img);
            if (productImageService.typeSingle.equals(productImage.getType())){
                File smallImage = new File(imageFolderSmall, imageName);
                File middleImage = new File(imageFolderMiddle, imageName);
                ImageUtil.resizeImage(img, 56, 56, smallImage);
                ImageUtil.resizeImage(img, 217, 190, middleImage);
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return "redirect:/productImages?pid=" + productImage.getPid();
    }

    @RequestMapping(value = "productImages/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") int id, HttpSession session){
        ProductImage productImage = productImageService.get(id);
        String imageName = productImage.getId() + ".jpg";
        String imageFolder, imageFolderSmall = null, imageFolderMiddle = null;
        if (productImageService.typeSingle.equals(productImage.getType())){
            imageFolder = session.getServletContext().getRealPath("img/productSingle");
            imageFolderSmall = session.getServletContext().getRealPath("img/productSingleSmall");
            imageFolderMiddle = session.getServletContext().getRealPath("img/productSingleMiddle");
            File image = new File(imageFolder, imageName);
            File imageSmall = new File(imageFolderSmall, imageName);
            File imageMiddle = new File(imageFolderMiddle, imageName);
            image.delete();
            imageSmall.delete();
            imageMiddle.delete();
        }
        else{
            imageFolder = session.getServletContext().getRealPath("img/productDetail");
            File image = new File(imageFolder, imageName);
            image.delete();
        }
        productImageService.delete(id);
        return "redirect:/productImages?pid=" + productImage.getPid();
    }

    @RequestMapping(value = "productImages", method = RequestMethod.GET)
    public String list(int pid, Model model){
        Product product = productService.get(pid);
        List singleProductImages = productImageService.list(pid, productImageService.typeSingle);
        List detailProductImages = productImageService.list(pid, productImageService.typeDetail);
        model.addAttribute("product", product);
        model.addAttribute("singleProductImages", singleProductImages);
        model.addAttribute("detailProductImages", detailProductImages);
        return "admin/listProductImage";
    }


}
