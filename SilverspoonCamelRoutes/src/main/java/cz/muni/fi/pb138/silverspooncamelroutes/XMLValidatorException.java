package cz.muni.fi.pb138.silverspooncamelroutes;

/**
 * Exception representing problem in XMLValidator.
 * 
 * @author PB138-SilverspoonTymA
 */
public class XMLValidatorException extends RuntimeException {
    
    public XMLValidatorException(String msg) {
        super(msg);
    }

    public XMLValidatorException(Throwable cause) {
        super(cause);
    }

    public XMLValidatorException(String message, Throwable cause) {
        super(message, cause);
    }
}
