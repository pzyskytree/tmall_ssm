package org.pzy.tmall.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.pzy.tmall.pojo.Category;
import org.pzy.tmall.service.CategoryService;
import org.pzy.tmall.util.ImageUtil;
import org.pzy.tmall.util.Page;
import org.pzy.tmall.util.UploadedImageFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @RequestMapping(value = "categories", method = RequestMethod.GET)
    public String list(Model model, Page page){
        PageHelper.offsetPage(page.getStart(), page.getCount());
        List<Category> cs = categoryService.list();
        if (page.getTotal() == 0){
            page.setTotal((int)new PageInfo<>(cs).getTotal());
        }
        model.addAttribute("page", page);
        model.addAttribute("cs", cs);
        return "admin/listCategory";
    }

    @RequestMapping(value = "categories", method = RequestMethod.POST)
    public String add(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws IOException{
        categoryService.add(category);
        //Set image folder and file;
        File imageFolder = new File(session.getServletContext().getRealPath("img/category"));
        File file = new File(imageFolder, category.getId() + ".jpg");
        if (!file.getParentFile().exists())
            file.getParentFile().mkdirs();
        //Transfer uploaded image into image file
        uploadedImageFile.getImage().transferTo(file);
        //change file to jpg format
        BufferedImage image = ImageUtil.changeToJpg(file);
        ImageIO.write(image, "jpg", file);
        return "redirect:/categories";
    }


    @RequestMapping(value = "categories/{id}", method = RequestMethod.DELETE)
    public String delete(@PathVariable("id") int id, HttpSession session){
        categoryService.delete(id);
        File imageFolder = new File(session.getServletContext().getRealPath("img/category"));
        File image = new File(imageFolder, id + ".jpg");
        image.delete();
        return "redirect:/categories";
    }


    @RequestMapping(value = "categories/{id}/edit", method = RequestMethod.GET)
    public String edit(@PathVariable("id") int id, Model model){
        Category category =  categoryService.get(id);
        model.addAttribute("category", category);
        return "admin/editCategory";
    }


    //Further improve
    @RequestMapping(value = "categories/{id}", method = RequestMethod.POST)
    public String update(Category category, HttpSession session, UploadedImageFile uploadedImageFile) throws IOException{
        categoryService.update(category);
        MultipartFile image = uploadedImageFile.getImage();
        if (image != null && !image.isEmpty()) {
            File imageFolder = new File(session.getServletContext().getRealPath("img/category"));
            File file = new File(imageFolder, category.getId() + ".jpg");
            image.transferTo(file);
            BufferedImage bufferedImage = ImageUtil.changeToJpg(file);
            ImageIO.write(bufferedImage, "jpg", file);
        }
        return "redirect:/categories";
    }
}
