<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../include/admin/adminHeader.jsp" %>
<%@include file="../include/admin/adminNavigator.jsp" %>

<script>
$(function(){
    $("#categoryAddForm").submit(function(){
        if (isEmpty("name", "Class Name" || isEmpty("categoryPic", "Class Picture"))
            return false;
        return true;
    });
});
</script>
<title>分类管理</title>

<div class="workingArea">
    <h1 class="label label-info">分类管理</h1>
    <br>
    <br>
    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
                <tr class="success">
                    <td>ID</td>
                    <td>图片</td>
                    <td>分类名称</td>
                    <td>属性管理</td>
                    <td>产品管理</td>
                    <td>编辑</td>
                    <td>删除</td>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${cs}" var="c">
                    <tr>
                        <td>${c.id}</td>
                        <td><img height="40px" src="img/category/${c.id}.jpg"></td>
                        <td>${c.name}</td>

                        <td><a href="properties?cid=${c.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                        <td><a href="products?cid=${c.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>
                        <td><a href="categories/${c.id}/edit"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td>
                            <a deleteLink="true" class="category" href="categories/${c.id}"><span class="glyphicon glyphicon-trash"></span></a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <%--Page--%>
    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增分类</div>
        <div class="panel-body">
            <form method="post" id="categoryAddForm" action="categories" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input id="name" type="text" class="form-control" name="name"></td>
                    </tr>
                    <tr>
                        <td>分类图片</td>
                        <td>
                            <input id="categoryPic" type="file" accept="image/*"  name="image"/>
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="submit" class="btn btn-success">提 交</button>
                        </td>
                    <tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp" %>

