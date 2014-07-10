package com.graduation.model;

/**
 * 存储哪个用户创建了哪个表，以及该表的行数
 *
 * @author xiaoquan
 */
public class MydbElement {
    private Integer id;
    private String tableName;//表名
    private Long rowNum = 0L; //表的行数
    private Integer uid;//用户id

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getRowNum() {
        return rowNum;
    }

    public void setRowNum(Long rowNum) {
        this.rowNum = rowNum;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }


}
