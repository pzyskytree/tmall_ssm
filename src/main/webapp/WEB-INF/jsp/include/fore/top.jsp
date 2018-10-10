<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>
<nav class="top" >
    <a href="home">
        <span style="color:#C40000;margin:0px" class=" glyphicon glyphicon-home redColor"></span>
        Tmall HomePage
    </a>

    <span>Welcome to Tmall</span>
    <c:if test="${!empty user}">
        <a href="loginPage">${user.name}</a>
        <a href="foreLogout">Logout</a>
    </c:if>
    <c:if test="${empty user}">
        <a href="loginPage">Login</a>
        <a href="registerPage">Register</a>
    </c:if>
    <span class="pull-right">
        <a href="foreBought">My Order List</a>
        <a href="foreCart"> <span style="color:#C40000;margin:0px" class="glyphicon glyphicon-shopping-cart redColor">
                            </span>Cart <strong>${cartTotalItemNumber}</strong> items</a>
    </span>
</nav>