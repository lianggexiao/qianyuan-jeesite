package com.qing.jeesite.common.core;

import java.sql.SQLException;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.alibaba.druid.pool.DruidDataSource;
/**
 * 配置权限数据源
 * @author essence
 *
 */
@Configuration
@MapperScan(basePackages = "com.qing.jeesite.modules.sys.dao", sqlSessionTemplateRef = "sysSqlSessionTemplate")
public class SysDataSourceConfig {

	@Bean(name = "sysDataSource")
	@Primary
	@ConfigurationProperties(prefix = "spring.datasource-sys")
	public DataSource sysDataSource() throws SQLException {
		DruidDataSource dataSource = new DruidDataSource();
		return dataSource;
	}

	@Bean(name = "sysSqlSessionFactory")
	public SqlSessionFactory sysSqlSessionFactory(@Qualifier("sysDataSource") DataSource dataSource)
			throws Exception {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(dataSource);
		bean.setMapperLocations(
				new PathMatchingResourcePatternResolver().getResources("classpath:/mappings/sys/*.xml"));
		bean.setTypeAliasesPackage("com.qing.jeesite.modules.sys.dao");
		bean.setConfigLocation(new ClassPathResource("/mybatis-config.xml"));
		return bean.getObject();
	}

	@Bean(name = "sysSqlSessionTemplate")
	public SqlSessionTemplate sysSqlSessionTemplate(
			@Qualifier("sysSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
