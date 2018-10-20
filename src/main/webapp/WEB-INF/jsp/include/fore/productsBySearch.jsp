<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored = "false"%>
<div class="searchProducts">
    <c:forEach items ="${products}" var = "product">
        <div class = "productUnit" price = "${product.promotePrice}">
            <a href="foreProduct/${product.id}">
                <img class="productImage" src = "${base_url}/img/productSingle/${product.firstProductImage.id}.jpg">
            </a>
            <span class="productPrice">￥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/></span>
            <a class="productLink" href="foreProduct/${product.id}">
                ${fn:substring(product.name, 0, 50)}
            </a>
            <a class="tmallLink" href="foreProduct/${product.id}">Tmall Special Sale</span>

            <div class="productInfo">
                <span class="monthDeal">月成交<span class="productDealNumber">${product.saleCount}笔</span></span>
                <span class="productReview">评价<span class="productReviewNumber">${product.reviewCount}</span></span>
                <span class="wangwang"><img src="${base_url}/img/site/wangwang.png"></span>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty products}">
        <div class="noMath">No Matching Products<div>
    </c:if>
    <div style="clear:both"></div>
</div>
