package cz.muni.fi.pb138.silverspooncamelroutes;

/**
 * Exception representing problem in XSLTransformator.
 * 
 * @author PB138-SilverspoonTymA
 */
public class XSLTransformatorException extends RuntimeException {

    public XSLTransformatorException(String msg) {
        super(msg);
    }

    public XSLTransformatorException(Throwable cause) {
        super(cause);
    }

    public XSLTransformatorException(String message, Throwable cause) {
        super(message, cause);
    }

}

