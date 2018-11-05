<%@ page language = "java" contentType="text/html; charset=utf-8"
    pageEncoding = "utf-8" isELIgnored = "false"%>

<script>
    var deleteOrderItem = false;
    var deleteOrderItemId = 0;
    $(function(){
        //Delete Item from cart
        $("a.deleteOrderItem").click(function(){
            deleteOrderItem = false;
            var oiId = $(this).attr("oiId")
            deleteOrderItemId = oiId;
            $("#deleteConfirmModal").modal('show');
        });

        $("button.deleteConfirmButton").click(function(){
            deleteOrderItem = true;
            $("#deleteConfirmModal").modal('hide');
        });

        $('#deleteConfirmModal').on('hidden.bs.modal', function (e) {
            if(deleteOrderItem){
                var page="foreDeleteOrderItem";
                $.post(
                    page,
                    {"oiId":deleteOrderItemId},
                        function(result){
                            if("success"==result){
                                $("tr.cartProductItemTR[oiId="+deleteOrderItemId+"]").hide();
                                location.reload(false);
                            }
                            else{
                                location.href="loginPage";
                            }
                        }
                );

            }
        })

        //Select Items
        $("img.cartProductItemIfSelected").click(function(){
            var selectIt = $(this).attr("selectIt")
            if("selectIt" == selectIt){
                $(this).attr("src","${base_url}/img/site/cartNotSelected.png");
                $(this).attr("selectIt","false")
                $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
            }
            else{
                $(this).attr("src","${base_url}/img/site/cartSelected.png");
                $(this).attr("selectIt","selectIt")
                $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
            }
            syncSelect();
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();
        });
        //Select All
        $("img.selectAllItem").click(function(){
            var selectIt = $(this).attr("selectIt")
            if("selectIt" == selectIt){
                $("img.selectAllItem").attr("src","${base_url}/img/site/cartNotSelected.png");
                $("img.selectAllItem").attr("selectIt","false")
                $(".cartProductItemIfSelected").each(function(){
                    $(this).attr("src","${base_url}/img/site/cartNotSelected.png");
                    $(this).attr("selectIt","false");
                    $(this).parents("tr.cartProductItemTR").css("background-color","#fff");
                });
            }
            else{
                $("img.selectAllItem").attr("src","${base_url}/img/site/cartSelected.png");
                $("img.selectAllItem").attr("selectIt","selectIt")
                $(".cartProductItemIfSelected").each(function(){
                    $(this).attr("src","${base_url}/img/site/cartSelected.png");
                    $(this).attr("selectIt","selectIt");
                    $(this).parents("tr.cartProductItemTR").css("background-color","#FFF8E1");
                });
            }
            syncCreateOrderButton();
            calcCartSumPriceAndNumber();

        });
        //Set Number
        $(".orderItemNumberSetting").keyup(function(){
            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();

            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
            num = parseInt(num);
            if(isNaN(num) || num < 0)
                num= 1;
            if(num>stock)
                num = stock;
            syncPrice(pid,num,price);
        });
        // Add one
        $(".numberPlus").click(function(){
            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
            if(num < stock)
                num++;
            syncPrice(pid,num,price);
        });
        // Minus one
        $(".numberMinus").click(function(){
            var pid=$(this).attr("pid");
            var stock= $("span.orderItemStock[pid="+pid+"]").text();
            var price= $("span.orderItemPromotePrice[pid="+pid+"]").text();
            var num= $(".orderItemNumberSetting[pid="+pid+"]").val();
            if(num > 1)
                num--;
            syncPrice(pid,num,price);
        });
        //Create Order
        $("button.createOrderButton").click(function(){
            var params = "";
            $(".cartProductItemIfSelected").each(function(){
                if("selectIt"==$(this).attr("selectIt")){
                    var oiId = $(this).attr("oiId");
                    params += "&oiId="+oiId;
                }
            });
            params = params.substring(1);
            location.href="foreBuy?" + params;
        });

    })

    function syncCreateOrderButton(){
        var selectAny = false;
        $(".cartProductItemIfSelected").each(function(){
            if("selectIt"==$(this).attr("selectit")){
                selectAny = true;
            }
        });

        if(selectAny){
            $("button.createOrderButton").css("background-color","#C40000");
            $("button.createOrderButton").removeAttr("disabled");
        }
        else{
            $("button.createOrderButton").css("background-color","#AAAAAA");
            $("button.createOrderButton").attr("disabled","disabled");
        }

    }

    function syncSelect(){
        var selectAll = true;
        $(".cartProductItemIfSelected").each(function(){
            if("false" == $(this).attr("selectIt")){
                selectAll = false;
            }
        });

        if(selectAll)
            $("img.selectAllItem").attr("src","${base_url}/img/site/cartSelected.png");
        else
            $("img.selectAllItem").attr("src","${base_url}/img/site/cartNotSelected.png");

    }
    // Total price in the cart
    function calcCartSumPriceAndNumber(){
        var sum = 0;
        var totalNumber = 0;
        $("img.cartProductItemIfSelected[selectIt='selectIt']").each(function(){
            var oiId = $(this).attr("oiId");
            var price =$(".cartProductItemSmallSumPrice[oiId="+oiId+"]").text();
            price = price.replace(/,/g, "");
            price = price.replace(/￥/g, "");
            sum += new Number(price);
            var num =$(".orderItemNumberSetting[oiId="+oiId+"]").val();
            totalNumber += new Number(num);

        });
        $("span.cartSumPrice").html("￥"+formatMoney(sum));
        $("span.cartTitlePrice").html("￥"+formatMoney(sum));
        $("span.cartSumNumber").html(totalNumber);
    }

    // Change html
    function syncPrice(pid,num,price){
        $(".orderItemNumberSetting[pid="+pid+"]").val(num);
        var cartProductItemSmallSumPrice = formatMoney(num*price);
        $(".cartProductItemSmallSumPrice[pid="+pid+"]").html("￥"+cartProductItemSmallSumPrice);
        calcCartSumPriceAndNumber();

        var page = "foreChangeOrderItem";
        $.post(
                page,
                {"pid":pid,"number":num},
                function(result){
                    if("success"!=result){
                        location.href="login.jsp";
                    }
                }
            );

    }
