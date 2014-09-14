package com.graduation.controller;

import com.graduation.common.SystemContext;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/fits")
public class FitsFileController {

	/*@RequestMapping(value="/../resources/fits/{s.path}",method=RequestMethod.GET)
    public String FitsFile(){
		return "FitsFile/FitsDownload";
	}*/

    @RequestMapping(value = "/{path}", method = RequestMethod.GET)
    public void download(@PathVariable("path") String Name, HttpServletResponse response) {
        String FitsPath = SystemContext.getRealPath() + "/" + Name + ".fits";

		response.reset();
        File file = new File(FitsPath);
        String fileName = file.getName();
        //response.setContentType("text/html;charset=utf-8");
        response.setContentType("application/fits;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes()));
        System.out.println(file.length());
        try{
        	FileInputStream fis=new FileInputStream(FitsPath);
        
//        try {
//           FileUtils.copyFile(file, response.getOutputStream());
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
            OutputStream os=new BufferedOutputStream(response.getOutputStream());
			os.flush();
			byte[] b=new byte[100];  
			int len=0;  
			while((len=fis.read(b))>0){   
				os.write(b,0,len);  
			}
			 
			os.close();		
			//response.setCharacterEncoding("UTF-8");
			response.setContentType("application/octet-stream;charset=UTF-8"); 
			String fitsName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename="+fitsName);
	
			response.getOutputStream();
		} catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    
			
			
			
    	
    }
		
    @RequestMapping(value="/downloadAll",method = RequestMethod.POST)
    public String downloadAll() {

        return "FitsFile/downloadAll";
    }

    
    


}
