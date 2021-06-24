<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Увійдіть з вашого акаунту</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<sec:authorize access="isAuthenticated()">
  <% response.sendRedirect("/"); %>
</sec:authorize>
<%--<div>--%>
<%--  <form method="POST" action="/login">--%>
<%--    <h2>Вхід в систему</h2>--%>
<%--    <div>--%>
<%--      <input name="username" type="text" placeholder="Логін" autofocus="true"/>--%>
<%--      <input name="password" type="password" placeholder="Пароль"/>--%>
<%--      <button type="submit">Увійти</button>--%>
<%--      <h4><a href="/registration">Зареєструватися</a></h4>--%>
<%--    </div>--%>
<%--  </form>--%>
<%--</div>--%>
<div class="container">
  <h2>Авторизація</h2>
  <form method="POST" action="/login">
    <div class="form-group">
      <label for="login">Логін:</label>
      <input type="text" class="form-control" id="login" placeholder="Введіть логін" name="username">
    </div>
    <div class="form-group">
      <label for="password">Пароль:</label>
      <input type="password" class="form-control" id="password" placeholder="Введіть пароль" name="password">
    </div>
    <div class="form-group form-check">
      <label class="form-check-label">
        <input class="form-check-input" type="checkbox" name="remember"> Запам'ятати мене
      </label>
    </div>
    <button type="submit" class="btn btn-primary">Увійти</button>
    <h4><a href="/registration">Зареєструватися</a></h4>
  </form>
</div>

</body>
</html>
