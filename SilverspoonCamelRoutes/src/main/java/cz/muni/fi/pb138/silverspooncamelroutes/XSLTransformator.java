package cz.muni.fi.pb138.silverspooncamelroutes;


import java.io.*;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;

/**
 * Class representing XSLT transformator.
 * 
 * @author PB138-SilverspoonTymA
 */
public class XSLTransformator {
    
    /**
     * Transform file by given scheme and save it to the given directory.
     * 
     * @param file file to transform
     * @param directory where save file
     * @param scheme scheme to transform file by
     * @return transformed file
     */
    public File transform(File file, File directory, File scheme) {
        
        if(file == null) throw new XSLTransformatorException(new NullPointerException("file"));
        if(directory == null) throw new XSLTransformatorException(new NullPointerException("directory"));
        if(scheme == null) throw new XSLTransformatorException(new NullPointerException("scheme"));
        
        // set the TransformFactory to use the Saxon TransformerFactoryImpl method 
        System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
        
        try {
            TransformerFactory tFactory = TransformerFactory.newInstance();

            Source xslDoc = new StreamSource(scheme);
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