<%-- 
    Document   : showNotiList
    Created on : Sep 30, 2020, 8:57:05 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <style>
            .date{
                font-size: 85%;
            }
            a:hover{
                text-decoration: none;
                background-color: whitesmoke;
            }
            .noti{
                margin-right: auto !important;
                margin-left: 10px;
            }
            h5{
                margin-top: 250px;
                margin-left: 250px;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <a class="nav-item" href="search.jsp">Search Page</a>
            <a class="nav-item noti" href="MainController?btnAction=showNoti">My Notification</a>
            <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
        </nav>
        <c:if test ="${empty sessionScope.User}">
            <c:redirect url="login.jsp"></c:redirect>
        </c:if>
        <div class="container justify-center">
            <div class="col-8 justify-content-center">
                <c:if test="${not empty requestScope.listNotiEmpty}">
                    <h5>
                        ${requestScope.listNotiEmpty}
                    </h5>
                </c:if>
                <c:if test="${not empty requestScope.listNoti}">
                    <c:forEach var="notiDto" items="${requestScope.listNoti}"> 
                        <div class="m-2 p-1 border rounded">
                            <a href="MainController?btnAction=showNotiCorresponding&txtNotiId=${notiDto.notiId}&txtId=${notiDto.postId}">
                                <c:if test="${notiDto.status eq 5}">
                                    <strong>
                                        ${requestScope.mapNames[notiDto.mail]} - (${notiDto.mail}) has ${notiDto.type} on your post<br>
                                        <p class="date">${notiDto.date}</p>
                                        <c:if test="${notiDto.type eq 'comments'}">
                                            "${requestScope.mapCmtContent[notiDto.notiId]}"
                                        </c:if>
                                    </strong>
                                </c:if>
                                <c:if test="${notiDto.status ne 5}">
                                    ${requestScope.mapNames[notiDto.mail]} - (${notiDto.mail})has ${notiDto.type} on your post<br>
                                    <p class="date">${notiDto.date}</p>
                                </c:if>
                            </a>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </body>
</html>
