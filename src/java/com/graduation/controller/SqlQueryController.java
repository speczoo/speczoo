package com.graduation.controller;

import com.graduation.common.Pager;
import com.graduation.model.AuthorityMethod;
import com.graduation.model.AuthorityType;
import com.graduation.service.ISqlQueryService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by xiaoquan on 2014/5/17.
 */
@Controller
@RequestMapping("/sql")
public class SqlQueryController {

    @Inject
    private ISqlQueryService sqlQueryService;

    @AuthorityMethod(authorityTypes = AuthorityType.SQL_QUERY)
    @RequestMapping(value = "/sqlsearch",method = RequestMethod.GET)
    public String toSqlpage(){
        return "sql/sqlsearch";
    }

    @AuthorityMethod(authorityTypes = AuthorityType.SQL_QUERY)
    @RequestMapping(value = "/sqlsearch",method = RequestMethod.POST)
    public String showData(@RequestParam("sql") String sql,Model model){
        ArrayList<String> error = new ArrayList<String>();
        if (sql == null || "".equals(sql.trim())) {
            error.add("sql语句不能为空....");
            model.addAttribute("error", error);
            model.addAttribute("sql", sql);
            return "sql/sqlsearch";
        }
        Pager<Map<String,Object>> pager = null;
        try {
            pager = this.sqlQueryService.executeSql(sql,error);
            if (null == pager)
                return "sql/sqlsearch";
        } catch (SQLException e) {
           // e.printStackTrace();
            error.add("SQL语句异常....,或者您删除的数据中含有被参照的数据");
            model.addAttribute("error",error);
            return "sql/sqlsearch";
        }
        List<Map<String,Object>> lmps = pager.getDatas();
        model.addAttribute("names", lmps.get(0).keySet());
        model.addAttribute("lmps", lmps);
        model.addAttribute("error", error);
        model.addAttribute("sql", sql);
        model.addAttribute("total",pager.getTotal());
        return "sql/sqlsearch";
    }
}
