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
    <%--link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/sqlpage.css"--%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jpager/css/jPages.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/jpager/css/animate.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jpager/js/jPages.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/query.js"></script>
    <script type="text/javascript">
//        alert('jinru javascriopt');
    /*    $(document).on("click","tr td .pager_link", function(event){
            var pageInfo = $(this).attr("href");
            var str =  pageInfo.match(/pager.offset=\d+/).toString();
            var pageoffset = str.match(/\d+/);
            $("#pageoffset").val(pageoffset);
            event.preventDefault();
            $("form:first").submit();

         });
*/
        $(function(){
            $("div.holder").jPages({
                containerID : "tbody",
                previous : "←",
                next : "→",
                perPage : 15,
                delay : 20,
                keyBrowse:true,
                callback:function( pages, items ){
                    //alert(pages.current+","+items.count);
                }
            });
            $("input[type='reset']").on("click",function(){
                $("textarea").html("");
            });


        });




function checkall() {
  	var ischecked = document.getElementById("all").checked;
  	if(ischecked) {
  		checkallbox();
  	}else {
  		discheckallbox();
  	}
  }
  //选中全部复选框
  function checkallbox() {
  	var boxarray = document.getElementsByName("pathMark");
  	for(var i = 0; i < boxarray.length; i++) {
  		boxarray[i].checked = true;
  	}
  }
  //取消选中全部复选框
  function discheckallbox() {
  	var boxarray = document.getElementsByName("pathMark");
  	for(var i = 0; i < boxarray.length; i++) {
  		boxarray[i].checked = false;
  	}
  }

  //点击某个复选框，如果所有复选框都选中，“全选/全不选”复选框也选中
  //否则如果所有复选框都取消选中，“全选/全不选”复选框也取消选中
  function checkonebox() {
  	if(isallchecked()) {
  		document.getElementById("all").checked = true;
  	}
  	if(isalldischecked()) {
  		document.getElementById("all").checked = false;
  	}
  }

  //是否全部选中
  function isallchecked() {
  	var boxarray = document.getElementsByName("pathMark");
  	for(var i = 0; i < boxarray.length; i++) {
  		if(!boxarray[i].checked) {
  			return false;
  		}
  	}
  	return true;
  }
  //是否全部没有选中
  function isalldischecked() {
  	var boxarray = document.getElementsByName("pathMark");
  	for(var i = 0; i < boxarray.length; i++) {
  		if(boxarray[i].checked) {
  			return false;
  		}
  	}
  	return true;
  }
  //得到选中项的值的集合，结果为“1|小明,2|小王,3|小李”的形式
  function getallcheckedvalue() {
  	var boxvalues = "";
  	var boxarray = document.getElementsByName("pathMark");
  	for(var i = 0; i < boxarray.length; i++) {
  		if(boxarray[i].checked) {
  			//var boxvalue = boxarray[i].value;
  				boxvalues = boxvalues + "," + i;
  			}
  		}
  	return boxvalues;
  //	alert(boxvalues);
  
  	}
  function changeValue(){
	  document.getElementById("record_id").innerHTML =getallcheckedvalue();
	  document.getElementById("record_id").value = getallcheckedvalue();
  }
  
  	
  function doSubmit(){
	 var form = document.getElementById("sqlDataForm");
	 form.pathmark = getallcheckedvalue();
	
	  form.submit();
  }
  doSubmit();
  //如果只需要得到其中选中项的id值的集合，方法如下，得到的值为（1,2,3,…）


  	
  
  function checkFile() {   
      if($("#all").attr("checked")){   
          $("input[name='pathMark']").attr("checked",true);   
      }else {   
          $("input[name='pathMark']").attr("checked",false);   
      }   
  }   

  function showout(){
	out.println("you have chosen the point!");
	  }

  
  
  function changeval(){
	  
	  var check = document.getElementsByName("pathMark");
	  for(var i = 0; i<check.length; i++){
		     if(check[i].checked == true){
			           check[i].value = "1";
			           
			 }else{
					 check[i].value = "0";
				}
		}
	  }


    </script>
</head>

<body>
    <jsp:include page="/jsp/layout/header.jsp"/>
    <div id="contents">
      <div id="search-service-div" class="wrapper clearfix">
        <div class="main">

    <div id="sqlInputDiv">
        <div id="t_tableInfoDiv">
            <select name="tableName">
                <option>Optional Tables</option>
            </select>
        </div>
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
    <form action="sql/sqldownload" method="post" name="form1" id="sqlDataForm" >
    <div id="SqlDataDiv">
    	<c:if test="${!empty names}">
        <div class="holder"></div>
        
        <input type="submit" value="Download ALL" id="sb" onclick="changeValue()"/>
        </c:if>
        <table>
            <thead>
            <tr>
          
            <c:if test="${!empty names}">
            <td><input type="checkbox" name="all"  id="all" onclick="checkall()"/>ALL</td>
            </c:if>      
                <c:forEach items="${names}" var="name">
                    <th>${name}</th>
                </c:forEach> 
                <c:if test="${!empty names}">
                      <th>file</th>
                      <th>show</th>
                    </c:if>
            </tr>
            </thead>
            <tbody id="tbody">
            <c:forEach items="${lmps}" var="map">
                <tr>
                
                <td><input type="checkbox" name="pathMark" id="pathMark" /></td>
                    <c:forEach items="${map}" var="m">
                        <td>${m.value }</td>
                    </c:forEach>
                    <input type="hidden" name="record_id" id="record_id" value=''/>
                     <td><a href="fits/${m.value}"><img src="graduation1/../resources/image/fits.jpg"></a></td>
                      <td><a href="./appleindex.jsp"><img src="graduation1/../resources/image/spec.jpg"></a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    </form>

</div>
      </div>
    </div>
    <jsp:include page="/jsp/layout/footer-login.jsp"/>   
</body>
</html>
