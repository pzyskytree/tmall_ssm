<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8" isELIgnored="false"%>
<a href="${contextPath}">
    <img id="logo" src="img/site/logo.gif" class="logo">
</a>
<form action="foreSearch" method="POST">
    <div class="searchDiv">
        <input name="keyword" type="text" placeholder="Fashionable Shoe Sunglasses">
        <button type="submit" class="searchButton">Search</button>
        <div class="searchBelow">
            <c:forEach items="${categories}" var="category" varStatus="st">
                <c:if test="${st.count >= 5 and st.count <= 8}">
                    <span>
                        <a href="foreCategory/{category.id}">
                            ${category.name}
                        </a>
                        <c:if test="${st.count != 8}">
                            <span>|</span>
                        </c:if>
                    </span>
                </c:if>
            </c:forEach>
        </div>
    </div>
</form>
