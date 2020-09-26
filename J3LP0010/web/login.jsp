<%-- 
    Document   : login
    Created on : Sep 18, 2020, 2:19:12 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Login Page</h1>
        <form action="MainController" method="POST">
            Mail: <input type="text" name="txtMail" value="" /><br>
            Password: <input type="password" name="txtPassword" value="" /><br>
            <c:if test="${not empty sessionScope.loginError}">
                ${sessionScope.loginError}<br/>
            </c:if>
            <input type="submit" value="Login" name="btnAction" />
        </form>
        <a href="register.jsp">Register</a>
</html>
