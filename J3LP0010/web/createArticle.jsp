<%-- 
    Document   : createArticle
    Created on : Dec 7, 2020, 8:49:04 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Post Page</title>
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <style>
            textarea{
                resize: none;
                white-space: pre-wrap;
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
                        <a class="nav-link" href="MainController?btnAction=showNoti">My Notification</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="MainController?btnAction=createArticle">Create Article<span class="sr-only">(current)</span></a>
                    </li>
                </ul>
                <a class="nav-item my-2" href="MainController?btnAction=Logout"><button class="btn btn-primary">Logout</button></a>
            </div>
        </nav>
        <div class="container">

            <div class="col mt-5 justify-center">
                <form action="MainController" class ="need-validate" method="post" enctype="multipart/form-data" novalidate>
                    <div class="form-row">
                        <input type ="hidden" name="txtMail" value="${sessionScope.user.mail}">
                        <label for="title">Title</label>
                        <input type="text" name="txtTitle" value="" id="title" class="form-control" maxlength="50" required
                               <c:if test="${not empty param.txtTitle}">
                                   value="${param.txtTitle}"
                               </c:if>
                               <c:if test="${empty param.txtTitle}">
                                   value=""
                               </c:if>
                               >
                        <div class="invalid-feedback">Please provide a title</div>
                        <label for="description">Description</label>
                        <textarea class="form-control" id=description" row="3" name="txtDescription" required>${param.txtDescription}</textarea>
                        <div class="invalid-feedback">Please provide a description</div>
                        <label for="file">Image</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="file" name="txtImage" accept="image/png,image/jpeg" onchange="validateImage()" required>
                            <label class="custom-file-label" for="inputGroupFile01" id="fileLabel">Choose file</label>
                            <div class="invalid-feedback">Please provide a image</div>
                        </div>
                        <c:if test="${not empty requestScope.createArticleError}">
                            <p style="color: red">${requestScope.createArticleError}</p>
                        </c:if>
                        <input class="btn btn-primary mt-4 btn-block" type="submit" value="Create" name="btnAction" />
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function validateImage() {
            var fileInput =
                    document.getElementById("file");

            var filePath = fileInput.value;

            // Allowing file type 
            var allowedExtensions =
                    /(\.jpg|\.jpeg|\.png|\.gif)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
            } else {
                filePath.split(/(\\|\/)/g).pop();
                document.getElementById("fileLabel").innerHTML = filePath;
            }
            return true;
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
