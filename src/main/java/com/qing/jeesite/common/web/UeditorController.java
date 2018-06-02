package com.qing.jeesite.common.web;

import com.qing.jeesite.common.baidu.ueditor.ActionEnter;
import com.qing.jeesite.common.web.BaseController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping(value = "${adminPath}/common/ueditor")
public class UeditorController extends BaseController {
   
	@RequestMapping(value="/config")
    public void config(HttpServletRequest request,HttpServletResponse response){
        try {
            response.setContentType("application/json");
            request.setCharacterEncoding("UTF-8");
            response.setHeader("Content-Type","text/html");
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String exec = new ActionEnter(request,realPath).exec();
            PrintWriter writer = response.getWriter();
            writer.write(exec);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
}
