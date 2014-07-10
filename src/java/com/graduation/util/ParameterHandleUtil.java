package com.graduation.util;

import com.graduation.model.SearchParam;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class ParameterHandleUtil {

    /**
     * sp中封装所有参数字段，将合法的参数字段存放在 parameters中
     *
     * @param sp         封装参数的对象
     * @param parameters 合法的参数存放的位置
     * @return 参数验证失败的信息
     */
    public static List<String> handleParameters(SearchParam sp, Map<String, Object> parameters) {
        List<String> errorMsg = new ArrayList<String>();
        if (sp.getPlanId() != null && !"".equals(sp.getPlanId().trim()))
            parameters.put("planId", sp.getPlanId());
        if (sp.getObjtype() != null && !"".equals(sp.getObjtype().trim()))
            parameters.put("objtype", sp.getObjtype());
        if (sp.getClz() != null && !"".equals(sp.getClz().trim()))
            parameters.put("clz", sp.getClz());
        addParam("mjd", sp.getMjd(), sp.getMjdMin(), sp.getMjdMax(), errorMsg, parameters);
        addParam("ra", sp.getRa(), sp.getRaMin(), sp.getRaMax(), errorMsg, parameters);
        addParam("dec", sp.getDec(), sp.getDecMin(), sp.getDecMax(), errorMsg, parameters);
        addParam("snu", sp.getSnu(), sp.getSnuMin(), sp.getSnuMax(), errorMsg, parameters);
        addParam("sng", sp.getSng(), sp.getSngMin(), sp.getSngMax(), errorMsg, parameters);
        addParam("snr", sp.getSnr(), sp.getSnrMin(), sp.getSnrMax(), errorMsg, parameters);
        addParam("sni", sp.getSni(), sp.getSniMin(), sp.getSniMax(), errorMsg, parameters);
        addParam("snz", sp.getSnz(), sp.getSnzMin(), sp.getSnzMax(), errorMsg, parameters);
        addParam("z", sp.getZ(), sp.getzMin(), sp.getzMax(), errorMsg, parameters);
        return errorMsg;
    }

    public static void addParam(String name, String value, String valueMin, String valueMax,
                                List<String> errorMsg, Map<String, Object> parameters) {
        if (!isNullOrEmpty(value)) {
            if (!isNumber(value)) {
                errorMsg.add(name + "字段不是数字类型...");
            } else {
                parameters.put(name, value);
                parameters.put(name + "Min", Double.parseDouble(value));
                parameters.put(name + "Max", Double.parseDouble(value));
            }
        } else {

            if (!isNullOrEmpty(valueMin) && !isNullOrEmpty(valueMax)) {
                if (!isNumber(valueMin)) {
                    errorMsg.add(name + "字段不是数字...");
                    return;
                }
                if (!isNumber(valueMax)) {
                    errorMsg.add(name + "字段不是数字...");
                    return;
                }
                if (Double.parseDouble(valueMin) > Double.parseDouble(valueMax)) {
                    errorMsg.add(name + "的最小值不能比最大值大...");
                    return;
                }
                parameters.put(name, valueMin);
                parameters.put(name + "Min", Double.parseDouble(valueMin));
                parameters.put(name + "Max", Double.parseDouble(valueMax));
            } else if (!isNullOrEmpty(valueMin)) {
                if (!isNumber(valueMin)) {
                    errorMsg.add(name + "字段不是数字...");
                    return;
                }
                parameters.put(name, valueMin);
                parameters.put(name + "Min", Double.parseDouble(valueMin));
                parameters.put(name + "Max", Double.MAX_VALUE);
            } else if (!isNullOrEmpty(valueMax)) {
                if (!isNumber(valueMax)) {
                    errorMsg.add(name + "字段不是数字...");
                    return;
                }
                parameters.put(name, valueMax);
                parameters.put(name + "Min", Double.MIN_VALUE);
                parameters.put(name + "Max", Double.parseDouble(valueMax));

            }

        }

    }


    public static boolean isNullOrEmpty(String value) {
        if (value != null && !"".equals(value.trim()))
            return false;
        return true;

    }

    public static boolean isNumber(String str) {
        try {
            Double.parseDouble(str);
            return true;
        } catch (NumberFormatException e) {
            // TODO Auto-generated catch block
            return false;
        }
    }
    
    public static boolean isInteger(String str){
        try {
            Integer.parseInt(str);
            return  true;
        }catch (Exception e){
            return  false;
        }
    }


    @Test
    public void test01() {
        System.out.println(Double.parseDouble("1.80200000000E-05"));
        System.out.println(ParameterHandleUtil.isNumber("1.80200000000E-05"));
    }

    public static String gernerateSql(String tableName,HttpServletRequest request){
        StringBuilder sql = new StringBuilder();
        sql.append("select * from");
        sql.append(" "+tableName+" t");

        String or_and = request.getParameter("or_and");

        List<String> values = new ArrayList<String>();
        Enumeration es = request.getParameterNames();
        while (es.hasMoreElements()){
            String pname = es.nextElement().toString();
            if("tableName".equals(pname)) continue;
            if("or_and".equals(pname)) continue;
            if(ParameterHandleUtil.isInteger(pname)){
                String[] vs = request.getParameterValues(pname);
                for(int i=0;i<vs.length;i++){
                    System.out.println("TTTTTTT:"+vs[i]);
                    values.add(vs[i]);
                }
            }
        }

        if("0".equals(or_and) && values.size()>0){
            sql.append(" where 1=2 ");
            for(String value : values){
                sql.append(" or t."+value);
            }
        }else{
            sql.append(" where 1=1 ");
            for(String value : values){
                sql.append(" and t."+value);
            }
        }

        //分页添加
       /* Integer pageSize = 15;javascript完成分页
        Integer pageOffset = (pagenumber-1)*pageSize;
        sql.append(" "+"limit "+" "+pageOffset+", "+pageSize);*/
        return sql.toString();
    }

}
