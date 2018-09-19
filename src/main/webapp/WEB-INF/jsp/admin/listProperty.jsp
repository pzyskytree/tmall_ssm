<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function(){
        $("#propertyAddForm").submit(function(){
            console.log("hh");
            if (isEmpty("name", "Property's Name")){
               console.log("empty");
                return false;
            }
            return true;
        });
    });
</script>

<title>属性管理</title>

<div class="workingArea">
    <ol class = "breadcrumb">
        <li><a href="categories">所有分类</a></li>
        <li><a href="properties?cid=${category.id}">${category.name}</a></li>
        <li class="active">属性管理</li>
    </ol>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
                <tr class="success">
                    <td>ID</td>
                    <td>属性名称</td>
                    <td>编辑</td>
                    <td>删除</td>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${properties}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.name}</td>
                        <td><a href="properties/${p.id}/edit"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true" class="property" href="properties/${p.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp" %>
    </div>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增属性</div>
        <div class="panel-body">
            <form method="post" action="properties" id="propertyAddForm" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input id="name" name="name" type="text" class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="cid" value="${category.id}">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@include file="../include/admin/adminFooter.jsp"%>