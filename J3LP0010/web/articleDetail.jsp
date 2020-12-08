<%-- 
    Document   : articleDetail
    Created on : Dec 7, 2020, 8:49:24 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:url value="images/" var="images"></c:url>

    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <!-- CSS only -->
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


            <!-- JS, Popper.js, and jQuery -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
            <title>Article Detail Page</title>
            <style>
                body{
                    background-color: whitesmoke;
                }
                .custom-container {
                    margin-left: 50px;
                    margin-right: 50px;
                }
                .image{
                    height:600px;
                }
                img{
                    height:100%;
                    width:100%;
                }
                .date{
                    font-size: 75%;
                    color: grey;
                }
                button{
                    margin-right: 20px;
                    width: 120px;
                    height: 40px;
                }
                .EmotionCount{
                    font-size: 85%;
                }
                textarea{
                    resize: none;
                    white-space: pre-wrap;
                    width: 440px;
                }
                .sideCol{
                    height: 680px;
                    background-color: white;
                    overflow: auto;

                }
                .list{
                    width: 450px;
                    height: 450px;

                }
                .cmt{
                    background-color: whitesmoke;

                }
                .noti{
                    margin-right: auto !important;
                    margin-left: 10px;
                }
                .notiComt{
                    background-color: #66ccff;
                }
            </style>
        </head>
        <body>
        <c:if test ="${empty sessionScope.User}">
            <c:redirect url="login.jsp"></c:redirect>
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
           <c:if test="${not empty requestScope.deteleCmtSuccess}">
                <div class="alert alert-success" role="alert">
                    ${requestScope.deteleCmtSuccess}
                </div>
            </c:if> 
        <c:set var="dto" value="${sessionScope.ArticleDetail}"></c:set>
            <div class="custom-container container-fluid">

                <div class="row">
                    <div class="col-6 p-3 m-2">
                        <div class="image">
                            <img src="${images}${dto.image}">
                    </div>
                </div>
                <div class="col-4 p-3 m-2 sideCol">
                    <div>
                        <h5>${sessionScope.ArticleOwner.name}</h5>
                        <p class="date">${dto.date}</p>
                        <br>
                        <p class="content">${dto.description}</p>
                        <br>
                        <p class="EmotionsCount"> ${sessionScope.EmotionCount['Likes']} Likes - ${sessionScope.EmotionCount['Dislikes']} Dislikes</p>
                    </div>
                    <div>
                        <div class="row">
                            <c:set var="userEmo" value="${sessionScope.UserEmotion}"></c:set>
                            <a href="MainController?btnAction=MakeEmotion&txtId=${dto.postId}&txtMail=${sessionScope.User.mail}&txtEmo=Like">
                                <button type="button" class="btn ${userEmo.likes ? 'btn-primary' : 'btn-light'} ml-2">
                                    <span><i class="fa fa-thumbs-up"></i>
                                    </span> Like</button></a>
                            <a href="MainController?btnAction=MakeEmotion&txtId=${dto.postId}&txtMail=${sessionScope.User.mail}&txtEmo=Dislike">
                                <button type="button" class="btn ${userEmo.dislikes ? 'btn-primary' : 'btn-light'}">
                                    <span><i class="fa fa-thumbs-down"></i>
                                    </span> Dislike</button></a>
                            <button onclick="getFocus()" type="button" class="btn btn-light"><span><i class="fa fa-comment-o"></i>
                                </span> Comment</button>
                        </div>
                    </div>
                    <div class="list-cmt">
                        <c:forEach var="cmtDto" items="${sessionScope.ListComment}">
                            <c:set var="mail" value="${cmtDto.mail}"></c:set>
                                <c:if test="${requestScope.NotiCmtCorrespondingId eq cmtDto.cmtId}">
                                    <div class="cmt m-2 p-2 border rounded notiComt">    
                                    <h6>${sessionScope.CommentOwner[mail]}</h6>
                                        <p class="date">${cmtDto.date}</p>
                                        <p>${cmtDto.cmtContent}</p>
                                    <c:if test="${cmtDto.mail==sessionScope.User.mail || sessionScope.User.role eq 'admin'}">
                                        <a href="MainController?btnAction=DeleteComment&txtCmtId=${cmtDto.cmtId}&txtId=${dto.postId}">
                                            <button class="btn btn-primary m-2" onclick="return confirm('Are you sure you want to delete this post?');">Delete</button>
                                        </a>
                                    </c:if>
                                    </div>
                                </c:if>
                                <c:if test="${requestScope.NotiCmtCorrespondingId ne cmtDto.cmtId}">
                                    <div class="cmt m-2 p-2 border rounded">
                                    <h6>${sessionScope.CommentOwner[mail]}</h6>
                                    <p class="date">${cmtDto.date}</p>
                                    <p>${cmtDto.cmtContent}</p>
                                    <c:if test="${cmtDto.mail==sessionScope.User.mail || sessionScope.User.role eq 'admin'}">
                                        <a href="MainController?btnAction=DeleteComment&txtCmtId=${cmtDto.cmtId}&txtId=${dto.postId}">
                                            <button class="btn btn-primary m-2" onclick="return confirm('Are you sure you want to delete this comment?');">Delete</button>
                                        </a>
                                    </c:if>
                                    </div>
                                </c:if>
                        </c:forEach>

                    </div>
                    <div class="mt-2">
                        <form action="MainController" class="m-2">
                            <textarea type="text" name="txtComment" id="comment" rows="3" required></textarea>
                            <br>
                            <input type="hidden" name="txtMail" value="${sessionScope.User.mail}">
                            <input type="hidden" name ="txtId" value="${sessionScope.ArticleDetail.postId}">
                            <input class="btn btn-primary" type="submit" name="btnAction" value="Submit Comment">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        function getFocus() {
            document.getElementById("comment").focus();
        }
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('need-validate');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false || validateImage() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</html>
