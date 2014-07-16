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

    <title>Expert platform - Query</title>

    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/css/style.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/query.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jpager/js/jPages.js"></script>
  </head>

  <body>
    <jsp:include page="/jsp/layout/header.jsp"/>
    <div id="contents">
      <div id="search-service-div" class="wrapper clearfix">
        <div class="main">
          <h2>Query Constructed</h2>
          <div id="t_tableInfoDiv">
            <select name="tableName">
              <option>Optional Tables</option>
            </select>
          </div>
          <div id="showDiv">
            <div id="f_conditionDiv">
              <div id="buttonDiv">
                <select name="or_and">
                  <option value="1">and</option>
                  <option value="0">or</option>
                </select>
                <input type="button" value="Add" id="addCondition"/>
                <input type="button" value="submit" id="sb"/>
                <input type="button" value="reset" id="reset"/>
              </div>
            </div>
          </div>
          <div id="tableShowDiv">
            <table class="table table-hover table-bordered">
              <thead>
              </thead>
              <tbody id="tbody">
              </tbody>
            </table>
          </div>
          <div class="holder" style="float: right"></div>
        </div>
      </div>
    </div>
    <jsp:include page="/jsp/layout/footer-login.jsp"/>   
  </body>
</html>
