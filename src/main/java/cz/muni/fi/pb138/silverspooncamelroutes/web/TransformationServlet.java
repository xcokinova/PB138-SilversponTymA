package cz.muni.fi.pb138.silverspooncamelroutes.web;

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
 * Servlet for managing books.
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
                
                Part filePart = request.getPart("file"); 
                 
                if(filePart.getSize() == 0){
                    request.setAttribute("chyba", "Musíte vybrať XML súbor.");
                    initializePage(request, response);
                    return;
                }
                                             
                File directory = new File(getServletContext().getRealPath("/"));
                File file = File.createTempFile("tmp", ".xml", directory);
                
                try(OutputStream out = new FileOutputStream(file)){
                    try(InputStream filecontent = filePart.getInputStream()){
                        
                        int read;
                        final byte[] bytes = new byte[1024];

                        while ((read = filecontent.read(bytes)) != -1) {
                            out.write(bytes, 0, read);
                        }
                        log.error("File" + file + "being uploaded to" + directory);
                        
                        try {
                            File outSVG = getXSLTransformator().transform(file, directory);                           
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

    /**
     * Gets BookManager from ServletContext, where it was stored by {@link StartListener}.
     *
     * @return BookManager instance
     */
    private XSLTransformator getXSLTransformator() {
        return (XSLTransformator) getServletContext().getAttribute("xslTransformator");
    }
    
    private void initializePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(LIST_JSP).forward(request, response);
    }

}
