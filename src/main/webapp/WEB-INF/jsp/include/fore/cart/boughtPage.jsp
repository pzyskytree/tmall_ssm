<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<script>
var deleteOrder = false;
var deleteOrderId = 0;

$(function(){
    $("a[orderStatus]").click(function(){
        var orderStatus = $(this).attr("orderStatus");
        if('all'==orderStatus){
            $("table[orderStatus]").show();
        }
        else{
            $("table[orderStatus]").hide();
            $("table[orderStatus="+orderStatus+"]").show();
        }

        $("div.orderType div").removeClass("selectedOrderType");
        $(this).parent("div").addClass("selectedOrderType");
    });

    $("a.deleteOrderLink").click(function(){
        deleteOrderId = $(this).attr("oid");
        deleteOrder = false;
        $("#deleteConfirmModal").modal("show");
    });

    $("button.deleteConfirmButton").click(function(){
        deleteOrder = true;
        $("#deleteConfirmModal").modal('hide');
    });

    $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
        if(deleteOrder){
            var page="foreDeleteOrder";
            $.post(
                page,
                {"oid":deleteOrderId},
                function(result){
                    if("success"==result){
                        $("table.orderListItemTable[oid="+deleteOrderId+"]").hide();
                    }
                    else{
                        location.href="login.jsp";
                    }
                }
            );
        }
    })

    $(".ask2delivery").click(function(){
        var link = $(this).attr("link");
        $(this).hide();
        page = link;
        $.ajax({
               url: page,
               success: function(result){
                alert("卖家已秒发，刷新当前页面，即可进行确认收货")
               }
        });

    });
});

</script>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#nowhere">所有订单</a></div>
        <div><a  orderStatus="waitPay" href="#nowhere">待付款</a></div>
        <div><a  orderStatus="waitDelivery" href="#nowhere">待发货</a></div>
        <div><a  orderStatus="waitConfirm" href="#nowhere">待收货</a></div>
        <div><a  orderStatus="waitReview" href="#nowhere" class="noRightborder">待评价</a></div>
        <div class="orderTypeLastOne"><a class="noRightborder"> </a></div>
    </div>
    <div style="clear:both"></div>
    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </table>

    </div>

    <div class="orderListItem">
        <c:forEach items="${orders}" var="order">
            <table class="orderListItemTable" orderStatus="${order.status}" oid="${order.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></b>
                        <span>订单号: ${order.orderCode}</span>
                    </td>
                    <td  colspan="2"><img width="13px" src="${base_url}/img/site/orderItemTmall.png">天猫商场</td>
                    <td colspan="1">
                        <a class="wangwanglink" href="#nowhere">
                            <div class="orderItemWangWangGif"></div>
                        </a>
                    </td>
                    <td class="orderItemDeleteTD">
                        <a class="deleteOrderLink" oid="${order.id}" href="#nowhere">
                            <span  class="orderListItemDelete glyphicon glyphicon-trash"></span>
                        </a>
                    </td>
                </tr>
                <c:forEach items="${order.orderItems}" var="orderItem" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD"><img width="80" height="80" src="${base_url}/img/productSingleMiddle/${orderItem.product.firstProductImage.id}.jpg"></td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreProduct/${orderItem.product.id}">${orderItem.product.name}</a>
                                <div class="orderListItemProductLinkInnerDiv">
                                            <img src="${base_url}/img/site/creditcard.png" title="支持信用卡支付">
                                            <img src="${base_url}/img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                            <img src="${base_url}/img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>
                        </td>
                        <td  class="orderItemProductInfoPartTD" width="100px">
                            <div class="orderListItemProductOriginalPrice">￥<fmt:formatNumber type="number" value="${orderItem.product.originalPrice}" minFractionDigits="2"/></div>
                            <div class="orderListItemProductPrice">￥<fmt:formatNumber type="number" value="${orderItem.product.promotePrice}" minFractionDigits="2"/></div>
                        </td>
                        <c:if test="${st.count==1}">
                            <td valign="top" rowspan="${fn:length(order.orderItems)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">
                                <span class="orderListItemNumber">${order.totalNumber}</span>
                            </td>
                            <td valign="top" rowspan="${fn:length(order.orderItems)}" width="120px" class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD">
                                <div class="orderListItemProductRealPrice">￥<fmt:formatNumber  minFractionDigits="2"  maxFractionDigits="2" type="number" value="${order.total}"/></div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td valign="top" rowspan="${fn:length(order.orderItems)}" class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px">
                                <c:if test="${order.status=='waitConfirm' }">
                                    <a href="foreConfirmPay/${order.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                <c:if test="${order.status=='waitPay' }">
                                    <a href="foreAlipay?orderId=${order.id}&total=${order.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>

                                <c:if test="${order.status=='waitDelivery' }">
                                    <span>待发货</span>
    <%--                             <button class="btn btn-info btn-sm ask2delivery" link="orders/delivery/${order.id}">催卖家发货</button> --%>

                                </c:if>
                                <c:if test="${order.status=='waitReview' }">
                                    <a href="foreReview/${order.id}">
                                        <button  class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </c:forEach>
    </div>
</div>
