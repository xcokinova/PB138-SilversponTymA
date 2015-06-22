package cz.muni.fi.pb138.silverspooncamelroutes;


import java.io.*;


/**
 *
 * @author jana
 */
public class Main {
    
    public static void main(String[] args) {
        XMLValidator v = new XMLValidator();
        v.setValidator(new File("src/main/java/cz/muni/fi/pb138/silverspooncamelroutes/files/CamelSchema.xsd"));
        System.out.println(v.validate(new File("src/main/java/cz/muni/fi/pb138/silverspooncamelroutes/files/Input.xml")));
    }
    
}