<%-- 
    Document   : activeAccount.jsp
    Created on : Dec 8, 2020, 9:18:12 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Active Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </head>
    <body>
        <c:if test ="${empty sessionScope.User}">
            <c:redirect url="login.jsp"></c:redirect>
        </c:if>
        <c:if test="${sessionScope.User.statusId == 2}">
            <c:redirect url="search.jsp"></c:redirect>
        </c:if>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand" href="search.jsp">My social network</a>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link" href="search.jsp">Search Page </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=showNoti">My Notification</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=createArticle">Create Article</a>
                    </li>
                </ul>
                <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
            </div>
        </nav>
        <div class="container">
            <c:if test="${sessionScope.User.statusId == 1}">
                <div class="alert alert-danger" role="alert">
                    You have not received activation email yet! Click <a href="MainController?btnAction=resendActivation" class="alert-link">here</a> to resend activation email.
                </div>
            </c:if>
            <c:if test="${not empty requestScope.sendCodeSuccess}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.sendCodeSuccess}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.activeFail}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.activeFail}
                </div>
            </c:if>
            <div class="d-flex justify-content-center">
                <form action="MainController" method="POST">
                    <h4>Activate account</h4>
                    <div class="form-group row">
                        <label>Active key: </label>
                        <input name="txtActivationCode" type="text" min="1" max="4" class="form-control"
                               <c:if test="${not empty param.txtActivationCode}">
                                   value="${param.txtActivationCode}"
                               </c:if>
                               required />
                    </div>
                    <input type="submit" class="btn btn-primary" name="btnAction" value="activation">
                </form>

            </div>
        </div>
    </body>
</html>
