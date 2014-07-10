<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>My JSP 'show.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/query.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css">
    <%--<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jpager/css/style.css">--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jpager/css/jPages.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jpager/css/animate.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jpager/js/jPages.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/query.js"></script>
</head>

<body>
<div id="container">
    <jsp:include page="/jsp/SearchService/index.jsp">
       <jsp:param value="" name=""/>
    </jsp:include>

    <div id="search-service-div">

        <div id="t_tableInfoDiv">
            <select name="tableName">
                <option>请选择表</option>
            </select>
        </div>
        <div id="showDiv">
            <div id="f_conditionDiv">
                <%--<div name="fieldConditionDiv">
                    <select>
                        <option>a</option>
                        <option>b</option>
                        <option>c</option>
                        <option>d</option>
                    </select>
                    <select>
                        <option> > </option>
                        <option> < </option>
                        <option> = </option>
                        <option> >= </option>
                        <option> <=  </option>
                    </select>
                    <input type="text"/><span class="deleteCondition">×</span>
                    <input type="hidden"/>
                </div>--%>
                <div id="buttonDiv">
                    <select name="or_and">
                        <option value="1">and</option>
                        <option value="0">or</option>
                    </select>
                    <input type="button" value="增加条件" id="addCondition"/>
                    <input type="button" value="submit" id="sb"/>
                    <input type="button" value="reset" id="reset"/>
                </div>
            </div>


        </div>
            <div id="tableShowDiv">
                <table>
                    <thead>
                    </thead>
                    <tbody id="tbody">
                    </tbody>
                </table>
            </div>
                <div class="holder" style="float: right"></div>
    </div>
</div>
</body>
</html>
