<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<ul style="padding-left:0px;" class="list-group">
    <%--<c:forEach items="${sessionScope.permissionRoot.children }" var="permission">--%>
        <%--<c:if test="${empty permission.children}">--%>
            <%--<li class="list-group-item tree-closed" >--%>
                <%--<a href="${APP_PATH }/${permission.url }"><i class="${permission.icon}"></i> ${permission.name }</a>--%>
            <%--</li>--%>
        <%--</c:if>--%>
        <%--<c:if test="${not empty permission.children}" >--%>
            <%--<li class="list-group-item tree-closed">--%>
                <%--<span><i class="${permission.icon}"></i> ${permission.name } <span class="badge" style="float:right">${fn:length(permission.children)}    &lt;%&ndash; ${permission.children.size() } &ndash;%&gt;</span></span>--%>
                <%--<ul style="margin-top:10px;display:none;">--%>
                    <%--<c:forEach items="${permission.children }" var="innerPermission">--%>
                        <%--<li style="height:30px;">--%>
                            <%--<a href="${APP_PATH }/${innerPermission.url}"><i class="${innerPermission.icon }"></i> ${innerPermission.name }</a>--%>
                        <%--</li>--%>
                    <%--</c:forEach>--%>
                <%--</ul>--%>
            <%--</li>--%>
        <%--</c:if>--%>
    <%--</c:forEach>--%>
    <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理<span class="badge" style="float:right">3</span></span>
        <ul style="margin-top:10px;display:none;">
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/user/toIndex.htm"><i class="glyphicon glyphicon-user"></i> 用户维护</a>
            </li>
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/role/index.htm"><i class="glyphicon glyphicon-king"></i> 角色维护</a>
            </li>
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/permission/index.htm"><i class="glyphicon glyphicon-lock"></i> 许可维护</a>
            </li>
        </ul>
    </li>
    <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon-ok"></i> 业务审核 <span class="badge" style="float:right">3</span></span>
        <ul style="margin-top:10px;display:none;">
            <li style="height:30px;">
                <a href="auth_cert.html"><i class="glyphicon glyphicon-check"></i> 实名认证审核</a>
            </li>
            <li style="height:30px;">
                <a href="auth_adv.html"><i class="glyphicon glyphicon-check"></i> 广告审核</a>
            </li>
            <li style="height:30px;">
                <a href="auth_project.html"><i class="glyphicon glyphicon-check"></i> 项目审核</a>
            </li>
        </ul>
    </li>
    <li class="list-group-item tree-closed">
        <span><i class="glyphicon glyphicon-th-large"></i> 业务管理 <span class="badge" style="float:right">7</span></span>
        <ul style="margin-top:10px;display:none;">
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/cert/index.htm"><i class="glyphicon glyphicon-picture"></i> 资质维护</a>
            </li>
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/type/index.htm"><i class="glyphicon glyphicon-equalizer"></i> 分类管理</a>
            </li>
            <li style="height:30px;">
                <a href="process.html"><i class="glyphicon glyphicon-random"></i> 流程管理</a>
            </li>
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/advert/index.htm"><i class="glyphicon glyphicon-hdd"></i> 广告管理</a>
            </li>
            <li style="height:30px;">
                <a href="message.html"><i class="glyphicon glyphicon-comment"></i> 消息模板</a>
            </li>
            <li style="height:30px;">
                <a href="${pageContext.request.contextPath}/projectType/index.htm"><i class="glyphicon glyphicon-list"></i> 项目分类</a>
            </li>
            <li style="height:30px;">
                <a href="tag.html"><i class="glyphicon glyphicon-tags"></i> 项目标签</a>
            </li>
        </ul>
    </li>
    <li class="list-group-item tree-closed" >
        <a href="${pageContext.request.contextPath}/param/index.htm"><i class="glyphicon glyphicon-list-alt"></i> 参数管理</a>
    </li>

</ul>
