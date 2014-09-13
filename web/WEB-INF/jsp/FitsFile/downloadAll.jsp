<%@ page import = "com.vogoal.util.JspFileDownload"%>
<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.io.*,java.util.*, ni.*, java.sql.* ,org.apache.tools.zip.*"%>
<%@page import= "com.graduation.common.SystemContext"%>
<% 
String[] paths = request.getParameterValues("attachmentPath"); 


	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/"+"fits/";
	String[] filepaths=new String[paths.length];
	for(int i=0;i<paths.length;i++){
		
		filepaths[i]=basePath+(String)paths[i];
		out.println("~~~~~~~~~~"+filepaths[i]);

	}

      ZipOutputStream zos=null;
      ServletOutputStream sos=null;
      java.io.InputStream in=null; 
      //comm_data cdata=new comm_data();
      try{
    	  out.clear();  
    	  out = pageContext.pushBody();
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
          for(int i=0;i<paths.length;i++){
            
              String FilePath = filepaths[i];      //list为存放路径的数组 循环可以得到路径和文件名
              String FileName = paths[i];		//下载打包时的名称，以下是为把文件打包到第一目录而做
             
            //  if(FileName.indexOf("?")>0) FileName="";
            //  if(FileName.equals("")) FileName=FilePath; 
              
           //   System.out.println("~~~~~~File Path==="+FilePath);
      		//  System.out.println("FileName==="+FileName);
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

%>