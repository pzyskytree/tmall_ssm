<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function(){
        $("button.orderPageCheckOrderItems").click(function(){
            var oid = $(this).attr("oid");
            $("tr.orderPageOrderItemTR[oid="+oid+"]").toggle();
        });
    });

</script>

<title>订单管理</title>

<div class="workingArea">
    <h1 class="label label-info" >订单管理</h1>
    <br>
    <br>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover1  table-condensed">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>状态</th>
                    <th>金额</th>
                    <th width="100px">商品数量</th>
                    <th width="100px">买家名称</th>
                    <th>创建时间</th>
                    <th>支付时间</th>
                    <th>发货时间</th>
                    <th>确认收货时间</th>
                    <th width="120px">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.statusDesc}</td>
                        <td>￥<fmt:formatNumber type="number" value="${order.total}" minFractionDigits="2"/></td>
                        <td align="center">${order.totalNumber}</td>
                        <td align="center">${order.user.name}</td>

                        <td><fmt:formatDate value="${order.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${order.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${order.confirmDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

                        <td>
                            <button oid=${order.id} class="orderPageCheckOrderItems btn btn-primary btn-xs">查看详情</button>

                            <c:if test="${order.status=='waitDelivery'}">
                                <a href="orders/delivery/${order.id}">
                                    <button class="btn btn-primary btn-xs">发货</button>
                                </a>
                            </c:if>
                        </td>
                    </tr>
                    <tr class="orderPageOrderItemTR"  oid=${order.id}>
                        <td colspan="10" align="center">

                            <div  class="orderPageOrderItem">
                                <table width="800px" align="center" class="orderPageOrderItemTable">
                                    <c:forEach items="${order.orderItems}" var="orderItem">
                                        <tr>
                                            <td align="left">
                                                <img width="40px" height="40px" src="img/productSingle/${orderItem.product.firstProductImage.id}.jpg">
                                            </td>

                                            <td>
                                                <a href="foreProduct/${orderItem.product.id}">
                                                    <span>${orderItem.product.name}</span>
                                                </a>
                                            </td>
                                            <td align="right">

                                                <span class="text-muted">${orderItem.number}个</span>
                                            </td>
                                            <td align="right">

                                                <span class="text-muted">单价：￥${orderItem.product.promotePrice}</span>
                                            </td>

                                        </tr>
                                    </c:forEach>

                                </table>
                            </div>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>

</div>

<%@include file="../include/admin/adminFooter.jsp"%>