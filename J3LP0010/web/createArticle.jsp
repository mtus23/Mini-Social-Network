<%-- 
    Document   : createArticle
    Created on : Sep 22, 2020, 4:29:06 PM
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
        </style>
    </head>
    <body>

        <div class="container">
            <c:if test="${empty sessionScope.User}">
                <c:redirect url="login.jsp"></c:redirect>
            </c:if>
            <div class="col mt-5 justify-center">
                <form action="MainController" class ="need-validate" method="post" enctype="multipart/form-data" novalidate>
                    <div class="form-row">
                        <input type ="hidden" name="txtMail" value="${sessionScope.User.mail}">
                        <label for="title">Title</label>
                        <input type="text" name="txtTitle" value="" id="title" class="form-control" maxlength="50" required="">
                        <div class="invalid-feedback">Please provide a title</div>
                        <label for="description">Description</label>
                        <textarea class="form-control" id=description" row="3" name="txtDescription" required></textarea>
                        <div class="invalid-feedback">Please provide a description</div>
                        <label for="file">Image</label>
                        <input type="file" class="form-control" id="file" name="txtImage" accept="image/png,image/jpeg" onchange="validateImage()" required>
                        <div class="invalid-feedback">Please provide a image</div>
                        <input type="submit" value="Create" name="btnAction" />
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
                return false; 
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
                        if (form.checkValidity() === false || validateImage()===false) {
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
