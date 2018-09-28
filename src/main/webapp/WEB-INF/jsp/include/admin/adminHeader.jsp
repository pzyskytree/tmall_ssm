<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<c:set var="base_url" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}" />
<html>
<head>
    <script src="${base_url}/js/jquery/2.0.0/jquery.min.js"></script>
    <link href="${base_url}/css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="${base_url}/js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="${base_url}/css/back/style.css" rel="stylesheet">
<script>

 function isEmpty(id, name){
    var value = $("#" + id).val();
    if (value.length == 0){
        alert(name + " Cannot be empty");
        $("#" + id)[0].focus();
        return true;
    }
    return false;
 }

 function checkNumber(id, name){
    if (!checkEmpty(id, name))
        return false;
    var value = $("#" + id).val();
    if (isNaN(value)){
        alert(name + " Must be number");
        $("#" + id)[0].focus();
        return false;
    }
    return true;
 }

 function checkInt(id, name){
    if (!checkEmpty(id, name))
        return false;
    var value = $("#" + id).val();
    if (parseInt(value) != value){
        alert(name + " Must be an integer");
        $("#" + id)[0].focus();
        return false;
    }
    return true;
 }

 $(function(){
    $("a").click(function(){
        var deleteLink = $(this).attr("deleteLink");
        console.log(deleteLink);
        if ("true" == deleteLink){
            var confirmDelete = confirm("Confirm to delete");
            if (confirmDelete){
                var href = $(this).attr("href");
                $("#DeleteForm").attr("action", href).submit();
            }
            return false;
        }
        return true;
    });
 });
 </script>
 </head>
 <body>
   <form method="post" action="" id="DeleteForm">
        <input type="hidden" name="_method" value="DELETE">
   </form>

