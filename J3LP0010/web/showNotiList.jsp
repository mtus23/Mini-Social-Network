<%-- 
    Document   : showNotiList
    Created on : Dec 7, 2020, 8:50:05 AM
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
        <c:if test ="${empty sessionScope.user}">
            <c:redirect url="login.jsp"></c:redirect>
        </c:if>
        <c:if test ="${sessionScope.user.role eq 'admin' || sessionScope.user.statusId == 1}">
            <c:redirect url="search.jsp"></c:redirect>
        </c:if>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand" href="MainController?btnAction=searchPage">My social network</a>
            <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item active">
                        <a class="nav-link" href="MainController?btnAction=searchPage">Search Page </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=showNoti">My Notification<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=createArticle">Create Article</a>
                    </li>
                </ul>
                <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
            </div>
        </nav>
        <div class="container justify-center">
            <div class="col-8 justify-content-center">
                <c:if test="${not empty requestScope.listNotiEmpty}">
                    <h5>
                        ${requestScope.listNotiEmpty}
                    </h5>
                </c:if>
                <c:if test="${not empty requestScope.listNoti}">
                    <c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
                    <c:set var="numberOfPage" value="${requestScope.numberOfPage}"></c:set>
                    <c:forEach var="notiDto" items="${requestScope.listNoti}"> 
                        <div class="m-2 p-1 border rounded">
                            <a href="MainController?btnAction=showNotiCorresponding&txtNotiId=${notiDto.notiId}&txtId=${notiDto.postId}">
                                <c:if test="${notiDto.status eq 'unread'}">
                                    <strong>
                                        <c:if test="${sessionScope.user.mail ne notiDto.mail}">
                                            ${requestScope.mapNames[notiDto.mail]} - (${notiDto.mail}) has ${notiDto.type} on your post<br>
                                            <p class="date">${notiDto.date}</p>
                                            <c:if test="${notiDto.type eq 'comments'}">
                                                "${requestScope.mapCmtContent[notiDto.notiId]}"
                                            </c:if>
                                        </c:if>
                                        <c:if test="${sessionScope.user.mail eq notiDto.mail}">
                                            You - (${notiDto.mail}) has ${notiDto.type} on your post<br>
                                            <p class="date">${notiDto.date}</p>
                                            <c:if test="${notiDto.type eq 'comments'}">
                                                "${requestScope.mapCmtContent[notiDto.notiId]}"
                                            </c:if>
                                        </c:if>
                                    </strong>
                                </c:if>
                                <c:if test="${notiDto.status eq 'read'}">
                                    <c:if test="${sessionScope.user.mail ne notiDto.mail}">
                                        ${requestScope.mapNames[notiDto.mail]} - (${notiDto.mail}) has ${notiDto.type} on your post<br>
                                        <p class="date">${notiDto.date}</p>
                                        <c:if test="${notiDto.type eq 'comments'}">
                                            "${requestScope.mapCmtContent[notiDto.notiId]}"
                                        </c:if>
                                    </c:if>
                                    <c:if test="${sessionScope.user.mail eq notiDto.mail}">
                                        You - (${notiDto.mail}) has ${notiDto.type} on your post<br>
                                        <p class="date">${notiDto.date}</p>
                                        <c:if test="${notiDto.type eq 'comments'}">
                                            "${requestScope.mapCmtContent[notiDto.notiId]}"
                                        </c:if>
                                    </c:if>
                                </c:if>
                            </a>
                        </div>
                    </c:forEach>
                    <c:if test="${currentPage != 1}">
                        <a href="MainController?btnAction=showNoti&txtCurrentPage=${currentPage - 1}">Previous</a>
                    </c:if>
                    Page ${currentPage}/${numberOfPage}
                    <c:if test="${currentPage < numberOfPage}">
                        <a href="MainController?btnAction=showNoti&txtCurrentPage=${currentPage + 1}">Next</a>
                    </c:if>
                </c:if>
            </div>
        </div>
    </body>
</html>
