<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>SQL Query</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/sqlpage.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
//        alert('jinru javascriopt');
        $(document).on("click","tr td .pager_link", function(event){
            var pageInfo = $(this).attr("href");
            var str =  pageInfo.match(/pager.offset=\d+/).toString();
            var pageoffset = str.match(/\d+/);
            $("#pageoffset").val(pageoffset);
            event.preventDefault();
            $("form:first").submit();

        });
    </script>
</head>

<body>
<div id="container">
    <jsp:include page="/jsp/SearchService/index.jsp">
        <jsp:param value="" name=""/>
    </jsp:include>

    <div id="sqlInputDiv">
        <form action="sql/sqlsearch" method="post">
            <textarea id="sql" name="sql">${sql}</textarea><br/>
            <input type="submit" value="query">&nbsp;
            <input type="reset" value="Reset">&nbsp;<br>
            <c:forEach var="item" items="${error }">
					<span class="error">${item}<span><br>
			</c:forEach>
            <input type="hidden" id="pageoffset" name="pager.offset"/>
        </form>
    </div>
    <div id="SqlDataDiv">
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
            <tfoot>
            <c:if test="${!empty names}">
                <tr>
                    <td colspan="${fn:length(names) }" style="text-align:right;margin-right:10px;">
                        <jsp:include page="/jsp/pager.jsp">
                            <jsp:param value="${total }" name="totalRecord"/>
                            <jsp:param value="sql/search" name="url"/>
                        </jsp:include>
                    </td>
                </tr>
            </c:if>
            </tfoot>
        </table>
    </div>

</div>
</body>
</html>
