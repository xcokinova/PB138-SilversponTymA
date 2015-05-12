package cz.muni.fi.pb138.silverspooncamelroutes;

import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

public class XSLTransformator {
    
    public File transform(File file, File directory) {
        // set the TransformFactory to use the Saxon TransformerFactoryImpl method 
        System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
        ClassLoader classLoader = getClass().getClassLoader();
        
        try {
            TransformerFactory tFactory = TransformerFactory.newInstance();

            Source xslDoc = new StreamSource(classLoader.getResource("SvgTemplate1.xsl").getFile());
            Source xmlDoc = new StreamSource(file);
            
            File outFile = File.createTempFile("tmp", ".svg", directory);
            
            OutputStream htmlFile = new FileOutputStream(outFile);
            Transformer trasform = tFactory.newTransformer(xslDoc);
            trasform.transform(xmlDoc, new StreamResult(htmlFile));
            
            return outFile;
        } 
        catch (TransformerException e) 
        {
            throw new XSLTransformatorException(e);
        }
        catch (FileNotFoundException e) 
        {
            throw new XSLTransformatorException(e);
        }
        catch (IOException e) 
        {
            throw new XSLTransformatorException(e);
        }

    }
    
}