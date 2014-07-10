package com.graduation.dao.impl;

import com.graduation.common.Pager;
import com.graduation.common.SystemContext;
import com.graduation.dao.ISqlQueryDao;
import com.graduation.util.ResultSetHandleUtil;
import com.graduation.util.TableHandleUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by xiaoquan on 2014/5/17.
 */
public class SqlQueryDao extends BaseDao implements ISqlQueryDao {


    public Pager<Map<String, Object>> executeSql(String sql) throws SQLException {
        Pager<Map<String,Object>> pager = new Pager<Map<String, Object>>();
        //查询总记录数
        long total = 0;
        //对Sql完成分页的包装
        Integer pageSize = SystemContext.getPageSize();
        Integer pageOffset = SystemContext.getPageOffset();
        String pagerSql=sql+" "+"limit "+" "+pageOffset+", "+pageSize;
        Connection con = this.getSqlSessionTemplate().getConnection();
        Statement statement = con.createStatement();
        //判断是否是修改语句
        ResultSet rs = null;
        boolean isSqlUpdate = TableHandleUtil.isSqlUpdate(pagerSql);
        if (isSqlUpdate){
            statement.executeUpdate(pagerSql);
        }else {
            String countSql = TableHandleUtil.getSqlQueryCount(sql);
            ResultSet rsCount = statement.executeQuery(countSql);
            total = ResultSetHandleUtil.getCountByResultSet(rsCount);
            statement.clearBatch();
            rs = statement.executeQuery(pagerSql);
        }
        List<Map<String, Object>> lmps = null;/*new ArrayList<Map<String,Object>>()*/
        if(rs != null){
            lmps = ResultSetHandleUtil.ResultSetHandle(rs);
        }

        pager.setDatas(lmps);
        pager.setOffset(pageOffset);
        pager.setTotal(total);
        return pager;

    }

}
