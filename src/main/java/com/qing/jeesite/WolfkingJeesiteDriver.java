package com.qing.jeesite;

import com.qing.jeesite.modules.sys.service.SystemService;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.MultipartAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import com.qing.jeesite.modules.sys.interceptor.CommonsMultipartResolver;

/**
 * qing-jeesite
 * springboot的启动类
 * Created by wolfking(赵伟伟)
 * Created on 2017/1/8 16:20
 * Mail zww199009@163.com
 */
@EnableCaching
//exclude表示自动配置时不包括Multipart配置
@EnableAutoConfiguration(exclude = {MultipartAutoConfiguration.class})
@SpringBootApplication
@ServletComponentScan("com.qing.jeesite")
@ComponentScan(value = "com.qing.jeesite",lazyInit = true)
public class WolfkingJeesiteDriver {
    public static void main(String[] args) {
        new SpringApplicationBuilder(WolfkingJeesiteDriver.class).web(true).run(args);
        SystemService.printKeyLoadMessage();
    }

    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setDefaultEncoding("UTF-8");
        //      resolver.setResolveLazily(true);// resolveLazily属性启用是为了推迟文件解析
        //      resolver.setMaxInMemorySize(40960);
        resolver.setMaxUploadSize(20 * 1024 * 1024);// 上传文件大小 20M 50*1024*1024
        return resolver;
    }
}
