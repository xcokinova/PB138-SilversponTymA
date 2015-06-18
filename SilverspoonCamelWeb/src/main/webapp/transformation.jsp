<%-- 
    Document   : transformation
    Created on : May 10, 2015, 2:58:26 PM
    Author     : viktor
--%>

<%@page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apache Camel Routes Transformator</title>
    </head>
    <body>
        <c:if test="${not empty chyba}">
            <div style="border: solid 1px red; background-color: yellow; padding: 10px">
                <c:out value="${chyba}"/>
            </div>
        </c:if>
        <form method="POST" action="${pageContext.request.contextPath}/transformation/upload" enctype="multipart/form-data" >
            XML súbor
            <input type="file" name="file" id="file" /> <br/>
            <input type="submit" value="Upload" />
        </form>  
        <c:if test="${not empty resultSVG}">
            <img src="../${resultSVG}" width="1000" height="600" alt="" />
        </c:if>
    </body>
</html>
