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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jqueryUi/css/jquery-ui.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jqueryUi/js/jquery-1.10.2.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/jqueryUi/js/jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("input[type='reset']").click(function () {
                $("input[type='text']").removeAttr("value");
            });

            var dataSource = "";
            $( "#tags" ).autocomplete({
                source: "query/getOwnTable"

            });
            $(".pager_link").on("click",function(event){

                var pageInfo = $(this).attr("href");
                var str =  pageInfo.match(/pager.offset=\d+/).toString();
               // var pattern=/[0-9]*[1-9][0-9]*/;
               // var pageoffset = str.match(pattern);
              //  alert(str.match(/\d+/));
                var pageoffset = str.match(/\d+/);
                $("#pageoffset").val(pageoffset);
                event.preventDefault();
                $("form:first").submit();

            });
        });
    </script>
</head>

<body>
<div id="container">
    <jsp:include page="/jsp/SearchService/index.jsp">
        <jsp:param value="" name=""/>
    </jsp:include>

    <div id="search-service-div">
        <%--<input type="text" value="${sessionScope.loginUser.id}" id="userId"/>--%>
        <form action="query/search" method="post">
           <input type="hidden" id="pageoffset" name="pager.offset"/>
        <div id="filedDiv">
                <table>
                    <thead>
                        <tr>
                            <td colspan="3" align="left">
                                <div class="ui-widget">
                                    <label for="tags">TableName:</label>
                                    <input id="tags"  name="tableName" value="${tableName}"/>
                                    <a href="query/query">Advanced query>></a>
                                    

                                </div>
                            </td>
                        </tr>
                    </thead>
                    <tr>
                        <td><span>ra:</span><input type="text" name="ra" value="${sp.ra }"></td>
                        <td>
                            <span>raMin:</span><input type="text" name="raMin" value="${sp.raMin }">
                            <span>raMax:</span><input type="text" name="raMax" value="${sp.raMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>dec:</span><input type="text" name="dec" value="${sp.dec }"></td>
                        <td>
                            <span>decMin:</span><input type="text" name="decMin" value="${sp.decMin }">
                            <span>decMax:</span><input type="text" name="decMax" value="${sp.decMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>mjd:</span><input type="text" name="mjd" value="${sp.mjd }"></td>
                        <td>
                            <span>mjdMin:</span><input type="text" name="mjdMin" value="${sp.mjdMin }">
                            <span>mjdMax:</span><input type="text" name="mjdMax" value="${sp.mjdMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>snu:</span><input type="text" name="snu" value="${sp.snu }"></td>
                        <td>
                            <span>snuMin:</span><input type="text" name="snuMin" value="${sp.snuMin }">
                            <span>snuMax:</span><input type="text" name="snuMax" value="${sp.snuMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>sng:</span><input type="text" name="sng" value="${sp.sng }"></td>
                        <td>
                            <span>sngMin:</span><input type="text" name="sngMin" value="${sp.sngMin }">
                            <span>sngMax:</span><input type="text" name="sngMax" value="${sp.sngMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>snr:</span><input type="text" name="snr" value="${sp.snr }"></td>
                        <td>
                            <span>snrMin:</span><input type="text" name="snrMin" value="${sp.snrMin }">
                            <span>snrMax:</span><input type="text" name="snrMax" value="${sp.snrMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>sni:</span><input type="text" name="sni" value="${sp.sni }"></td>
                        <td>
                            <span>sniMin:</span><input type="text" name="sniMin" value="${sp.sniMin }">
                            <span>sniMax:</span><input type="text" name="sniMax" value="${sp.sniMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>snz:</span><input type="text" name="snz" value="${sp.snz }"></td>
                        <td>
                            <span>snzMin:</span><input type="text" name="snzMin" value="${sp.snzMin }">
                            <span>snzMax:</span><input type="text" name="snzMax" value="${sp.snzMax }">
                        </td>
                    </tr>
                    <tr>
                        <td><span>z :</span><input type="text" name="z" value="${sp.z }"></td>
                        <td>
                            <span>zMin: </span><input type="text" name="zMin" value="${sp.zMin }">
                            <span>zMax: </span><input type="text" name="zMax" value="${sp.zMax }">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span>planId:</span><input type="text" name="planId" value="${sp.planId }">
                            &nbsp;&nbsp;
                            <span>objtype: </span><input type="text" name="objtype" value="${sp.objtype }">
                            <span>class: </span><input type="text" name="clz" value="${sp.clz }">
                        <td>
                    </tr>

                </table>
        </div>
         <div id="submitDiv">
            <input type="radio" name="or_and" value="0"><span
                style="background-color: #9ef97e">or Query</span><br/>
            <input type="radio" name="or_and" value="1"><span style="background-color: #9ef97e">and Query</span><br/>

             <input type="submit" value="Submit" class="btclass" style="width: 100px;height: 40px"> <br/>
            <input type="reset" value="Reset" class="btclass" style="width: 100px;height: 40px"> <br/>

         </div>
        </form>
        <div id="errorDiv">
            <c:forEach items="${ errorMsg}" var="message"><span class="error">${message }</span></c:forEach>

        </div>

           <div id="DataDiv">
            <c:if test="${isFithas}">
                <table id="DataTable">
                    <thead>
                    <tr style="background-color:#DFF0D8">
                        <td>planId</td>
                        <td>mjd</td>
                        <td>ra</td>
                        <td>dec</td>
                        <td>objtype</td>
                        <td>snu</td>
                        <td>sng</td>
                        <td>snr</td>
                        <td>sni</td>
                        <td>snz</td>
                        <td>class</td>
                        <td>z</td>
                        <td>file</td>
                        <td>show</td>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${ses.datas }" var="s">
                        <tr>
                            
                            <td bordercolor="#009F00">${s.planId}</td>
                            <td>${s.mjd }</td>
                            <td>${s.ra }</td>
                            <td>${s.dec }</td>
                            <td>${s.objtype}</td>
                            <td>${s.snu }</td>
                            <td>${s.sng }</td>
                            <td>${s.snr }</td>
                            <td>${s.sni }</td>
                            <td>${s.snz }</td>
                            <td>${s.clz }</td>
                            <td>${s.z }</td>
                            <td><a href="fits/${s.path}"><img src="graduation1/../resources/image/fits.jpg"></a></td>
                            <td><a href="./appletindex.jsp?Name=${s.path}"><img src="graduation1/../resources/image/spec.jpg"
                            
                            
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot align="right" style="border-right: 100px;">
                    <tr>
                        <td colspan="15" style="text-align:right;margin-right:10px;">
                            <jsp:include page="/jsp/pager.jsp">
                                <jsp:param value="${ses.total }" name="totalRecord"/>
                                <jsp:param value="query/search" name="url"/>
                            </jsp:include>
                        </td>
                    </tr>
                    </tfoot>
              </table>
           </c:if>
            <c:if test="${!isFithas}">
                   <table  id="DataTable">
                       <thead>
                       <tr>
                           <c:forEach items="${names}" var="name">
                               <td>${name}</td>
                           </c:forEach>
                           <c:if test="${!empty names}">
                               <td>file</td>
                               <td>show</td>
                           </c:if>
                       </tr>
                       </thead>
                       <tbody>
                       <c:forEach items="${pager.datas}" var="map">
                           <tr>
                               <c:forEach items="${map}" var="m">
                                   <td>${m.value }</td>
                               </c:forEach>
                                   <td><a href="fits/${s.path}"><img src="graduation1/../resources/image/fits.jpg"></a></td>
                                   <td><a href="./appleindex.jsp"><img src="graduation1/../resources/image/spec.jpg"></a></td>
                           </tr>
                       </c:forEach>
                       </tbody>
                       <tfoot>
                       <c:if test="${!empty pager.datas}">
                           <tr>
                               <td colspan="${fn:length(names) + 2}" style="text-align:right;margin-right:10px;">
                                   <jsp:include page="/jsp/pager.jsp">
                                       <jsp:param value="${pager.total }" name="totalRecord"/>
                                       <jsp:param value="query/search" name="url"/>
                                   </jsp:include>
                               </td>
                           </tr>
                       </c:if>
                       </tfoot>

                   </table>

             </c:if>

           </div>
            <c:forEach items="${errorMsg}" var="msg">
                ${msg}
            </c:forEach>
            <c:out value="${error}"></c:out>
    </div>
</div>
</body>
</html>
