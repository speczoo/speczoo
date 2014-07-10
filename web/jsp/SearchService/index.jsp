<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="top">
    <div id="loginUserInfo">
        <a href="user/myInfo"> ${sessionScope.loginUser.username}</a> &nbsp;|&nbsp;
        <a href="user/logout">Log out</a>
    </div>
</div>

<div id="content">
    <div id="nav_list">
        <ul>
            <li><a href="home"><span>Home</span></a></li>
            <li><a href="query/search"><span>Query</span></a></li>
            <li><a href="mydb/mydbUpload"><span>My DB</span></a></li>

            <c:choose>
                <c:when test="${sessionScope.loginUser.username eq 'admin'}">
                    <li><a href="sql/sqlsearch"><span>SQL Query</span></a></li>
                </c:when>
            </c:choose>

            <%--<li> <a class="sqllink" href="query/sqlsearch"><span>Sql Query</span></a></li>--%>
            <c:choose>
                <c:when test="${sessionScope.loginUser.username eq 'admin'}">
                    <li><a href="user/users"><span>Account</span></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="user/myInfo"><span>Account</span></a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
