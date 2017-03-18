package com.qing.jeesite;

import com.qing.jeesite.modules.sys.service.SystemService;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;

/**
 * qing-jeesite
 * springboot的启动类
 * Created by wolfking(赵伟伟)
 * Created on 2017/1/8 16:20
 * Mail zww199009@163.com
 */
@EnableCaching
@SpringBootApplication
@ServletComponentScan("com.qing.jeesite")
@ComponentScan(value = "com.qing.jeesite",lazyInit = true)
public class WolfkingJeesiteDriver {
    public static void main(String[] args) {
        new SpringApplicationBuilder(WolfkingJeesiteDriver.class).web(true).run(args);
        SystemService.printKeyLoadMessage();
    }
}
