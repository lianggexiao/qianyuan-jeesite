package com.qing.jeesite.modules.sys.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Component
public class WebInterceptorConfigurer extends WebMvcConfigurerAdapter{
    @Autowired
    private LogInterceptor logInterceptor;
    @Autowired
    private LogThread logThread;

    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(logInterceptor).addPathPatterns("/**");
        super.addInterceptors(registry);
        logThread.start();
    }
}