</script>

<title>购物车</title>
<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span>已选商品  (不含运费)</span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结 算</button>
    </div>

    <div class="cartProductList">
        <table class="cartProductTable">
            <thead>
                <tr>
                    <th class="selectAndImage">
                            <img selectIt="false" class="selectAllItem" src="${base_url}/img/site/cartNotSelected.png">
                    全选

                    </th>
                    <th>商品信息</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th width="120px">金额</th>
                    <th class="operation">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orderItems}" var="orderItem">
                    <c:if test="${orderItem.oid == null}">
                    <b >${orderItem.oid}</b>
                    <tr oiId="${orderItem.id}" class="cartProductItemTR">
                        <td>
                            <img selectIt="false" oiId="${orderItem.id}" class="cartProductItemIfSelected" src="${base_url}/img/site/cartNotSelected.png">
                            <a style="display:none" href="#nowhere"><img src="${base_url}/img/site/cartSelected.png"></a>
                            <img class="cartProductImg"  src="${base_url}/img/productSingleMiddle/${orderItem.product.firstProductImage.id}.jpg">
                        </td>
                        <td>
                            <div class="cartProductLinkOutDiv">
                                <a href="foreProduct/${orderItem.product.id}" class="cartProductLink">${orderItem.product.name}</a>
                                <div class="cartProductLinkInnerDiv">
                                    <img src="${base_url}/img/site/creditcard.png" title="支持信用卡支付">
                                    <img src="${base_url}/img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="${base_url}/img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>

                        </td>
                        <td>
                            <span class="cartProductItemOringalPrice">￥${orderItem.product.originalPrice}</span>
                            <span  class="cartProductItemPromotionPrice">￥${orderItem.product.promotePrice}</span>

                        </td>
                        <td>

                            <div class="cartProductChangeNumberDiv">
                                <span class="hidden orderItemStock " pid="${orderItem.product.id}">${orderItem.product.stock}</span>
                                <span class="hidden orderItemPromotePrice " pid="${orderItem.product.id}">${orderItem.product.promotePrice}</span>
                                <a  pid="${orderItem.product.id}" class="numberMinus" href="#nowhere">-</a>
                                <input pid="${orderItem.product.id}" oiId="${orderItem.id}" class="orderItemNumberSetting" autocomplete="off" value="${orderItem.number}">
                                <a  stock="${orderItem.product.stock}" pid="${orderItem.product.id}" class="numberPlus" href="#nowhere">+</a>
                            </div>

                         </td>
                        <td >
                            <span class="cartProductItemSmallSumPrice" oiId="${orderItem.id}" pid="${orderItem.product.id}" >
                            ￥<fmt:formatNumber type="number" value="${orderItem.product.promotePrice*orderItem.number}" minFractionDigits="2"/>
                            </span>

                        </td>
                        <td>
                            <a class="deleteOrderItem" oiId="${orderItem.id}"  href="#nowhere">删除</a>
                        </td>
                    </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="cartFoot">
        <img selectIt="false" class="selectAllItem" src="${base_url}/img/site/cartNotSelected.png">
        <span>全选</span>
<!--         <a href="#">删除</a> -->

        <div class="pull-right">
            <span>已选商品 <span class="cartSumNumber" >0</span> 件</span>

            <span>合计 (不含运费): </span>
            <span class="cartSumPrice" >￥0.00</span>
            <button class="createOrderButton" disabled="disabled" >结  算</button>
        </div>

    </div>

</div>