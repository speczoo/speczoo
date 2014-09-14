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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/query.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
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
                <input type="button" value="增加条件" id="addCondition"/>
                <input type="button" value="submit" id="sb"/>
                <input type="button" value="reset" id="reset"/>
            </div>
        </div>
        <div id="bt_submitDiv">
            <form action="query/getQueryResult" method="post" id="form">
                <input type="hidden" name="tableName"/>
                <c:forEach var="item" items="${error }">
					<span class="error">${item}<span><br>
			    </c:forEach>
                <input type="hidden" id="pageoffset" name="pager.offset"/>
            </form>
        </div>

    <div id="dataShowDiv">
        <table  id="DataTable">
            <thead>
            <tr>
                <c:forEach items="${names}" var="name">
                    <c:if test="${name ne 'RECORD_ID'}">
                        <td>${name}</td>
                    </c:if>
                </c:forEach>
                <c:if test="${!empty names}">
                    <td>file</td>
                    <td>show</td>
                </c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${lmps}" var="map">
                <tr>
                    <c:forEach items="${map}" var="m">
                        <c:if test="${m.key ne 'RECORD_ID'}">
                            <td>${m.value }</td>
                        </c:if>
                    </c:forEach>
                    <td><a href="fits/${s.path}"><img src="graduation1/../resources/image/fits.jpg"></a></td>
                    <td><a href="spec/applet.jsp"><img src="graduation1/../resources/image/spec.jpg"></a></td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <c:if test="${!empty lmps}">
                <tr>
                    <td colspan="${fn:length(names) + 1}" style="text-align:right;margin-right:10px;">
                        <jsp:include page="/jsp/pager.jsp">
                            <jsp:param value="${total }" name="totalRecord"/>
                            <jsp:param value="query/query" name="url"/>
                        </jsp:include>
                    </td>
                </tr>
            </c:if>
            </tfoot>

        </table>
    </div>

    </div>
</div>
</body>
</html>
