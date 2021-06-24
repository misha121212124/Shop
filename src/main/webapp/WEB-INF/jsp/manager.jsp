<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Користувачі</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<div class="container">
  <br>
  <h2>Список користувачів</h2>
  <input class="form-control" id="myInput" type="text" placeholder="Пошук...">
  <br>
  <table class="table table-bordered">
    <thead>
      <th>ID</th>
      <th>Логін</th>
      <th>Ім'я</th>
      <th>Ролі</th>
    </thead>

    <tbody id="myTable">
      <c:forEach items="${allUsers}" var="user">
        <tr>
          <td>${user.id}</td>
          <td>${user.username}</td>
          <td>${user.sname} ${user.fname}</td>
          <td>
            <c:forEach items="${user.roles}" var="role">${role.name} </c:forEach>
          </td>
          <td>
            <form action="${pageContext.request.contextPath}/manager" method="post">
              <input type="hidden" name="userId" value="${user.id}"/>
              <input type="hidden" name="action" value="show"/>
              <button type="submit">Деталі</button>
            </form>
          </td>

          <td>
            <form action="${pageContext.request.contextPath}/manager" method="post">
              <input type="hidden" name="userId" value="${user.id}"/>
              <input type="hidden" name="action" value="delete"/>
              <button type="submit">Видалити</button>
            </form>
          </td>

        </tr>
      </c:forEach>

    </tbody>
  </table>
</div>

<script>
  $(document).ready(function(){
    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });
  });
</script>
<%--  <table>--%>
<%--    <thead>--%>
<%--    <th>ID</th>--%>
<%--    <th>UserName</th>--%>
<%--    <th>Password</th>--%>
<%--    <th>Roles</th>--%>
<%--    </thead>--%>
<%--    --%>
<%--    --%>
<%--    <c:forEach items="${allUsers}" var="user">--%>
<%--      <tr>--%>
<%--        <td>${user.id}</td>--%>
<%--        <td>${user.username}</td>--%>
<%--        <td>${user.password}</td>--%>
<%--        <td>--%>
<%--          <c:forEach items="${user.roles}" var="role">${role.name}; </c:forEach>--%>
<%--        </td>--%>
<%--        <td>--%>
<%--          <form action="${pageContext.request.contextPath}/manager" method="post">--%>
<%--            <input type="hidden" name="userId" value="${user.id}"/>--%>
<%--            <input type="hidden" name="action" value="show"/>--%>
<%--            <button type="submit">Деталі</button>--%>
<%--          </form>--%>
<%--        </td>--%>

<%--        <td>--%>
<%--          <form action="${pageContext.request.contextPath}/manager" method="post">--%>
<%--            <input type="hidden" name="userId" value="${user.id}"/>--%>
<%--            <input type="hidden" name="action" value="delete"/>--%>
<%--            <button type="submit">Видалити</button>--%>
<%--          </form>--%>

<%--        </td>--%>

<%--      </tr>--%>
<%--    </c:forEach>--%>
<%--  </table>--%>
<%--  <a href="/">Главная</a>--%>
</div>
</body>
</html>