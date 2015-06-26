<%-- 
    Document   : transformation
    Created on : May 10, 2015, 2:58:26 PM
    Author     : PB138-SilverspoonTymA
--%>

<%@page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="uri" value="${req.requestURI}" />
<!DOCTYPE html>
<html>
    <head>
        <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vizualizácia pre Silverspon.io pomocou XSLT</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link rel="icon" href="img/favicon.ico">
    </head>
    <body>
        <div id="header">
            <a href=""><h1 class="brand-heading">Silverspoon.io</h1></a>
            <p class="intro-text">Vizualizácia pomocou XSLT</p>
        </div>
        <div id="container">
            <h2>Vizualizácia</h2>
            <c:if test="${not empty chyba}">
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <c:out value="${chyba}"/>
                </div>
            </c:if>
            <form class="form-inline" method="POST" action="${pageContext.request.contextPath}/transformation/upload" enctype="multipart/form-data" >
                <div class="form-group">
                    <label for="type">Typ dosky</label>
                    <select class="form-control" name="type" id="type">
                        <c:choose>
                            <c:when test="${param.type == 1}">
                                <option value="1" selected>Raspberry Pi B+</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">Raspberry Pi B+</option>
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
                    </select>
                </div>
                <div class="form-group">
                    <label for="file" class="marginLabel">XML súbor</label>           
                    <input class="form-control-static" type="file" name="file" id="file" />
                </div>
                <button type="submit" class="btn btn-default">Vizualizovať</button>
            </form>  
            <c:if test="${not empty resultSVG}">
                <img src="${resultSVG}" width="950" height="540" alt="result image" />
            </c:if>
        </div>
        <div id="footer">
            &copy; 2015 PB138-SilverspoonTymA
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
