<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Реєстрація</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />


<div class="container">
  <h2>Реєстрація</h2>
  <form:form method="POST" modelAttribute="userForm">
    <div class="form-group">
      <div>${error}</div>
      <form:input data-toggle="login" title="Щонайменше 5 символів!" class="form-control"
                  type="text" path="name" placeholder="Логін" autofocus="true"/>
      <form:errors path="name"/>
        ${usernameError}
    </div>
    <div class="form-group">
      <form:input data-toggle="fname" title="Щонайменше 3 символи!" class="form-control"
                  type="text" path="fname" placeholder="Ім'я"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="sname" title="Щонайменше 5 символів!"
                  type="text" path="sname" placeholder="Прізвище"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="age" title="Від 15 до 150!"
                  type="text" path="age" placeholder="Вік"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="phone" title="068 836 45 01"
                  type="text" path="phone" placeholder="Номер (068 836 45 01)"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="email" title="В форматі e-mail"
                  type="text" path="email" placeholder="E-mail"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="adress" title="Аккаунт може бути видалено, якщо не має змісту"
                  type="text" path="adress" placeholder="Ваша адреса"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="password" title="Щонайменше 5 символів!"
                  type="password" path="password" placeholder="Пароль"/>
    </div>
    <div class="form-group">
      <form:input class="form-control" data-toggle="passwordConfirm" title="Ще раз введіть пароль"
                  type="password" path="passwordConfirm"
                  placeholder="Підтвердіть ваш пароль"/>
      <form:errors path="password"/>
    </div>
    <button type="submit" class="btn btn-primary">Зареєструватися</button>

<%--    <div>--%>
<%--      <div>${error}</div>--%>
<%--      <form:input type="text" path="name" placeholder="Логін" autofocus="true"/>--%>
<%--      <form:errors path="name"/>--%>
<%--        ${usernameError}--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="text" path="fname" placeholder="Ім'я"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--    <form:input type="text" path="sname" placeholder="Прізвище"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="text" path="age" placeholder="Вік"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="text" path="phone" placeholder="Номер (068 836 45 01)"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="text" path="email" placeholder="E-mail"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="text" path="adress" placeholder="Ваша адреса"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="password" path="password" placeholder="Пароль"/>--%>
<%--    </div>--%>
<%--    <div>--%>
<%--      <form:input type="password" path="passwordConfirm"--%>
<%--                  placeholder="Підтвердіть ваш пароль"/>--%>
<%--      <form:errors path="password"/>--%>
<%--        ${passwordError}--%>
<%--    </div>--%>
<%--    <button type="submit">Зареєструватися</button>--%>
  </form:form>
<%--  <a href="/">Головна</a>--%>
</div>
<script>
  $(document).ready(function(){
    $('[data-toggle="login"]').tooltip();
    $('[data-toggle="fname"]').tooltip();
    $('[data-toggle="sname"]').tooltip();
    $('[data-toggle="age"]').tooltip();
    $('[data-toggle="phone"]').tooltip();
    $('[data-toggle="email"]').tooltip();
    $('[data-toggle="adress"]').tooltip();
    $('[data-toggle="password"]').tooltip();
    $('[data-toggle="passwordConfirm"]').tooltip();
  });
</script>
</body>
</html>