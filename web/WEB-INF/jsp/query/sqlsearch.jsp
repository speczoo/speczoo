<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'sqlsearch.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/main.css">
</head>

<body>
<div id="sqlDiv">
    <form action="query/sqlsearch" method="post">
        <input type="text" name="sql" value="${sql }">&nbsp;
        <input type="submit" value="query">&nbsp;
        <input type="reset" value="Reset">&nbsp;<br>
        <c:forEach var="item" items="${error }">
					<span class="error">${item}<span><br>
			</c:forEach>
    </form>
    <table>
        <thead>
        <tr>
            <c:forEach items="${names}" var="name">
                <td>${name}</td>
            </c:forEach>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${lmps}" var="map">
            <tr>
                <c:forEach items="${map}" var="m">
                    <td>${m.value }</td>
                </c:forEach>
            </tr>
        </c:forEach>
        </tbody>

    </table>
</div>
</body>
</html>
