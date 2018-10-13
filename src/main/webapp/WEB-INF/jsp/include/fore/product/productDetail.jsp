<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>

<div class="productDetailDiv" >
    <div class="productDetailTopPart">
        <a href="#nowhere" class="productDetailTopPartSelectedLink selected">商品详情</a>
        <a href="#nowhere" class="productDetailTopReviewLink">累计评价<span class="productDetailTopReviewLinkNumber">${product.reviewCount}</span> </a>
    </div>

    <div class="productParamterPart">
        <div class="productParamter">Product Property：</div>

        <div class="productParamterList">
            <c:forEach items="${propertyValues}" var="propertyValue">
                <span>${propertyValue.property.name}:  ${fn:substring(propertyValue.value, 0, 10)} </span>
            </c:forEach>
        </div>
        <div style="clear:both"></div>
    </div>

    <div class="productDetailImagesPart">
            <c:forEach items="${product.productDetailImages}" var="productImage">
                <img src="${base_url}/img/productDetail/${productImage.id}.jpg">
            </c:forEach>
    </div>
</div>