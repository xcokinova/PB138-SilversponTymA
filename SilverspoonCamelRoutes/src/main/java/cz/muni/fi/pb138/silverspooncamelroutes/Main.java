package cz.muni.fi.pb138.silverspooncamelroutes;



import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

/**
 *
 * @author jana
 */
public class Main {
    
    public static void main(String[] args) throws TransformerException {
        // set the TransformFactory to use the Saxon TransformerFactoryImpl method 
        System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
        
        String filesDir = System.getProperty("user.dir") + "\\src\\main\\java\\cz\\muni\\fi\\pb138\\silverspooncamelroutes\\files\\";
        
        try {
            TransformerFactory tFactory = TransformerFactory.newInstance();

            Source xslDoc = new StreamSource(filesDir + "SvgTemplate1.xsl");
            Source xmlDoc = new StreamSource(filesDir + "Input.xml");
            
            String outputFileName = filesDir + "SvgOutput1.svg";

            OutputStream htmlFile = new FileOutputStream(outputFileName);
            Transformer trasform = tFactory.newTransformer(xslDoc);
            trasform.transform(xmlDoc, new StreamResult(htmlFile));
        } 
        catch (FileNotFoundException e) 
        {
            e.printStackTrace();
        }
        /*
        catch (TransformerConfigurationException e) 
        {
            e.printStackTrace();
        }
        catch (TransformerFactoryConfigurationError e) 
        {
            e.printStackTrace();
        }
        catch (TransformerException e) 
        {
            e.printStackTrace();
        }*/
    }
    
}