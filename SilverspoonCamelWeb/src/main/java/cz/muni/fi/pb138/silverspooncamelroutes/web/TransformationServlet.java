package cz.muni.fi.pb138.silverspooncamelroutes.web;

import cz.muni.fi.pb138.silverspooncamelroutes.XMLValidator;
import cz.muni.fi.pb138.silverspooncamelroutes.XMLValidatorException;
import cz.muni.fi.pb138.silverspooncamelroutes.XSLTransformator;
import cz.muni.fi.pb138.silverspooncamelroutes.XSLTransformatorException;
import java.io.File;
import java.io.FileOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 * Servlet for managing silverspoon.io visualisation.
 */
@WebServlet(TransformationServlet.URL_MAPPING + "/*")
@MultipartConfig
public class TransformationServlet extends HttpServlet {

    private static final String LIST_JSP = "/transformation.jsp";
    public static final String URL_MAPPING = "/transformation";

    private final static Logger log = LoggerFactory.getLogger(TransformationServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        initializePage(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getPathInfo();
        switch (action) {
            case "/upload":
                int type = Integer.parseInt(request.getParameter("type"));
                Part filePart = request.getPart("file"); 
                
                // decide which scheme will be used
                File scheme = null;
                ClassLoader classLoader = getClass().getClassLoader();
                if(type == 1) scheme = new File(classLoader.getResource("SvgTemplate1.xsl").getFile());
                if(type == 2) scheme = new File(classLoader.getResource("BeagleBoneBlack.xsl").getFile());
                if(type == 3) scheme = new File(classLoader.getResource("CubieBoard2.xsl").getFile());
                
                // check file size
                if(filePart.getSize() == 0){
                    request.setAttribute("chyba", "Musíte vybrať XML súbor.");
                    initializePage(request, response);
                    return;
                }
                           
                // create temp file
                File directory = new File(getServletContext().getRealPath("/"));
                File file = File.createTempFile("tmp", ".xml", directory);
                
                try(OutputStream out = new FileOutputStream(file)){
                    try(InputStream filecontent = filePart.getInputStream()){
                        
                        int read;
                        final byte[] bytes = new byte[1024];

                        // copy content from uploaded file to temp file
                        while ((read = filecontent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }
                        log.error("File" + file + "being uploaded to" + directory);
                        
                        // validate file
                        try {
                            getXMLValidator().setValidator(new File(classLoader.getResource("CamelSchema.xsd").getFile()));
                            if(!getXMLValidator().validate(file)){
                                request.setAttribute("chyba", "Nevalidný XML súbor.");
                                initializePage(request, response);
                                return;
                            }
                        } catch(XMLValidatorException ex){
                            log.error("Error while validating file " + file, ex);
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
                            return;
                        }
                        
                        // transform file
                        try {
                            File outSVG = getXSLTransformator().transform(file, directory, scheme);                           
                            request.setAttribute("resultSVG", outSVG.getName());
                            initializePage(request, response);
                            //response.sendRedirect(request.getContextPath()+URL_MAPPING);
                            return;
                        } catch(XSLTransformatorException ex){
                            log.error("Cannot transform xml to svg", ex);
                            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
                            return;
                        }
                        
                    }
                }
            
            default:
                log.error("Unknown action " + action);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action " + action);
        }
    }

    private XSLTransformator getXSLTransformator() {
        return (XSLTransformator) getServletContext().getAttribute("xslTransformator");
    }
    
    private XMLValidator getXMLValidator() {
        return (XMLValidator) getServletContext().getAttribute("xmlValidator");
    }
    
    private void initializePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(LIST_JSP).forward(request, response);
    }

}

