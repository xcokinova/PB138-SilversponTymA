package cz.muni.fi.pb138.silverspooncamelroutes;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import org.slf4j.LoggerFactory;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 *
 * @author viktor
 */
public class XMLValidator {
    
    class ValidationErrorsHandler implements ErrorHandler{

        @Override
        public void warning(SAXParseException exception) throws SAXException {
            LoggerFactory.getLogger(ValidationErrorsHandler.class).error(exception.getMessage(), exception);
        }

        @Override
        public void error(SAXParseException exception) throws SAXException {
            error = exception.getMessage();
            throw new SAXException(error);
        }

        @Override
        public void fatalError(SAXParseException exception) throws SAXException {
            error = exception.getMessage();
            throw new SAXException(error);
        }
        
    }
    
    private DocumentBuilder docBuilder;
    private String error;
    
    public XMLValidator(){
        try {
            DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            docBuilder = dbf.newDocumentBuilder();
            docBuilder.setErrorHandler(new ValidationErrorsHandler());
        } catch (ParserConfigurationException ex) {
            throw new XMLValidatorException("Error initializing parser: "+ ex);
        }
        
    }
    
    public void setValidator(File schemaFile){
        try {
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(schemaFile);
            
            DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            
            dbf.setSchema(schema);
            docBuilder = dbf.newDocumentBuilder();
            docBuilder.setErrorHandler(new ValidationErrorsHandler());
        } catch (SAXException ex) {
            throw new XMLValidatorException("Invalid schema: " + ex.getMessage());
        } catch (ParserConfigurationException ex) {
            throw new XMLValidatorException("Parser configuration error: " + ex.getMessage());
        }
    }
    
    public boolean validate(File file){
        try {
            docBuilder.parse(file);
        } catch (SAXException ex) {
            return false;
        } catch (IOException ex) {
            throw new XMLValidatorException(ex);
        } 
        return true;
    }
}
