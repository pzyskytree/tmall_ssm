<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<title>Mock Tmall ${product.name}</title>
<div class="categoryPictureInProductPageDiv">
    <img class="categoryPictureInProductPage" src="${base_url}/img/category/${product.category.id}.jpg">
</div>
<div class="productPageDiv">
    <%@include file="imgAndInfo.jsp"%>
    <%@include file="productReview.jsp"%>
    <%@include file="productDetail.jsp"%>
</div>