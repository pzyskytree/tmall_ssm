<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<script>
$(function(){
    var stock = ${product.stock};
    //Set Amount
    $(".productNumberSetting").keyup(function(){
        var num = $(".productNumberSetting").val();
        num = parseInt(num);
        if (isNaN(num) || num <= 0){
            num = 1;
        }
        if (num > stock)
            num = stock;
        $(".productNumberSetting").val(num);
    });
    //Add one to amount
    $(".increaseNumber").click(function(){
        var num = $(".productNumberSetting").val();
        num++;
        if (num > stock){
            num = stock;
        }
        $(".productNumberSetting").val(num);
    });
    //Minus one to amount
    $(".decreaseNumber").click(function(){
        var num = $(".productNumberSetting").val();
        num--;
        if (num <= 0){
            num = 1;
        }
        $(".productNumberSetting").val(num);
    });
    //Add to chart
    $(".addCartLink").click(function(){
       var page = "foreCheckLogin";
       $.get(
            page,
            function(result){
                if ("success" == result){
                    var pid = ${product.id};
                    var num = $(".productNumberSetting").val();
                    var addChartPage = "foreAddCart";
                    $.get(
                        addCartPage,
                        {"pid": pid, "num": num},
                        function(result){
                            if ("success" == result){
                                $(".addCartButton").html("Already add to cart");
                                $(".addCartButton").attr("disabled", "disabled");
                                $(".addCartButton").css("background-color", "lightgray");
                                $(".addCartButton").css("border-color", "lightgray");
                                $(".addCartButton").css("color", "black");
                            }
                        }
                    )
                }else{
                    $("#loginModal").modal("show");
                }
            }
       );
       //Prevent redirect to another page
       return false;
    });
    //Buy Product
    $(".buyLink").click(function(){
        var page = "foreCheckLogin";
        $.get(
            page,
            function(result){
                if ("success" == result){
                    var num = $(".productNumberSetting").val();
                    location.href = $(".buyLink").attr("href") + "&num=" + num;
                }else{
                    $("#loginModal").modal("show");
                }
            }
        );
        return false;
    });
    //Login
    $("button.loginSubmitButton").click(function(){
        var name = $("#name").val();
        var password = $("#password").val();

        if (0 == name.length || 0 == password.length){
            $("span.errorMessage").html("Please Type Account and Password");
            $("div.loginErrorMessageDiv").show();
            return false;
        }

        var page = "foreLoginAjax";

        $.get(
            page,
            {"name" : name, "password": password},
            function(result){
                if ("success" == result){
                    location.reload();
                }
                else{
                    $("span.errorMessage").html("Account or Password is wrong");
                    $("div.loginErrorMessageDiv").show();
                }
            }
        );
        return true;
    });
    //Small Images detail
    $("img.smallImage").mouseenter(function(){
        var bigImageURL = $(this).attr("bigImageURL");
        $("img.bigImg").attr("src", bigImageURL);
    });
    //Load big image
    $("img.bigImg").load(function(){
        $("img.smallImage").each(function(){
            var bigImageURL = $(this).attr("bigImageURL");
            img = new Image();
            img.src = bigImageURL;
            img.onload = function(){
                console.log(bigImageURL);
                $("div.img4load").append($(img));
            }
        });
    });
});
</script>

<div class="imgAndInfo">
    <div class="imgInimgAndInfo">
        <img src="${base_url}/img/productSingle/${product.firstProductImage.id}.jpg" class="bigImg">
        <div class="smallImageDiv">
            <c:forEach items="${product.productSingleImages}" var = "productImage">
                <img src = "${base_url}/img/productSingleSmall/${productImage.id}.jpg" bigImageURL = "${base_url}/img/productSingle/${productImage.id}.jpg"
                class = "smallImage">
            </c:forEach>
        </div>
        <div class="img4load hidden"></div>
    </div>
    <div class="infoInimgAndInfo">
        <div class="productTitle">
            ${product.name}
        </div>
        <div class="productSubTitle">
            ${product.subTitle}
        </div>
        <div class="productPrice">
            <div class="juhuasuan">
                <span class="juhuasuanBig" >聚划算</span>
                <span>此商品即将参加聚划算，<span class="juhuasuanTime">1天19小时</span>后开始，</span>
            </div>
            <div class="productPriceDiv">
                <div class="gouwujuanDiv"><img height="16px" src="${base_url}/img/site/gouwujuan.png">
                    <span> 全天猫实物商品通用</span>
                </div>
                <div class="originalDiv">
                    <span class="originalPriceDesc">价格</span>
                    <span class="originalPriceYuan">¥</span>
                    <span class="originalPrice">
                        <fmt:formatNumber type="number" value="${product.originalPrice}" minFractionDigits="2"/>
                    </span>
                </div>
                <div class="promotionDiv">
                    <span class="promotionPriceDesc">促销价 </span>
                    <span class="promotionPriceYuan">¥</span>
                    <span class="promotionPrice">
                        <fmt:formatNumber type="number" value="${product.promotePrice}" minFractionDigits="2"/>
                    </span>
                </div>
            </div>
        </div>
        <div class="productSaleAndReviewNumber">
            <div>销量 <span class="redColor boldWord"> ${product.saleCount }</span></div>
            <div>累计评价 <span class="redColor boldWord"> ${product.reviewCount}</span></div>
        </div>
        <div class="productNumber">
            <span>数量</span>
            <span>
                <span class="productNumberSettingSpan">
                <input class="productNumberSetting" type="text" value="1">
                </span>
                <span class="arrow">
                    <a href="#nowhere" class="increaseNumber">
                        <span class="updown">
                            <img src="${base_url}/img/site/increase.png">
                        </span>
                    </a>
                    <span class="updownMiddle"> </span>
                    <a href="#nowhere"  class="decreaseNumber">
                        <span class="updown">
                            <img src="${base_url}/img/site/decrease.png">
                        </span>
                    </a>
                </span>
            件</span>
            <span>库存${product.stock}件</span>
        </div>
        <div class="serviceCommitment">
            <span class="serviceCommitmentDesc">服务承诺</span>
            <span class="serviceCommitmentLink">
                <a href="#nowhere">正品保证</a>
                <a href="#nowhere">极速退款</a>
                <a href="#nowhere">赠运费险</a>
                <a href="#nowhere">七天无理由退换</a>
            </span>
        </div>
        <div class="buyDiv">
            <a class="buyLink" href="foreBuyone/pid=${product.id}"><button class="buyButton">立即购买</button></a>
            <a href="#nowhere" class="addCartLink"><button class="addCartButton"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button></a>
        </div>
    </div>
    <div style="clear:both"></div>
</div>