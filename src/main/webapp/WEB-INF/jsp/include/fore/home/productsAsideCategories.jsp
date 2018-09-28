<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(function(){
	$("div.productsAsideCategorys div.row a").each(function(){
		var v = Math.round(Math.random() *6);
		if(v == 1)
			$(this).css("color","#87CEFA");
	});
});

</script>
<c:forEach items="${categories}" var="category">
	<div cid="${category.id}" class="productsAsideCategorys">

		<c:forEach items="${category.productsByRow}" var="products">
			<div class="row show1">
				<c:forEach items="${products}" var="product">
					<c:if test="${!empty product.subTitle}">
						<a href="foreProduct/${product.id}">
							<c:forEach items="${fn:split(product.subTitle, ' ')}" var="title" varStatus="st">
								<c:if test="${st.index==0}">
									${title}
								</c:if>
							</c:forEach>
						</a>
					</c:if>
				</c:forEach>
				<div class="separator"></div>
			</div>
		</c:forEach>
	</div>
</c:forEach>

