<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My DB</title>

    <meta charset="UTF-8">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
<!--    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/mydb.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/js/uploadify/uploadify.css">-->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jqueryUi/css/jquery-ui.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/css/style.css" type="text/css">
    <%--<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-1.8.3.js"></script>--%>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jqueryUi/js/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jqueryUi/js/jquery-ui.js"></script>
    <script type="text/javascript"
    src="<%= request.getContextPath()%>/resources/js/uploadify/jquery.uploadify.js"></script>


    <script type="text/javascript">


      $(function() {

        $("#dialog").dialog({
          autoOpen: false,
          show: {
            effect: "explode",
            duration: 1000
          },
          hide: {
            effect: "explode",
            duration: 1000
          },
          width: 500,
          height: 340,
          position: {my: "left top", at: "right bottom", of: window}

        });
        $("#opener").one("click", function() {
          $("#dialog").dialog("open");
        });
        $("#lookFileFormat").click(function() {
          $("#dialog").dialog("open");
        });




        $("#file_upload").uploadify({
          swf: $("#ctx").val() + "/resources/js/uploadify/uploadify.swf",
          uploader: $("#ctx").val() + "/mydb/mydbUpload",
          auto: false,
          fileObjName: "file",
          fileSizeLimit: "100000",
          fileTypeExts: "*.txt",
          method: "post",
          multi: false,
          formData: {'tableName': $("input[name='tableName']").val(), 'sessionId': $("#sessionId").val()},
          buttonText: "Select file ",
          queueID: "file_upload_queue",
          onUploadStart: function(file) {
            // alert('onUploadStart');
            $("#file_upload").uploadify("settings", "formData", {'tableName': $("input[name='tableName']").val(), 'sessionId': $("#sessionId").val()});
          },
          onUploadSuccess: function(file, data, response) {
            var resultdata = jQuery.parseJSON(data);
            if (resultdata.result == 1) {
              alert("Uploaded successfully....");
              getListMydbElement();
              $("input[name='tableName']").val("");
            } else {//上传失败
              alert(resultdata.message + ",请检查数据格式");
            }
          },
          onUploadError: function(file, errorCode, errorMsg, errorString) {
            alert(errorString + "," + errorMsg);
          }

        });
        $("#btupload").on("click", function() {
          $("#file_upload").uploadify("upload", "*");
        });
        $("#btcancel").on("click", function() {
          $("#file_upload").uploadify("cancel", "*");
        });
        $("table").on("mouseover", "tr", function() {
          $(this).addClass("trbackground");
        });
        $("table").on("mouseout", "tr", function() {
          $(this).removeClass("trbackground");
        });
        $("#downLoadDiv a span").on("click", function(event) {
          var href = $("#downLoadDiv a").prop("href");
          //alert(href+","+href.length);
          if (href.length <= 48) {
            alert("Not selected table.....");
            event.preventDefault();
          }
        });
      });

      getListMydbElement();
      function getListMydbElement() {
        $("#mydbInfo table tbody tr").remove();
        $.get("mydb/listMydbInfo", {}, function(data) {
          $(data).each(function() {
            var node = getTrNode(this.tableName, this.rowNum, this.id);
            $("#mydbInfo table tbody").append(node);
          });
        }, "json");
      }

      function getTrNode(tableName, rowNum, id) {
        var node = "";
        var td1 = "<td><a href=mydb/showTable/" + tableName + ">" + tableName + "</td>";
        var td2 = "<td>" + rowNum + "</td>";
        var td3 = "<td><a href=mydb/deleteTable?id=" + id + ">delete<a></td>";
        node = node.concat("<tr>").concat(td1).concat(td2).concat(td3).concat("</tr>");
        return node;
      }
    </script>

  </head>

  <body>
    <jsp:include page="/jsp/layout/header.jsp"/>
    <div id="contents">
      <div class="wrapper clearfix">
        <div id="leftbar">
          <div id="uploadDiv">
            Table name:<input type="text" name="tableName" id="opener">
            <input type="file" name="file" id="file_upload">
            <div id="file_upload_queue"></div>
            <input type="button" value="Start upload" id="btupload" class="btn4">
            <input type="button" value="Cancel" id="btcancel" class="btn4">
            <input type="button" value="File Format" id="lookFileFormat" class="btn4">
          </div>
          <br/>
          <div id="mydbInfo">
            <table class="table table-hover table-bordered">
              <thead>
                <tr>
                  <td>Table name</td>
                  <td>Linage</td>
                  <td>Delete</td>
                </tr>
              </thead>
              <tbody>

              </tbody>
              <tfoot>
                <tr>
                  <td colspan="3" align="right">
                    <a href="mydb/clearAllTable" >Delete all data</a>
                  </td>
                <tr>
              </tfoot>
            </table>
          </div>
          <br/>
          <div id="tableDataDiv">
            <table class="table table-hover table-bordered">
              <thead>
                <tr>
                  <c:forEach items="${names}" var="name">
                    <td>${name}</td>
                  </c:forEach>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${pager.datas}" var="map">
                  <tr>
                    <c:forEach items="${map}" var="m">
                      <td>${m.value }</td>
                    </c:forEach>
                  </tr>
                </c:forEach>
              </tbody>
              <tfoot>
                <c:if test="${!empty pager.datas}">
                  <tr>
                    <td colspan="${fn:length(names) }" style="text-align:right;margin-right:10px;">
                      <jsp:include page="/jsp/pager.jsp">
                        <jsp:param value="${pager.total }" name="totalRecord"/>
                        <jsp:param value="mydb/showTable/${tableName }" name="url"/>
                      </jsp:include>
                    </td>
                  </tr>
                </c:if>
              </tfoot>
            </table>
            <c:if test="${!empty pager.datas}">
              <div id="downLoadDiv">
                <a href="mydb/download/${tableName}"><span>Download data</span></a>
              </div>
            </c:if>
          </div>
          <div id="errorDiv">
            <c:forEach items="${error}" var="e">
              ${e }
            </c:forEach>
          </div>
        </div>

        <div class="main">
          <h5>MyDB</h5>
          <p>
            71,480 kB of 500,000 kB used
          </p>
          <p>
            From this page you can get various information about the contents of both your MyDB and shared tables within your groups. Click the left table links to get information about a specific table, such as rows, columns or size. From the table pages you can also perform various table-specific tasks, such as:<br/>
            Download a table<br/>
            Mangage your group tables<br/>
            Rename a table<br/>
            Drop a table<br/>
            Data usage and row counts are approximate.<br/>
            There's always some overhead; even empty MyDB's take up space.<br/>
            Group tables published by other users do not count towards your MyDB size limit.<br/>
          </p>
        </div>
      </div>
    </div>
    <jsp:include page="/jsp/layout/footer-login.jsp"/>   

    <input type="hidden" id="ctx" value="<%= request.getContextPath()%>">
    <input type="hidden" id="sessionId" value="${pageContext.session.id}"/>


    <div id="dialog" title="File Form">
      <p>
        <span>
          1.Files' first row must be fields,each field must be separated with " " or "," ;<br/>
          2.From the Second row are datas of each field, the numbers of datas muust be the same with munbers of fields;<br/>
          such as：
          <img src="<%=request.getContextPath()%>/resources/image/filegeshi.JPG"/>
        </span>

      </p>
    </div>

  </body>
</html>
