package cz.muni.fi.pb138.silverspooncamelroutes;

import com.sun.xml.internal.ws.server.DraconianValidationErrorHandler;
import java.io.File;
import java.io.IOException;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import org.xml.sax.SAXException;

/**
 *
 * @author viktor
 */
public class XMLValidator {
    
    private DocumentBuilder docBuilder;
    
    public XMLValidator(File schemaFile){
        try {
            SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema = sf.newSchema(schemaFile);
            
            DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            
            dbf.setSchema(schema);
            docBuilder = dbf.newDocumentBuilder();
            docBuilder.setErrorHandler(new DraconianValidationErrorHandler());
        } catch (SAXException ex) {
            throw new XMLValidatorException("Invalid schema: " + ex.getMessage());
        } catch (ParserConfigurationException ex) {
            throw new XMLValidatorException("Parser configuration error: " + ex.getMessage());
        }
    }
    
    public boolean validate(String xmlFilename){
        try {
            docBuilder.parse(new File(xmlFilename));
        } catch (SAXException ex) {
            return false;
        } catch (IOException ex) {
            throw new XMLValidatorException(ex);
        } 
        return true;
    }
}
