<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>

<title>编辑属性</title>
<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="../../categories">所有分类</a></li>
        <li><a href="../../properties?cid=${property.category.id}">${property.category.name}</a></li>
        <li class="active">属性编辑</li>
    </ol>

    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑属性</div>
        <div class="panel-body">
            <form method="post" id="editForm" action="../../properties/${property.id}" enctype="multipart/form-data">
                <table class="editTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input type="text" value="${property.name}" id="name" name="name" class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                        <input type="hidden" name="id" value="${property.id}">
                        <input type="hidden" name="cid" value="${property.category.id}">
                        <button type="submit" class="btn btn-success">提交</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>