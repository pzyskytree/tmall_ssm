<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>

<div class="productReviewDiv" >
    <div class="productReviewTopPart">
        <a  href="#nowhere" class="productReviewTopPartSelectedLink">商品详情</a>
        <a  href="#nowhere" class="selected">累计评价<span class="productReviewTopReviewLinkNumber">${product.reviewCount}</span> </a>
    </div>

    <div class="productReviewContentPart">
        <c:forEach items="${reviews}" var="review">
            <div class="productReviewItem">
                <div class="productReviewItemDesc">
                    <div class="productReviewItemContent">
                        ${review.content }
                    </div>
                    <div class="productReviewItemDate"><fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd"/></div>
                </div>
                <div class="productReviewItemUserInfo">
                    ${review.user.anonymousName}<span class="userInfoGrayPart">（Anonymous）</span>
                </div>
                <div style="clear:both"></div>
            </div>
        </c:forEach>
    </div>
</div>