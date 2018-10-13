<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>
<nav class="top" >
    <a href="${base_url}/home">
        <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
        Tmall HomePage
    </a>

    <span>Welcome to Tmall</span>
    <c:if test="${!empty user}">
        <a href="${base_url}/loginPage">${user.name}</a>
        <a href="${base_url}/foreLogout">Logout</a>
    </c:if>
    <c:if test="${empty user}">
        <a href="${base_url}/loginPage">Login</a>
        <a href="${base_url}/registerPage">Register</a>
    </c:if>
    <span class="pull-right">
        <a href="${base_url}/foreBought">My Order List</a>
        <a href="${base_url}/foreCart"> <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-shopping-cart redColor">
                            </span>Cart <strong>${cartTotalItemNumber}</strong> items</a>
    </span>
</nav>