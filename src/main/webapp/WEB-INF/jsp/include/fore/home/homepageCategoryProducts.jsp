<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>

<c:if test="${empty param.categoryCount}">
    <c:set var="categoryCount" scope="page" value="100"/>
</c:if>

<c:if test="${!empty param.categoryCount}">
    <c:set var="categoryCount" scope="page" value="${param.categoryCount}"/>
</c:if>

<div class="homepageCategoryProducts">
    <c:forEach items="${categories}" var="category" varStatus="stc">
        <c:if test="${stc.count<=categoryCount}">
            <div class="eachHomepageCategoryProducts">
                <div class="left-mark"></div>
                <span class="categoryTitle">${category.name}</span>
                <br>
                <c:forEach items="${category.products}" var="product" varStatus="st">
                    <c:if test="${st.count<=5}">
                        <div class="productItem" >
                            <a href="foreProduct/${product.id}"><img width="100px" src="img/productSingleMiddle/${product.firstProductImage.id}.jpg"></a>
                            <a class="productItemDescLink" href="foreProduct/${product.id}">
                                <span class="productItemDesc">[热销]
                                ${fn:substring(product.name, 0, 20)}
                                </span>
                            </a>
                            <span class="productPrice">
                                <fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                            </span>
                        </div>
                    </c:if>
                </c:forEach>
                <div style="clear:both"></div>
            </div>
        </c:if>
    </c:forEach>

    <img id="endpng" class="endpng" src="img/site/end.png">

</div>