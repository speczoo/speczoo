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
          response.setContentType("application/x-msdownload"); //֪ͨ�ͻ��ļ���MIME���ͣ�
          String filename = "default.zip";
          response.setHeader("Content-disposition","attachment;filename=" + filename);
          sos = response.getOutputStream();
          zos = new ZipOutputStream(sos);
          //���ܲ���

          ZipEntry ze = null;
          byte[] buf = new byte[2048]; //����ļ��õ��ֽ�����,ÿ�η���2048���ֽڵ��������
          int readLength = 0;
          int z=0;
       
        //��������,���  
          for(int i=0;i<paths.length;i++){
            
              String FilePath = filepaths[i];      //listΪ���·�������� ѭ�����Եõ�·�����ļ���
              String FileName = paths[i];		//���ش��ʱ�����ƣ�������Ϊ���ļ��������һĿ¼����
             
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
               System.out.println("��ȡ���ˣ�����");
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