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
                .container{
                }
                .description {
                    display: block;/* or inline-block */
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
                a:hover{
                    text-decoration: none;
                }
                
            </style>
        </head>
        <body>
            <div class="container">
            <c:if test="${ not empty sessionScope.User}">
                <h3> Hello ${sessionScope.User.name}</h3>
                <a href="MainController?btnAction=Logout">Logout</a>
            </c:if>
            <c:if test ="${empty sessionScope.User}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:if>
            <div>
                <form action="MainController">
                    <input type="text" name="txtSearch" placeholder="Input keyword to search" value="${sessionScope.searchValue}">
                    <input type="submit" name="btnAction" value="Search"> 
                </form>
                <a href="createArticle.jsp?txtMail=${sessionScope.User.mail}">Post an Article</a>
            </div>
            <c:if test="${not empty sessionScope.searchResult}">
                <div class="col-8 m-3 p-1 justify-center">
                    <c:forEach var="dto" items="${sessionScope.searchResult}">
                          <div class="col-8 m-4 p-2 justify-center border border-dark rounded">
                        <a href="MainController?btnAction=ArticleDetail&txtId=${dto.postId}">
                            <div class="justify-center">
                            <h6>${dto.title}</h6>
                            <p class="description">${dto.description}</p>
                            <img src="${images}${dto.image}" >
                        </div>
                        </a>
                          </div>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.errorSearch}">
                <div class="col mt-5 justify-center">
                    <p>${sessionScope.errorSearch}</p> 
                </div>
            </c:if>
        </div> 
    </body>
</html>
