package cz.muni.fi.pb138.silverspooncamelroutes;

/**
 *
 * @author viktor
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
