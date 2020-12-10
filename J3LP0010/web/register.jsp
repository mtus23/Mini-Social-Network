<%-- 
    Document   : register.jsp
    Created on : Dec 7, 2020, 8:48:10 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </head>
    <body class="text-center">
        <div class="container">
            <div class="row justify-content-center mt-5">
                <aside class="col-sm-4">
                    <div class="card align-center">
                        <article class="card-body">
                            <h4 class="card-title text-center mb-4 mt-1">Register</h4>
                            <hr>
                            <form action="MainController" method="POST">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="Mail" type="text" name="txtMail" 
                                               <c:if test="${not empty param.txtMail}">
                                                   value="${param.txtMail}"
                                               </c:if>
                                               <c:if test="${empty param.txtMail}">
                                                   value=""
                                               </c:if>
                                               >                                               
                                    </div> 
                                </div> 
                                <c:if test="${not empty requestScope.registerError}">
                                    <p style="color: red">${requestScope.registerError.errorMail}</p>
                                </c:if>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="Name" type="text" name="txtName" 
                                               <c:if test="${not empty param.txtName}">
                                                   value="${param.txtName}"
                                               </c:if>
                                               <c:if test="${empty param.txtName}">
                                                   value=""
                                               </c:if>
                                               >

                                    </div> 
                                </div> 
                                <c:if test="${not empty requestScope.registerError}">
                                    <p style="color: red">${requestScope.registerError.errorName}</p>
                                </c:if>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="Password" type="password" name="txtPassword" value="">

                                    </div> 
                                </div> 
                                <c:if test="${not empty requestScope.registerError}">
                                    <hr>
                                    <p style="color: red"> ${requestScope.registerError.errorPassword}</p>
                                </c:if>
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="Confirm password" type="password" name="txtConfirmPass" value="">

                                    </div>
                                </div>
                                <c:if test="${not empty requestScope.registerError}">
                                    <p style="color: red">${requestScope.registerError.errorConfirmPassword}</p>
                                </c:if>
                                <div class="form-group">
                                    <hr>
                                    <input type="submit" class="btn btn-primary btn-block" name="btnAction" value="Register">
                                </div> 
                                    <hr>
                                <a href="MainController?btnAction=loginPage">Return login page</a>
                            </form>
                        </article>
                    </div>
                </aside>
            </div>
        </div> 
</html>
