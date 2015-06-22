package cz.muni.fi.pb138.silverspooncamelroutes;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
* Spring Java configuration class. See http://static.springsource.org/spring/docs/current/spring-framework-reference/html/beans.html#beans-java
*
* @author Viktor Bako (422557)
*/
@Configuration
public class SpringConfig {

    @Bean
    public XSLTransformator xslTransformator() {
        return new XSLTransformator();
    }
    
    @Bean
    public XMLValidator xmlValidator() {
        return new XMLValidator();
    }
}

