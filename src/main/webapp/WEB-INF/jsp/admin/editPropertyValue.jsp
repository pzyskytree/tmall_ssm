<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" import="java.util.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/admin/adminNavigator.jsp"%>


<script>
$(function(){
    $("input.pvValue").keyup(function(){
        var id = $(this).attr("pvid");
        var value = $(this).val();
        var page = "../../propertyValues/${product.id}";
        var parentSpan = $(this).parent("span");
        parentSpan.css("border", "1px solid yellow");
        $.post(

            page,
            {"value": value, "id" : id},
            function(result){
                if (result == "success")
                    parentSpan.css("border", "1px solid green");
                else
                    parentSpan.css("border", "1px solid red");
            }
        );
    });
});

</script>

<div class="workingArea">
    <ol class="breadcrumb">
      <li><a href="../../categories">所有分类</a></li>
      <li><a href="../../products?cid=${product.category.id}">${product.category.name}</a></li>
      <li class="active">${product.name}</li>
      <li class="active">编辑产品属性</li>
    </ol>

    <div class="editPVDiv">
        <c:forEach items="${propertyValues}" var="propertyValue">
            <div class="eachPV">
                <span class="pvName" >${propertyValue.property.name}</span>
                <span class="pvValue"><input class="pvValue" pvid="${propertyValue.id}" type="text" value="${propertyValue.value}"></span>
            </div>
        </c:forEach>
    <div style="clear:both"></div>
    </div>

</div>