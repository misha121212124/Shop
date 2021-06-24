<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE HTML>
<html>
<head>
  <title>Головна</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
  <style>
    .carousel-inner img {
      width: 100%;
      height: 100%;
    }
  </style>
</head>
<body style="background-color: #eee">


<div id="demo" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="../../resources/images/logo2.png" alt="Los Angeles" width="1100" height="500">
    </div>
    </div>
  </div>
</div>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="/cargo_search">Каталог</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <div class="container">
                <ul class="navbar-nav">
                    <sec:authorize access="!isAuthenticated()">
                        <li class="nav-item">
                            <a class="nav-link" href="/login">Увійти</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/registration">Зареєстуватися</a>
                        </li>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated()">
                        <sec:authorize access="!hasRole('ROLE_MANAGER')">
                            <li class="nav-item">
                                <a class="nav-link" href="/basket">Замовлення</a>
                            </li>
                        </sec:authorize>

                        <sec:authorize access="hasRole('ROLE_MANAGER')">
                            <li class="nav-item">
                                <a class="nav-link" href="/manager_basket">Замовлення</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/manager">Користувачі</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/feedBacks">Відгуки</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/orders/export/pdf">Export to PDF</a>
                            </li>
                        </sec:authorize>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout">Вийти</a>
                        </li>
                    </sec:authorize>

                </ul>

            </div>
        </div>
    </div>

</nav>

<%--<div class="jumbotron jumbotron-fluid">--%>
<%--  <div class="container">--%>
<%--    <h1>Одежинка</h1>--%>
<%--    <p>Якісно, як завжди</p>--%>
<%--  </div>--%>
<%--</div>--%>
<%--<div class="container">--%>
<%--  <h3>${user.fname}</h3>--%>
<%--  <h4><a href="/cargo_search">Каталог</a></h4>--%>
<%--  <sec:authorize access="!isAuthenticated()">--%>
<%--    <h4><a href="/login">Увійти</a></h4>--%>
<%--    <h4><a href="/registration">Зараєстуватися</a></h4>--%>
<%--  </sec:authorize>--%>
<%--  <sec:authorize access="isAuthenticated()">--%>
<%--    <h4><a href="/basket">Замовлення</a></h4>--%>
<%--    <sec:authorize access="hasRole('ROLE_MANAGER')">--%>
<%--      <h4><a href="/manager">Користувачі</a></h4>--%>
<%--      <h4><a href="/feedBacks">Відгуки</a></h4>--%>
<%--      <h4><a href="/orders/export/pdf">Export to PDF</a></h4>--%>
<%--    </sec:authorize>--%>
<%--    <h4><a href="/logout">Вийти</a></h4>--%>
<%--  </sec:authorize>--%>
<%--</div>--%>
</body>
</html>