package cz.muni.fi.pb138.silverspooncamelroutes;

import java.io.File;
import java.io.IOException;
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
 * Class representing XSD validator which validates given XML files.
 * 
 * @author PB138-SilverspoonTymA
 */
public class XMLValidator {
    
    /**
     * Handler for validation errors.
     */
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
    
    /**
     * Constructor which initialize document builder.
     */
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
    
    /**
     * Sets given XSD schema as validator.
     * 
     * @param schemaFile XSD schema for validation
     */
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
    
    /**
     * Decide if given XML file si valid or not.
     * 
     * @param file file to check
     * @return true if is valid
     */
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
