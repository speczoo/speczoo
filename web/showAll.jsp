<html>
<body>
<%
	String path = request.getContextPath();
	String[] paths = request.getParameterValues("attachmentPath");
	if (paths==null){
		out.println("You don't have chosen any files!");
		return;
	}
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/"+"fits/";
	//String[] filepath=new String[paths.length];
	String filepaths="";
	for(int i=0;i<paths.length;i++){
	
		//filepaths[i]=basePath+(String)paths[i];
		filepaths+=basePath+(String)paths[i]+",";

	}
	//out.println(filepaths);

	
%> 

 <a href="user/myInfo"> ${sessionScope.loginUser.username}</a> &nbsp;|&nbsp;
 
   
  	<jsp:plugin code="spv.SpecviewApplet" codebase="./resources/applet" archive="speczoo7.jar" type="applet" width="1200"
           height="675">
            <jsp:params>
	
            <jsp:param name="Name" value='<%=filepaths%>'/>
            <jsp:param name="userName" value="${sessionScope.loginUser.username}"/>

            </jsp:params>

	</jsp:plugin>
	


</body>
</html>

 
