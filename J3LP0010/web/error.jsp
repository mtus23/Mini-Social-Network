<%-- 
    Document   : error.jsp
    Created on : Dec 7, 2020, 8:48:45 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Error page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Something went wrong</h1>
        <c:if test="${empty sessionScope.User}">
        <a href="login.jsp">Return login page</a>
        </c:if>
        <c:if test="${not empty sessionScope.User}">
        <a href="search.jsp">Return search page</a>
        </c:if>
    </body>
</html>
