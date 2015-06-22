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
            <label for="type">Typ dosky</table>
            <select name="type" id="type">
                <c:choose>
                    <c:when test="${param.type == 1}">
                        <option value="1" selected>Raspberry Pi 2</option>
                    </c:when>
                    <c:otherwise>
                        <option value="1">Raspberry Pi 2</option>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.type == 2}">
                        <option value="2" selected>BeagleBoneBlack</option>
                    </c:when>
                    <c:otherwise>
                        <option value="2">BeagleBoneBlack</option>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.type == 3}">
                        <option value="3" selected>CubieBoard 2</option>
                    </c:when>
                    <c:otherwise>
                        <option value="3">CubieBoard 2</option>
                    </c:otherwise>
                </c:choose>
            </select><br />
            
            <label for="file">XML súbor</table>           
            <input type="file" name="file" id="file" /><br/>
            <input type="submit" value="Upload" /><br/>
        </form>  
        <c:if test="${not empty resultSVG}">
            <img src="../${resultSVG}" width="950" height="540" alt="result image" />
        </c:if>
    </body>
</html>
