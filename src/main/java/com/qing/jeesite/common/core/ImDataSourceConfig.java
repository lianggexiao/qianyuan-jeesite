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
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.alibaba.druid.pool.DruidDataSource;


/**
 * 测试库数据源
 * @author essences
 *
 */
@Configuration
@MapperScan(basePackages = "com.qing.jeesite.modules.im.dao", sqlSessionTemplateRef = "imSqlSessionTemplate")
public class ImDataSourceConfig {

	@Bean(name = "imDataSource")
	@ConfigurationProperties(prefix = "spring.datasource-im")
	public DataSource testDataSource() throws SQLException {
		DruidDataSource dataSource = new DruidDataSource();
		return dataSource;
	}

	@Bean(name = "imSqlSessionFactory")
	public SqlSessionFactory testSqlSessionFactory(@Qualifier("imDataSource") DataSource dataSource)
			throws Exception {
		SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
		bean.setDataSource(dataSource);
		bean.setMapperLocations(
				new PathMatchingResourcePatternResolver().getResources("classpath:/mappings/im/*.xml"));
		bean.setTypeAliasesPackage("com.qing.jeesite.modules.im.dao");
		bean.setConfigLocation(new ClassPathResource("/mybatis-config.xml"));
		return bean.getObject();
	}

	@Bean(name = "imSqlSessionTemplate")
	public SqlSessionTemplate testSqlSessionTemplate(
			@Qualifier("imSqlSessionFactory") SqlSessionFactory sqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
