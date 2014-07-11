package com.graduation.controller;

import com.graduation.common.SystemContext;
import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
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


        File file = new File(FitsPath);
        String fileName = file.getName();
        //response.setContentType("text/html;charset=utf-8");
        response.setContentType("application/fits;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes()));
        System.out.println(file.length());
        //	FileInputStream fis=new FileInputStream(FitsPath);
        try {
            FileUtils.copyFile(file, response.getOutputStream());
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
            /*OutputStream os=new BufferedOutputStream(response.getOutputStream());
			os.flush();
			byte[] b=new byte[100];  
			int len=0;  
			while((len=fis.read(b))>0){   
				os.write(b,0,len);  
			}
			os.flush();  
			os.close();
		} catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			*/
			
		/*	response.reset();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/octet-stream;charset=UTF-8"); 
			String fileName = new String(FitsName.getBytes("UTF-8"),"ISO-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename="+fileName);
			
			response.getOutputStream();
			*/

    }


}
