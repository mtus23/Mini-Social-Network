<%-- 
    Document   : search.jsp
    Created on : Dec 7, 2020, 8:49:45 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:url value="images/" var="images"></c:url>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Search Page</title>
            <!-- CSS only -->
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

            <!-- JS, Popper.js, and jQuery -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
            <style>

                .description {
                    display: block;
                    text-overflow: ellipsis;
                    word-wrap: break-word;
                    overflow: hidden;
                    max-height: 20em;
                    line-height: 1.8em;
                }
                img{
                    width: 100%;
                    height: 100%;
                }
                h6, p{
                    color: black;
                }

                .btn-detail{
                    width: 150px;
                }
                .noti{
                    margin-right: auto !important;
                    margin-left: 10px;
                }

            </style>
        </head>
        <body>
        <c:if test ="${empty sessionScope.user}">
            <c:redirect url="login.jsp"></c:redirect>
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
                <c:if test="${sessionScope.user.role eq 'member' && sessionScope.user.statusId == 2}">
                        <li class="nav-item">
                            <a class="nav-link" href="MainController?btnAction=showNoti">My Notification</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="MainController?btnAction=createArticle">Create Article<span class="sr-only">(current)</span></a>
                        </li>
                    </c:if>
                </ul>
                <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
            </div>
        </nav>
        <div class="container">
            <c:if test="${sessionScope.user.statusId == 1}">
                <div class="alert alert-danger" role="alert">
                    You have not active this account yet! Click <a href="MainController?btnAction=activeAccountPage" class="alert-link">here</a> to active your account.
                </div>
            </c:if>
            <c:if test="${ not empty sessionScope.user}">
                <div class="alert alert-primary" role="alert">
                    Welcome ${sessionScope.user.name}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.deleteFail}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.deleteFail}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.deteleCommentFail}">
                <div class="alert alert-danger" role="alert">
                    ${requestScope.deteleCommentFail}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.activesuccess}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.activesuccess}
                </div>
            </c:if>
            <c:if test="${not empty requestScope.deleteSuccess}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.deleteSuccess}
                </div>
            </c:if>
            <c:if test = "${sessionScope.user.statusId != 1}">
                <c:set value="${sessionScope.user}" var="user"></c:set>
                    <div class="row justify-content-center mt-5">
                        <div class="col-5 form-group">
                            <form action="MainController">
                                <div class="form-row">
                                    <div class="col-9">
                                        <input class="form-control" type="text" name="txtSearch" placeholder="Input keyword to search" value="${requestScope.searchValue}">
                                </div>
                                <div class="col-3">
                                    <input class="btn btn-primary"type="submit" name="btnAction" value="Search"> 
                                </div>
                            </div>
                        </form>
                        <a href="MainController?btnAction=createArticle"><button class="btn btn-primary btn-block mt-3">Post an Article</button></a>
                    </div>
                    <c:if test="${not empty requestScope.searchResult}">
                        <c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
                        <c:set var="numberOfPage" value="${requestScope.numberOfPage}"></c:set>
                        <c:set var="searchResult" value="${requestScope.searchResult}"></c:set>
                            <div class="col-9 m-5 p-1 justify-center">
                            <c:forEach var="dto" items="${requestScope.searchResult}">
                                <div class="col-8 m-4 p-2 justify-center border border-dark rounded">
                                    <div class="justify-center">
                                        <h6>${dto.title}</h6>
                                        <p class="description">${dto.description}</p>
                                        <img src="${images}${dto.image}" >
                                    </div>
                                    <div class="row justify-content-center">
                                        <a href="MainController?btnAction=ArticleDetail&txtId=${dto.postId}">
                                            <button class="btn btn-primary m-2 btn-detail">Detail</button>
                                        </a>
                                        <c:if test="${user.mail==dto.mail  || user.role eq 'admin'}">
                                            <a href="MainController?btnAction=DeleteArticle&txtId=${dto.postId}&txtSearch=${requestScope.searchValue}">
                                                <button class="btn btn-primary m-2 btn-detail " onclick="return confirm('Are you sure you want to delete this post?');">Delete</button>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${currentPage != 1}">
                                <a href="MainController?txtSearch=${requestScope.searchValue}&btnAction=Search&txtCurrentPage=${currentPage - 1}">Previous</a>
                            </c:if>
                            Page ${currentPage}/${numberOfPage}
                            <c:if test="${currentPage < numberOfPage}">
                                <a href="MainController?txtSearch=${requestScope.searchValue}&btnAction=Search&txtCurrentPage=${currentPage + 1}">Next</a>
                            </c:if>
                        </div>
                    </c:if>

                </div> 
                <c:if test="${not empty requestScope.errorSearch}">
                    <div class="alert alert-danger justify-center">
                        ${requestScope.errorSearch}
                    </div>
                </c:if>
            </c:if>
        </div>
    </body>
</html>
