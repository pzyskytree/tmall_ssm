<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>

<div >
    <a href="${contextPath}">
        <img id = "simpleLogo" class = "simpleLogo" src="${base_url}/img/site/simpleLogo.png">
    </a>

    <form action="${base_url}/foreSearch" method="post" enctype="multipart/form-data">
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="Balance Car" name = "keyword">
            <button class="searchButton" type="submit">搜天猫</button>
            <div class="searchBelow">
                <c:forEach items="${categories}" var = "category" varStatus="st">
                    <c:if test="${st.count > 5 and st.count <= 7}">
                        <span>
                            <a href="${base_url}/foreCategory/${category.id}"> ${category.name}</a>
                            <c:if test="${st.count != 7}">
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