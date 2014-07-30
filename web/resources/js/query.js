var tableNames = "";
var filedNames = "";
var queryData = "";
$(function(){
    init();
});

/*------------初始化表格名数据--------------*/
function initData(){
     tableNames = "";
     filedNames = "";
}
function init(){
    $.get("query/getTableNames",function(data){
        // alert(data);
        tableNames = data;
        var tableSelect = "";
        for(var i=0;i<tableNames.length;i++){
            var option = createOption(tableNames[i],tableNames[i]);
            tableSelect = tableSelect.concat(option);
        }
        $("select[name='tableName']").append(tableSelect);
        tableNames = "";
    });
    //表名发生改变时
    $("select[name='tableName']").on("change",function(event){
        $("select[name='filedSelectName']").remove();
        $("div[name='fieldConditionDiv']").remove();
        $.get("query/getFieldNames?tableName="+$(this).val(),function(data){
            filedNames = data;
            var fieldSelect = createFieldSelect("filedSelectName");
            $("#t_tableInfoDiv").append(fieldSelect);
        });
    });

    //添加按钮的事件
    $("#addCondition").on("click",function(event){
       var condition = createCondition();
        $("#f_conditionDiv #buttonDiv").before(condition);
    });

    //给删除条件添加事件
    $("#f_conditionDiv").on("click",".deleteCondition",deleteCondition);

    //操作符发生改变时
   // $("#f_conditionDiv").on("change",".op",setCondition);

    //提交 通过表单的方式
  /* $("#sb").on("click",function(event){
       $("#form input[name='tableName']").val($("#t_tableInfoDiv select[name='tableName']").val());
       var conditions = setCondition();
       for(var s in conditions){
         //  alert(conditions[s]);
           var name = getFieldNameFromCondition(conditions[s]);
        //   alert(name);
           var value = getFieldValueFromCondition(conditions[s]);
           var hidden = createHidden(name,value);
           $("#form").append(hidden);
       }
       $("#form").submit();
   });*/
    //通过Ajax方式
    $("#sb").on("click",function(event) {
        formSubmit();
    });

    $("#reset").on("click",function(){
        $("div[name='fieldConditionDiv']").remove();
    });

}
/*--------------------------*/
function formSubmit(){
    var conditions = setCondition();
    //print(conditions);
    var parameter = getJsonByArray2(conditions);
    // alert(parameter);
    $.post("query/getQueryResult",parameter,function(data){
        // alert(data.result);
        queryData = data;
        if(data.result=='0'){
            for(var i in data.message){
                alert(data.message[i]);
            }
        }
        handelPagerData(data);
        addJpage();
    },"json");

}
/*--------------------创建option---------------------*/
function createOption(value,text){
    var option = "<option value='"+value+"'>"+text+"</option>";
    return option;
}
/*--------------------创建FieldSelect---------------------*/
function createFieldSelect(selectName){
    var fieldSelect ="<select name='"+selectName+"'>";
    fieldSelect = fieldSelect.concat(createOption("","可利用字段"));
    for(var i=0;i<filedNames.length;i++){
        fieldSelect = fieldSelect.concat(createOption(filedNames[i],filedNames[i]));
    }
    fieldSelect = fieldSelect.concat("</select>");
    return  fieldSelect;
}
/*---------创建操作符 选择框--------------*/
function createOperation(opName){
    var operation = "<select class='op' name='"+opName+"'>" +
        "<option value='0'>  </option>" +
        "<option value='1'> = </option>" +
        "<option value='2'> < </option>" +
        "<option value='3'> > </option>" +
        "<option value='4'> >= </option>" +
        "<option value='5'> <= </option>" +
        "</select>";
    return operation;
}
/*------------创建查询条件-------------------------*/
function createCondition(){
    var fieldSelect = createFieldSelect("");
    var operation = createOperation("");
    var input = createInput();
    return "<div name='fieldConditionDiv'>"+ fieldSelect+operation+input+"</div>";
}


/*-----------创建文本输入框------------*/
function createInput(){
    var input = "<input type='text'/><span class='deleteCondition'>×</span><input type='hidden'/>";
    return input;
}
function createHidden(name,value){
    var hidden = "<input type='hidden' name='"+name+"' value='"+value+"'/>";
    return hidden;
}
/*---------------删除条件------------*/

function deleteCondition(){
    $(this).parent("div[name='fieldConditionDiv']").remove();
}

