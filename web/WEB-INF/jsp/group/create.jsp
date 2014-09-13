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
    <title>Create Group</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/mydb.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/user.css">
    <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-1.8.3.js"></script>

    <script type="text/javascript">
        function checkParams(event){
            var groupName = $('#groupName').val().trim();
            var description = $('#description').val().trim();

            var flag = true;
            if(groupName == ''){
                flag = false;
                alert("Please enter group name!");
            }else if(description != null && description.length > 255){
                flag = false;
                alert("The description is too long.");
            }

            if(!flag){
                event.preventDefault();
            }
        }
    </script>
</head>

<body>
<div id="container">
    <%@ include file="../operation_menu.jsp" %>
    <div id="showDataDiv">
        <h3 class="admin_link_bar">
            <jsp:include page="inc.jsp"></jsp:include>
        </h3>

        <div id="frmGroup">
            <sf:form method="post" modelAttribute="groupDto" id="frmCreateGroup" action="group/create">
                <table cellspacing="0" cellPadding="0">
                    <thead>
                    <tr>
                        <td colspan="2">Create Group</td>
                    </tr>
                    </thead>
                    <tr>
                        <td class="rightTd" width="200px">Group Name:</td>
                        <td class="leftTd">
                            <sf:input path="name" size="30" id = "groupName"/>
                            <sf:errors cssClass="errorContainer" path="name"/></td>
                    </tr>
                    <tr>
                        <td class="rightTd">Description:</td>
                        <td class="leftTd"><sf:input path="dec" size="30" id = "description"/></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="centerTd">
                            <input type="submit" value="Create" onclick="checkParams(event)"/>
                            <input type="reset" value="Reset"/>
                            <span class="error">${errorMsg}</span>
                        </td>
                    </tr>
                </table>
            </sf:form>
        </div>
    </div>
</div>
</body>
</html>
