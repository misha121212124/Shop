<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Замовлення</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<div class="container">
    <h2>Кошик</h2>
    <c:choose>
        <c:when test="${order.size()>0}">
            <table id="basket" class="table table-striped table-bordered text-center">
                <thead>
                <th>Назва</th>
                <th style="width:260px;">Зображення</th>
                <th>Кількість</th>
                <th>Вартість</th>
                    <%--        тут має бути ціна--%>
                </thead>
                <c:set var="price" value="${0}"/>
                <c:forEach items="${order}" var="orderCell">
                    <c:set var="price" value="${price + (orderCell.cargo.price)*orderCell.count}" />
                    <tr>
                        <td>${orderCell.cargo.name}</td>
                        <td>
                            <img src="/myImage/imageDisplay?id=${orderCell.cargo.id}" class="card img-fluid" style="width:250px" alt=""/>
                        </td>
                        <td>${orderCell.count}</td>
                        <td>
                            ${orderCell.cargo.price} * ${orderCell.count}=${(orderCell.cargo.price)*orderCell.count}
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/basket_remove" method="post">
                                <input type="hidden" name="orderId" value="${order_id}"/>
                                <input type="hidden" name="cargoId" value="${orderCell.cargo.id}"/>
                                <input type="hidden" name="action" value="deleteCargoFromBasket"/>
                                <button type="submit">Видалити</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <label>Загальна вартість: ${price} грн.</label>
            <form action="${pageContext.request.contextPath}/submit_order" method="post">
                <input type="hidden" name="orderId" value="${order_id}"/>
                <button type="submit">Оформити</button>
            </form>
        </c:when>
        <c:otherwise>
            <h3>Кошик порожній</h3>
        </c:otherwise>
    </c:choose>

<%--    <a href="/">Головна</a>--%>
    <br>

    <c:if test="${not empty allOrders}">
        <c:forEach items="${allOrders}" var="one_order">
            <table id="lastOrders" class="table table-striped table-bordered text-center">
                <thead>
                    <th>Назва</th>
                    <th style="width:260px;">Зображення</th>
                    <th>Кількість</th>
                    <th>Вартість</th>
                    <th>Статус</th>
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
                        <td>${one_order.status}</td>
                    </tr>
                </c:forEach>
            </table>
            ${orderCell.order.status}
            <br>
        </c:forEach>
<%--        <a href="/">Головна</a>--%>
    </c:if>


<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
<%--    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>--%>
<%--    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap.min.js"></script>--%>

</div>
</body>
</html>