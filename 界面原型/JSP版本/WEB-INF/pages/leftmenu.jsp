<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<ul>
    <!-- 遍历每个角色下的模块 -->
    <c:forEach items="${_CURRENT_USER.modules }" var="module">
        <!-- 如果该模块没有输出过，则要进行输出，否则这个模块就不输出 -->
        <c:if test="${(moduleName eq module.remark) and module.ctype==1  }">
                <li><a href="${ctx}/${module.curl}" onclick="linkHighlighted(this)" target="main"
                       id="aa_1">${module.cpermission }</a></li>
        </c:if>
    </c:forEach>
</ul>