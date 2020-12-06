<%-- 
    Document   : search
    Created on : Sep 18, 2020, 2:11:47 AM
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
            <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
                <a class="nav-item" href="search.jsp">Search Page</a>
                <a class="nav-item noti" href="MainController?btnAction=showNoti">My Notification</a>
                <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
            </nav>
            <div class="container">
            <c:if test="${ not empty sessionScope.User}">
                <div class="col-5 m-3">
                    <h3> Welcome ${sessionScope.User.name}</h3>
                </div>
            </c:if>
            <c:if test ="${empty sessionScope.User}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:if>
            <c:set value="${sessionScope.User}" var="user"></c:set>
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
                    <a href="createArticle.jsp?txtMail=${user.mail}"><button class="btn btn-primary btn-block mt-3">Post an Article</button></a>
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
                                    <c:if test="${user.mail==dto.mail}">
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
        </div>
    </body>
</html>
