<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<script>
$(function(){
    <c:if test="${!empty msg}">
        $("span.errorMessage").html("${msg}");
        $("div.registerErrorMessageDiv").css("visibility", "visible");
    </c:if>
    $(".registerForm").submit(function(){
        if (0 == $("#userName").val().length){
            $("span.errorMessage").html("User Name cannot be empty");
            $("div.registerErrorMessageDiv").css("visibility", "visible");
            return false;
        }
        if (0 == $("#userPassword").val().length){
             $("span.errorMessage").html("Password cannot be empty");
             $("div.registerErrorMessageDiv").css("visibility", "visible");
             return false;
        }
        if (0 == $("#repeatPassword").val().length){
             $("span.errorMessage").html("Repeate Password cannot be empty");
             $("div.registerErrorMessageDiv").css("visibility", "visible");
             return false;
        }
        if ($("#userPassword").val() != $("#repeatPassword").val()){
             console.log($("#userPassword").val());
             console.log($("#repeatPassword").val());
             $("span.errorMessage").html("Passwords do not match");
             $("div.registerErrorMessageDiv").css("visibility", "visible");
             return false;
        }
        return true;
    });
})
</script>

<form action="foreRegister" method="post" class="registerForm">

    <div class="registerDiv">
        <div class="registerErrorMessageDiv">
            <div class="alert alert-danger" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                <span class="errorMessage"></span>
            </div>
        </div>
        <table class="registerTable" align="center">
            <tr>
                <td class="registerTip registerTableLeftTD">Set Member Name</td>
            </tr>
            <tr>
                <td class="registerTableLeftTD">User Name</td>
                <td class="registerTableRightTD"><input id="userName" name="name"
                        placeholder="Once user name is submitted successful, it cannot be changed"></td>
            </tr>
            <tr>
                <td  class="registerTip registerTableLeftTD">Set Password</td>
                <td  class="registerTableRightTD">Login authentication, protect users information</td>
            </tr>
            <tr>
                <td class="registerTableLeftTD">Password</td>
                <td class="registerTableRightTD"><input id="userPassword" name="password" type="password"  placeholder="Set your password"> </td>
            </tr>
            <tr>
                <td class="registerTableLeftTD">Repeat Your Password</td>
                <td class="registerTableRightTD"><input id="repeatPassword" type="password"   placeholder="Please type your password again" > </td>
            </tr>
            <tr>
                <td colspan="2" class="registerButtonTD">
                    <a href="registerSuccess.jsp"><button>Submit</button></a>
                </td>
            </tr>
        </table>
    </div>
</form>