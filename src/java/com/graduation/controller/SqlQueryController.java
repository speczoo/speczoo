package com.graduation.controller;

import com.graduation.common.Pager;
import com.graduation.common.SystemContext;
import com.graduation.model.AuthorityMethod;
import com.graduation.model.AuthorityType;
import com.graduation.model.User;
import com.graduation.service.IMydbService;
import com.graduation.service.ISqlQueryService;
import com.graduation.util.ResultSetHandleUtil;
import com.graduation.util.TableHandleUtil;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by xiaoquan on 2014/5/17.
 * Changed by tyang on 2014-8-19.
 */
@Controller
@RequestMapping("/sql")
public class SqlQueryController {

    @Inject
    private ISqlQueryService sqlQueryService;

	private String sql;

	private List<Map<String, Object>> lmps;


    @AuthorityMethod(authorityTypes = AuthorityType.SQL_QUERY)
    @RequestMapping(value = "/sqlsearch",method = RequestMethod.GET)
    public String toSqlpage(){
        return "sql/sqlsearch";
    }

    @AuthorityMethod(authorityTypes = AuthorityType.SQL_QUERY)
    @RequestMapping(value = "/sqlsearch",method = RequestMethod.POST)
    public String showData(@RequestParam("sql") String sql,Model model){
        ArrayList<String> error = new ArrayList<String>();
        if (sql == null || "".equals(sql.trim())){
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
       System.out.println("lmps的size："+lmps.size());
        this.lmps=lmps;
        
        
        model.addAttribute("names", lmps.get(0).keySet());
        model.addAttribute("lmps", lmps);
        model.addAttribute("error", error);
        model.addAttribute("sql", sql);
        model.addAttribute("total",pager.getTotal());
      //  model.addAttribute("paths", paths); 
        
        this.sql=sql;
        return "sql/sqlsearch";
    }
    
    @RequestMapping(value = "/sqldownload",method = RequestMethod.POST)
    public String sqldown(@RequestParam("record_id") String record_id,@RequestParam(defaultValue="") String fileSource,HttpServletResponse response,HttpSession session){
    	
		Pattern p=Pattern.compile("(.*from\\s)(\\w*)(.*)");
		Matcher m=p.matcher(this.sql);
		String tableName=null;
		
		if(m.find()){
			System.out.println("~~~~~~~~~~~TABLE NAME="+m.group(2));
			tableName=m.group(2);
			}
		else{
				System.out.println("~~~~~~~~~~~TABLE NAME=false");
				tableName="false";
			} 
		if (tableName.equals("fithas")){
				 return "redirect:/sql/fitsDownload/" + record_id;
	    
	        }else{
	        	 return "redirect:/sql/tableDownload/" + tableName;
	        }
	
    }
    @RequestMapping(value = "/tableDownload/{tableName}")
  public void SqlTableDownload(@PathVariable("tableName") String tableName,@RequestParam(defaultValue="") String fileSource,HttpServletResponse response,HttpSession session){
		  try {//fileSource表示从哪里取数据，如果为空则从数据库里面取，如果为zip则到fits/username/tablename/下取zip文件
	      	//如果是file则到fits/username/tablename下取未打包的文件
			User loginUser = (User) session.getAttribute("loginUser");
	
	  		System.out.println("~~~~~~~+ls"+lmps);
	  		String fileName = new String(tableName.getBytes("UTF-8"), "ISO-8859-1");
	
	  	
	  		response.reset();
	  		response.setCharacterEncoding("UTF-8");
	  		response.setContentType("application/octet-stream;charset=UTF-8");
	  		if("file".equals(fileSource)){
	      	String realPath = SystemContext.getRealPath()+"/"+loginUser.getUsername()+"/"+TableHandleUtil.getRealTableName(tableName);
	  		File fileFile = new File(realPath,tableName);
	  		String zipFileName = new String(fileFile.getName().getBytes("UTF-8"), "ISO-8859-1");
	  		response.setHeader("Content-Disposition", "attachment;filename=" + zipFileName);
	  		IOUtils.copy(new FileInputStream(fileFile),response.getOutputStream());
	  		
	  		}else if("zip".equals(fileSource)){
		      	String realPath = SystemContext.getRealPath();
		      	File zipFile = new File(realPath+"/temp","data.zip");
		  		String zipFileName = new String(zipFile.getName().getBytes("UTF-8"), "ISO-8859-1");
		  		response.setHeader("Content-Disposition", "attachment;filename=" + zipFileName);
		  		IOUtils.copy(new FileInputStream(zipFile),response.getOutputStream());
		  		FileUtils.deleteQuietly(new File(realPath+"/temp"));
		  		
	  		}else{
		      	System.out.println("到这里了吗？TXT !");
		      	fileName = fileName + ".txt";
		      	System.out.println("!!!!fileName!!!"+fileName);
		      	response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		      	ResultSetHandleUtil.listMap2OutputStream(lmps, response.getOutputStream());
	      	
	  		}
		  } catch (UnsupportedEncodingException e) {
		      // TODO Auto-generated catch block
		      e.printStackTrace();
		  } catch (IOException e) {
		      // TODO Auto-generated catch block
		      e.printStackTrace();
		  }


	  
  }

   
    @RequestMapping(value = "/fitsDownload/{record_id}")
    public void sqlFitsDownlod(@PathVariable("record_id") String record_id,HttpServletResponse response,HttpSession session){
        String[] pathValues=new String[lmps.size()];
        for (int i=0;i<lmps.size();i++){
	    	
	    	pathValues[i]=(String)lmps.get(i).get("path");
	    	
	    }
        //得到paths;
       String[] paths=new String[pathValues.length];
    		for (int i=0;i<pathValues.length;i++){
    			paths[i]=pathValues[i].substring(pathValues[i].indexOf("spec"));
    			//System.out.println( "得到的paths=="+paths[i]);
    		}
    	//得到勾选的编号checkedNumber；	
    	String[] record=record_id.split(",");
    	 List<String> tmp = new ArrayList<String>();  
         for(String str:record){  
             if(str!=null && str.length()!=0){  
                 tmp.add(str);  
             }  
         }  
         record = tmp.toArray(new String[0]);
    	int[] checkedNumber = new int[record.length];
    	
    	for (int i=0;i<record.length;i++){
    		
    			System.out.println("字符串record:"+record[i]);
    			checkedNumber[i]=Integer.parseInt(record[i]);
    			System.out.println("得到勾选的编号checkedNumber=="+checkedNumber[i]);
    		
    		
    	}
    	String[] filepaths=new String[checkedNumber.length];
    	System.out.println("checkedNumber的长度"+checkedNumber.length);
    	for(int j=0;j<checkedNumber.length;j++){
    		System.out.println("checkedNumber的值:"+checkedNumber[j]);
    		for(int i=0;i<paths.length;i++){
    			
   			 if(i==checkedNumber[j]){
   				 filepaths[j]=paths[i];
   				 System.out.println("第几个"+j+"的值"+filepaths[j]);
   			}
   		 }
   		 
   	 }
    	ZipOutputStream zos=null;
        ServletOutputStream sos=null;
        java.io.InputStream in=null;
        //comm_data cdata=new comm_data();
        try{

            response.reset();
            response.setContentType("application/x-msdownload"); //通知客户文件的MIME类型：
            String filename = "default.zip";
            response.setHeader("Content-disposition","attachment;filename=" + filename);
            sos = response.getOutputStream();
            zos = new ZipOutputStream(sos);
            //接受参数


            ZipEntry ze = null;
            byte[] buf = new byte[2048]; //输出文件用的字节数组,每次发送2048个字节到输出流：
            int readLength = 0;
            int z=0;
         
          //处理数组,打包  
            for(int i=0;i<filepaths.length;i++){
              
               // String FilePath = filepaths[i];      //list为存放路径的数组 循环可以得到路径和文件名
                String FileName = filepaths[i];		//下载打包时的名称，以下是为把文件打包到第一目录而做
        		String FitsPath = SystemContext.getRealPath() + "/" + FileName;
                  File f = new File(FitsPath);

               ze = new ZipEntry(FileName);
               ze.setSize(f.length());
               ze.setTime(f.lastModified());
               zos.putNextEntry(ze);

               InputStream is = new BufferedInputStream( new FileInputStream(f));
               System.out.println("InputStream~~~~~~~~~~=="+is);
               while ( (readLength = is.read(buf, 0, 2048))!=-1) 
               {
                 zos.write(buf, 0, readLength);
                 System.out.println("读取到了！！！");
               }
               is.close();
             }
   
        }catch(Exception ex)
               {
              System.out.println("Error download:"+ex.toString());
               }finally
               {
               if(zos!=null){
              try
              {
                zos.close();
                sos.close();
              }catch(Exception ex)
              {
                 System.out.println("Error download:"+ex.toString());
              }
             }
             }
    	
    }
    
    /**
     * 暂时在这里写，可能以后会移到services，dao类中去；
     * @param List<Map<String, Object>> list , String key
     * @param list, String key
     * @return String[] values
     * @author tyang
     */
    @SuppressWarnings("null")
	public String[] getValuesByKey(List<Map<String, Object>> list , String key){
    	String[] values=null;
    	for (int i=0;i<list.size();i++){
	    	System.out.println( "SIZE:"+list.get(i).get(key));
	    	values[i]=(String)list.get(i).get(key);
	    }
    	return values;
    	
    }

}