/*--------------- ------------*/
function setCondition(){
    /*var fieldName = $(this).prev("select").val().trim();
    var operation = $(this).val();
    var operationTem = parseInt(operation);
    var op = getOp(operationTem);
    var fieldValue = $(this).next("input").val().trim();

    //对于为空的字段，不将其加入到表单的隐藏域中
    if(""==fieldName || fieldName.length <=0){
        alert("字段不能为空.....");
        return;
    }*/
    var condition = new Array();
    $(".op").each(function(index){
        var fieldName = $(this).prev("select").val().trim();
        var operation = $(this).val();
        var operationTem = parseInt(operation);
        var op = getOp(operationTem);
        var fieldValue = $(this).next("input[type='text']").val().trim();
        //对于为空的字段，不将其加入到表单的隐藏域中
        if(""!=fieldName && fieldName.length >0&&""!=op&&op.length>0&&fieldValue!=""&&fieldValue.length>0){
              condition.push(fieldName+":"+fieldName+op+fieldValue);
        }
    });
    condition.push("tableName:"+$("#t_tableInfoDiv select[name='tableName']").val());
    condition.push("or_and:"+$("#buttonDiv select[name='or_and']").val());
    return condition;

}

function getOp(n){
    switch (n){
        case 0: return "";
        case 1: return "=";
        case 2: return "<";
        case 3: return ">";
        case 4: return ">=";
        case 5: return "<=";
        default : return "";
    }
}

function getFieldNameFromCondition(condition){
    var array = condition.split(":");
    return array[0];
}
function getFieldValueFromCondition(condition){
    var array = condition.split(":");
    return array[1];
}

/*以下转化会导致同名值被覆盖*/
function getJsonByArray(conditions){
    var json = "{";
    for(var s in conditions){
        var name = getFieldNameFromCondition(conditions[s]);
        var value= getFieldValueFromCondition(conditions[s]);
        json=json.concat("\""+name+"\":\""+value+"\"");
        if(s != conditions.length-1) json=json.concat(",");
    }
   // json=json.concat(",\"tableName\":"+"\""+$("#t_tableInfoDiv select[name='tableName']").val()+"\"");
    json = json.concat("}");
    //alert(json);
    json=jQuery.parseJSON(json);
    return json;
}
/*为避免同名覆盖，只要是查询条件，除了tableName和or_and参数，其他的json数据的key为有序数字*/
function getJsonByArray2(conditions){
    var n=1;
    var json = "{";
    for(var s in conditions){
        var name = getFieldNameFromCondition(conditions[s]);
        if("tableName"!=name && "or_and"!=name){
             name=n++;
        }
        var value= getFieldValueFromCondition(conditions[s]);
        json=json.concat("\""+name+"\":\""+value+"\"");
        if(s != conditions.length-1) json=json.concat(",");
    }
    // json=json.concat(",\"tableName\":"+"\""+$("#t_tableInfoDiv select[name='tableName']").val()+"\"");
    json = json.concat("}");
    json=jQuery.parseJSON(json);
   //alert(json);
    return json;
}
/*------------------处理pager数据---------------------*/
function handelPagerData(dataDto){
    //先将原来的数据删除
    $("#tableShowDiv table thead tr").remove();
    $("#tableShowDiv table tbody tr").remove();
    var thead = createThead(dataDto.names);
    $("#tableShowDiv table thead").append(thead);
  //  alert(dataDto.pager.n[0].RECORD_ID);
    //var ds = dataDto.pager.datas;
    //alert(ds[1][n[0]]);
    var names = dataDto.names;
    var datas = dataDto.pager.datas;
    createTbody(names,datas);


}

function createThead(names){
    var tds = "<tr>";
    for(var i=0;i<names.length;i++){
        var th = createTh(names[i]);
        tds=tds.concat(th);
    }
    tds = tds.concat("</tr>");
    return tds;
}

//pagerdatas 为 List<Map<string,Object>>
function createTbody(names,pagerDatas){
    for(var i=0;i<pagerDatas.length;i++){
        var tds = '';
        var map = pagerDatas[i];
        for(var j=0;j<names.length;j++){
            var name = names[j];
            var value = map[name];
            tds=tds.concat(createTd(value));
        }

        var tr = createTr(tds);
        $("#tableShowDiv table tbody").append(tr);
    }
}


function createTr(tds){
    var tr = "<tr>";
    tr=tr.concat(tds);
    tr=tr.concat("</tr>")
    return tr;
}

function createTd(text){
    var td = "<td>"+text+"</td>";
    return td;
}
function createTh(text){
    var th = "<th>"+text+"</th>";
    return th;
}

function addJpage(){
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
}

/*--------test   打印条件------------------*/
function print(conditions){
    for(var s in conditions){
        alert(conditions[s]);
    }
}