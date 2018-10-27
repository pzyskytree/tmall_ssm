<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>

<div class="aliPayPageDiv">
    <div class="aliPayPageLogo">
        <img class="pull-left" src="${base_url}/img/site/simpleLogo.png">
        <div style="clear:both"></div>
    </div>

    <div>
        <span class="confirmMoneyText">Scan for Pay</span>
        <span class="confirmMoney">$
        <fmt:formatNumber type="number" value="${param.total}" minFractionDigits="2"/></span>
    </div>

    <div>
        <img class="aliPayImg" src="${base_url}/img/site/alipay2wei.png">
    </div>
    <div>
        <a href="forePayed?orderId=${param.orderId}&total=${param.total}"><button class="confirmPay">Confirm Pay</button></a>
    </div>
</div>