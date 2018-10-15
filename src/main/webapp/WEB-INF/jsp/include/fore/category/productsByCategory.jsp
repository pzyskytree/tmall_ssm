<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<c:if test="${empty param.categoryCount}">
    <c:set var="categoryCount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categoryCount}">
    <c:set var="categoryCount" scope="page" value="${param.categoryCount}"/>
</c:if>

<div class="categoryProducts">
    <c:forEach items="${category.products}" var="product" varStatus="stc">
        <c:if test="${stc.count <= categoryCount}">
            <div class="productUnit" price="${product.promotePrice}">
                <div class="productUnitFrame">
                    <a href="${base_url}/foreProduct/${product.id}">
                        <img class="productImage" src="${base_url}/img/productSingleMiddle/${product.firstProductImage.id}.jpg">
                    </a>
                    <span class="productPrice">¥<fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/></span>
                    <a class="productLink" href="${base_url}/foreProduct/${product.id}">
                     ${fn:substring(p.name, 0, 50)}
                    </a>

                    <a  class="tmallLink" href="${base_url}/foreProduct/${p.id}">天猫专卖</a>

                    <div class="show1 productInfo">
                        <span class="monthDeal ">月成交 <span class="productDealNumber">${product.saleCount}笔</span></span>
                        <span class="productReview">评价<span class="productReviewNumber">${product.reviewCount}</span></span>
                        <span class="wangwang">
                        <a class="wangwanglink" href="#nowhere">
                            <img src="${base_url}/img/site/wangwang.png">
                        </a>

                        </span>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
        <div style="clear:both"></div>