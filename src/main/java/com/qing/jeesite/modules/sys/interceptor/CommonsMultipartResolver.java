package com.qing.jeesite.modules.sys.interceptor;

import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by liuq on 2017/2/27.
 */
@Component
public class CommonsMultipartResolver extends org.springframework.web.multipart.commons.CommonsMultipartResolver {

    @Override
    public boolean isMultipart(HttpServletRequest request){
         String uri = request.getRequestURI();
         if(uri.indexOf("common/ueditor/config")>0){
              return false;
         }
         return super.isMultipart(request);
     }

}
