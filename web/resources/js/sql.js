var tableNames = "";
var name = "<%=name%>";
var queryData = "";
$(function(){
    init();
});


function initData(){
    tableNames = "";
    filedNames = "";
}
function init(){
   
	$("#sb").on("click",function(event) {
        formSubmit();
   });
}


function formSubmit(){
	//获取表属性name；
	if
	getTableName();
	//判断表名，是fithas，则把打勾的文件打包下载下载下来。
	if (tableName.equals("fithas"))
	{
		downloadZip();
		alert("Success to download zip file!");
	}
	else {
		downloadTable();
		alert("Success to download table file!");
	}
	//若是非fithas，则下载整个表。
	
}

function getTableName(){
	
}


