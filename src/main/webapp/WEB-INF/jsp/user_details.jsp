<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Користувач: ${user.fname}</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<div class="jumbotron jumbotron-fluid">
    <div class="container">
        <h1>Користувач ${user.sname} ${user.fname}</h1>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col" style="background-color:lavender;">ID:  ${user.id}</div>
        <div class="col" style="background-color:#d5f4e6;">Логін: ${user.name}</div>
<%--        <div class="col" style="background-color:lavender;">E-mail: ${user.email}</div>--%>
<%--        <div class="col" style="background-color:#d5f4e6;">Номер Телефону: ${user.phone}</div>--%>
        <div class="col" style="background-color:lavender;">Вік: ${user.age}</div>
    </div>
    <div class="row">
<%--        <div class="col" style="background-color:lavender;">Ім'я:  ${user.fname}</div>--%>
<%--        <div class="col" style="background-color:#d5f4e6;">Прізвище: ${user.sname}</div>--%>
        <div class="col" style="background-color:#d5f4e6;">E-mail: ${user.email}</div>
        <div class="col" style="background-color:lavender;">Номер Телефону: ${user.phone}</div>
        <div class="col" style="background-color:#d5f4e6;"></div>

    </div>
<%--    <div class="row">--%>
<%--        <div class="col" style="background-color:lavender;"></div>--%>
<%--        <div class="col" style="background-color:#d5f4e6;"></div>--%>
<%--        <div class="col" style="background-color:rgba(231, 96, 96, 0.5);">Номер Телефону: ${user.phone}</div>--%>
<%--    </div>--%>
    <br>
    <div class="container">
        <p>Адреса: ${user.adress}</p>
        <p>Пароль: ${user.password}</p>
        <p>Ролі:
            <c:forEach items="${user.roles}" var="role">
                ${role.name}
            </c:forEach></p>
    </div>
<%--    <div class="row" style="background-color:rgba(251, 46, 46, 0.5);">--%>
<%--        <div class="col">--%>
<%--            Адреса: ${user.adress}--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="row" style="background-color:#d5f4e6;">--%>
<%--        <div class="col">--%>
<%--            Ролі:--%>
<%--            <c:forEach items="${user.roles}" var="role">--%>
<%--                ${role.name}--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <div class="row" style="background-color:lavender;">--%>
<%--        <div class="col">--%>
<%--            Пароль: ${user.password}--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <h3>--%>
<%--        Ролі<br>--%>
<%--        <c:forEach items="${user.roles}" var="role">${role.name} <br> </c:forEach>--%>
<%--    </h3>--%>

<%--    <h3>ID:  ${user.id}</h3>--%>
<%--    <h3>Логін: ${user.name}</h3>--%>
<%--    <h3>Ім'я:  ${user.fname}</h3>--%>
<%--    <h3>Прізвище: ${user.sname}</h3>--%>
<%--    <h3>Вік: ${user.age}</h3>--%>
<%--    <h3>Номер Телефону: ${user.phone}</h3>--%>
<%--    <h3>E-mail: ${user.email}</h3>--%>
<%--    <h3>Адреса: ${user.adress}</h3>--%>
<%--    <h3>Пароль: ${user.password}</h3>--%>


    <c:if test="${not empty allOrders}">
        <h3>Кількість замовлень: ${allOrders.size()}</h3>
        <br>
        <table class="table table-bordered text-center">

                <c:forEach items="${allOrders}" var="one_order">
                    <tr>
                    <td>
                        <table id="lastOrders" class="table table-striped table-bordered text-center">
                            <thead>
                            <th>Назва</th>
                            <th style="width:260px;">Зображення</th>
                            <th>Кількість</th>
                            <th>Вартість</th>
<%--                            <th>Статус</th>--%>
                            </thead>

                            <c:forEach items="${one_order.cargos}" var="orderCell">
                                <tr>
                                    <td>${orderCell.cargo.name}</td>
                                    <td>
                                        <img src="/myImage/imageDisplay?id=${orderCell.cargo.id}" class="card img-fluid" style="height:150px" alt=""/>
                                    </td>
                                    <td>${orderCell.count}</td>
                                    <td>
                                            ${orderCell.cargo.price} * ${orderCell.count}=${(orderCell.cargo.price)*orderCell.count}
                                    </td>
                                </tr>
                            </c:forEach>
<%--                            <td>${one_order.status}</td>--%>
                        </table>
                    </td>
                        <td>${one_order.status}</td>
                    </tr>

                </c:forEach>
        </table>
<%--        <c:forEach items="${allOrders}" var="one_order">--%>
<%--            <table id="lastOrders" class="table table-striped table-bordered text-center">--%>
<%--                <thead>--%>
<%--                    <th>Назва</th>--%>
<%--                    <th style="width:260px;">Зображення</th>--%>
<%--                    <th>Кількість</th>--%>
<%--                    <th>Вартість</th>--%>
<%--                    <th>Статус</th>--%>
<%--                </thead>--%>

<%--                <c:forEach items="${one_order.cargos}" var="orderCell">--%>
<%--                    <tr>--%>
<%--                        <td>${orderCell.cargo.name}</td>--%>
<%--                        <td>--%>
<%--                            <img src="/myImage/imageDisplay?id=${orderCell.cargo.id}" class="card img-fluid" style="height:150px" alt=""/>--%>
<%--                        </td>--%>
<%--                        <td>${orderCell.count}</td>--%>
<%--                        <td>--%>
<%--                                ${orderCell.cargo.price} * ${orderCell.count}=${(orderCell.cargo.price)*orderCell.count}--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--                <td>${one_order.status}</td>--%>
<%--            </table>--%>
<%--            ${orderCell.order.status}--%>
<%--            <br>--%>
<%--        </c:forEach>--%>
    </c:if>

<%--    <c:if test="${not empty allOrders}">--%>
<%--        <h3>Кількість замовлень: ${allOrders.size()}</h3>--%>
<%--        <br>--%>
<%--        <c:forEach items="${allOrders}" var="one_order">--%>
<%--            <table id="lastOrders" class="table table-striped table-bordered text-center">--%>
<%--                <thead>--%>
<%--                    <th>Назва</th>--%>
<%--                    <th>Зображення</th>--%>
<%--                    <th>Кількість</th>--%>
<%--                </thead>--%>

<%--                <c:forEach items="${one_order.cargos}" var="orderCell">--%>
<%--                    <tr>--%>
<%--                        <td>${orderCell.cargo.name}</td>--%>
<%--                        <td>--%>
<%--                            <img src="/myImage/imageDisplay?id=${orderCell.cargo.id}" class="card img-fluid" style="height:100px" alt=""/>--%>
<%--                        </td>--%>
<%--                        <td>${orderCell.count}</td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--            </table>--%>
<%--            ${orderCell.order.status}--%>
<%--            <br>--%>
<%--        </c:forEach>--%>
<%--    </c:if>--%>


<%--    <a href="/">Головна</a>--%>
</div>
</body>
</html>