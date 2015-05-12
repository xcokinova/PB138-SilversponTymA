package cz.muni.fi.pb138.silverspooncamelroutes.web;

import cz.muni.fi.pb138.silverspooncamelroutes.SpringConfig;
import cz.muni.fi.pb138.silverspooncamelroutes.XSLTransformator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class StartListener implements ServletContextListener {

    final static Logger log = LoggerFactory.getLogger(StartListener.class);

    @Override
    public void contextInitialized(ServletContextEvent ev) {
        log.info("webová aplikácia inicializovaná");
        ServletContext servletContext = ev.getServletContext();
        ApplicationContext springContext = new AnnotationConfigApplicationContext(SpringConfig.class);
        servletContext.setAttribute("xslTransformator", springContext.getBean("xslTransformator", XSLTransformator.class));
        log.info("manažéri vytvorení");
    }

    @Override
    public void contextDestroyed(ServletContextEvent ev) {
        log.info("aplikácia končí");
    }
}
