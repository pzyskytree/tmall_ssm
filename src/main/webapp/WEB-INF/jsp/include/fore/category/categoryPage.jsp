<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<title>Mock Tmall-${category.name}</title>
<div id="category">
    <div class="categoryPageDiv">
        <img src="${base_url}/img/category/${category.id}.jpg">
        <%@include file="sortBar.jsp"%>
        <%@include file="productsByCategory.jsp"%>
    </div>
</div>