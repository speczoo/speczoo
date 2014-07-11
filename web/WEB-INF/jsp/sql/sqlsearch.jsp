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
    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/css/style.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
//        alert('jinru javascriopt');
      $(document).on("click", "tr td .pager_link", function(event) {
        var pageInfo = $(this).attr("href");
        var str = pageInfo.match(/pager.offset=\d+/).toString();
        var pageoffset = str.match(/\d+/);
        $("#pageoffset").val(pageoffset);
        event.preventDefault();
        $("form:first").submit();

      });
    </script>
  </head>

  <body>
    <jsp:include page="/jsp/layout/header-login.jsp"/>
    <div id="contents">
      <div id="search-service-div" class="wrapper clearfix">
        <div class="main">

          <div id="sqlInputDiv">
            <form action="sql/sqlsearch" method="post">
              <textarea id="sql" name="sql">${sql}</textarea><br/>
              <input type="submit" value="query" class="btn1">&nbsp;
              <input type="reset" value="Reset" class="btn1">&nbsp;<br>
              <p>
                <br/>
                <c:forEach var="item" items="${error }">
                  ${item}<br/>
                </c:forEach>
              </p>
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
      </div>
    </div>
    <jsp:include page="/jsp/layout/footer.jsp"/>   
  </body>
</html>
