<%@ page language = "java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>

<div class="reviewDiv">
    <div class="reviewProductInfoDiv">
        <div class="reviewProductInfoImg"><img width="400px" height="400px" src="${base_url}/img/productSingle/${product.firstProductImage.id}.jpg"></div>
        <div class="reviewProductInfoRightDiv">
            <div class="reviewProductInfoRightText">
                ${product.name}
            </div>
            <table class="reviewProductInfoTable">
                <tr>
                    <td width="75px">价格:</td>
                    <td><span class="reviewProductInfoTablePrice">￥<fmt:formatNumber type="number" value="${product.originalPrice}" minFractionDigits="2"/></span> 元 </td>
                </tr>
                <tr>
                    <td>配送</td>
                    <td>快递:  0.00</td>
                </tr>
                <tr>
                    <td>月销量:</td>
                    <td><span class="reviewProductInfoTableSellNumber">${product.saleCount}</span> 件</td>
                </tr>
            </table>

            <div class="reviewProductInfoRightBelowDiv">
                <span class="reviewProductInfoRightBelowImg"><img1 src="${base_url}/img/site/reviewLight.png"></span>
                <span class="reviewProductInfoRightBelowText" >现在查看的是 您所购买商品的信息
于<fmt:formatDate value="${order.createDate}" pattern="yyyy年MM月dd"/>下单购买了此商品 </span>

            </div>
        </div>
        <div style="clear:both"></div>
    </div>
    <div class="reviewStatisticsDiv">
        <div class="reviewStatisticsLeft">
                <div class="reviewStatisticsLeftTop"></div>
                <div class="reviewStatisticsLeftContent">累计评价 <span class="reviewStatisticsNumber"> ${product.reviewCount}</span></div>
                <div class="reviewStatisticsLeftFoot"></div>
        </div>
        <div class="reviewStatisticsRight">
            <div class="reviewStatisticsRightEmpty"></div>
            <div class="reviewStatisticsFoot"></div>
        </div>
    </div>

    <c:if test="${param.showOnly==true}">
    <div class="reviewDivListReviews">
        <c:forEach items="${reviews}" var="review">
            <div class="reviewDivListReviewsEach">
                <div class="reviewDate"><fmt:formatDate value="${review.createDate}" pattern="yyyy-MM-dd"/></div>
                <div class="reviewContent">${review.content}</div>
                <div class="reviewUserInfo pull-right">${review.user.anonymousName}<span class="reviewUserInfoAnonymous">(匿名)</span></div>
            </div>
        </c:forEach>
    </div>
    </c:if>

    <c:if test="${param.showOnly!=true}">
        <div class="makeReviewDiv">
        <form method="post" action="${base_url}/foreDoReview">
            <div class="makeReviewText">其他买家，需要你的建议哦！</div>
            <table class="makeReviewTable">
                <tr>
                    <td class="makeReviewTableFirstTD">评价商品</td>
                    <td><textarea name="content"></textarea></td>
                </tr>
            </table>
            <div class="makeReviewButtonDiv">
                <input type="hidden" name="oid" value="${order.id}">
                <input type="hidden" name="pid" value="${product.id}">
                <button type="submit">提交评价</button>
            </div>
        </form>
        </div>
    </c:if>
</div>