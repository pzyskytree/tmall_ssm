<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<script>
    $(function(){
        <c:if test="${!empty msg}">
            $("span.errorMessage").html("${msg}");
            $("div.loginErrorMessageDiv").show();
        </c:if>

        $("form.loginForm").submit(function(){
            if (0 == $("#userName").val().length || 0 == $("#userPassword").val().length){
                $("span.errorMessage").html("Username and password cannot be empty");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            return true;
        });

        $("form.loginForm input").keyup(function(){
            $("div.loginErrorMessageDiv").hide();
        });

        var left = window.innerWidth / 2 + 162;
        $("div.loginSmallDiv").css("left", left);
    })
</script>

<div id="loginDiv" style="position: relative">
    <div class="simpleLogo">
        <a href="${contextPath}"><img src="img/site/simpleLogo.png"></a>
    </div>

    <!-- Back Ground Image -->
    <img id = "loginBackgroundImg" class="loginBackgroundImg" src="img/site/loginBackground.png">

    <!--Login Form-->
    <form class="loginForm" action="foreLogin" method="post">
        <div id ="loginSmallDiv" class="loginSmallDiv">
            <!--Error Message-->
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger"
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                    <span class="errorMessage"></span>
                </div>
            </div>

            <!-- Account Number -->
            <div class="login_account_text">Account Login</div>
            <div class="loginInput ">
                <span class="loginInputIcon" >
                    <span class="glyphicon glyphicon-user"></span>
                </span>
                <input id="userName" name="name" placeholder="Phone Number/Member/EMail" type="text">
            </div>

            <!-- Password -->

            <div class="loginInput ">
                <span class="loginInputIcon ">
                    <span class="glyphicon glyphicon-lock"></span>
                </span>
                <input id="userPassword"  name="password" placeholder="Password" type="password">
            </div>
            <span class="text-danger">Please do not type the real Tmall password</span><br><br>

            <div>
                <a class="notImplementLink" href="#nowhere">Forget Password</a>
                <a href="registerPage" class="pull-right">Register</a>
            </div>
            <div style="margin-top:20px">
                <button class="btn btn-block redButton" type="submit">Login</button>
            </div>
        </div>
    </form>
</div>