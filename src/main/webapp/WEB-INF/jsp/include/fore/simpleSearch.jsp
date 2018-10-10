<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>

<div >
    <a href="${contextPath}">
        <img id = "simpleLogo" class = "simpleLogo" src="img/site/simpleLogo.png">
    </a>

    <form action="foreSearch" method="post">
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="Balance Car" name = "keyword">
            <button class="searchButton" type="submit">搜天猫</button>
            <div class="searchBelow">
                <c:forEach items="${categories}" var = "category" varStatus="st">
                    <c:if test="${st.count > 8 and st.count <= 11}">
                        <span>
                            <a href="foreCategory/${category.id}"> ${category.name}</a>
                            <c:if test="${st.count != 11}">
                                <span>|</span>
                            </c:if>
                        </span>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>