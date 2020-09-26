<%-- 
    Document   : register
    Created on : Sep 18, 2020, 2:21:04 AM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
        <form action="MainController" method="POST">
            Mail: <input type="text" name="txtMail" value="" /><br>
            <c:if test="${not empty sessionScope.registerError}">
                ${sessionScope.registerError.errorMail}<br/>
            </c:if>
            Name: <input type="text" name="txtName" value="" /><br>
            <c:if test="${not empty sessionScope.registerError}">
                ${sessionScope.registerError.errorName}<br/>
            </c:if>
            Password: <input type="password" name="txtPassword" value="" /><br>
            <c:if test="${not empty sessionScope.registerError}">
                ${sessionScope.registerError.errorPassword}<br/>
            </c:if>
            Confirm Password: <input type="password" name="txtConfirmPass" value="" /><br>
            <c:if test="${not empty sessionScope.registerError}">
                ${sessionScope.registerError.errorConfirmPassword}<br/>
            </c:if>
            <input type="submit" value="Register" name="btnAction" />
        </form>
    </body>
</html>
