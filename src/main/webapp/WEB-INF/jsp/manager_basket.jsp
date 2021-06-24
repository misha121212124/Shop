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
    <div class="mx-auto" style="width:350px">
        <br>
        <h2>Список замовлень</h2>
        <br>
    </div>



    <c:if test="${not empty allOrders}">
        <c:forEach items="${allOrders}" var="one_order">
            <h2>Користувач ${one_order.user.sname} ${one_order.user.fname}</h2>
            <div class="row">
                <div class="col">E-mail: ${one_order.user.email}</div>
                <div class="col">Номер Телефону: ${one_order.user.phone}</div>
            </div>
            <div class="container">
                <p>Адреса: ${one_order.user.adress}</p>
            </div>

            <table id="lastOrders" class="table table-striped table-bordered text-center">
                <thead>
                    <th>Назва</th>
                    <th style="width:260px;">Зображення</th>
                    <th>Кількість</th>
                    <th>Вартість</th>
<%--                    <th>Статус</th>--%>
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

            </table>
            <div class="row" >
                <div class="col">
                    <form action="${pageContext.request.contextPath}/manager_basket" method="post">
                        <div class="clearfix">
                            <span class="float-left">
                                <select name="newStatus">
                                    <option selected value="${one_order.status}">${one_order.status}</option>
                                    <option value="processing">processing</option>
                                    <option value="submited">submited</option>
                                    <option value="sent">sent</option>
                                    <option value="delivered">delivered</option>
                                    <option value="completed">completed</option>
                                    <option value="canceled">canceled</option>
                                </select>
                            </span>
                            <span class="float-right">
                                <input type="hidden" name="orderId" value="${one_order.id}"/>
                                <input type="hidden" name="action" value="submitOrder"/>
                                <button type="submit">Змінити статус</button>
                            </span>
                        </div>
                    </form>
                </div>
                <div class="col">
                    <div class="container mx-auto" style="width:150px">
<%--                            <span class="float-">--%>
                                <form action="${pageContext.request.contextPath}/manager_basket" method="post">
                                    <input type="hidden" name="orderId" value="${one_order.id}"/>
                                    <input type="hidden" name="action" value="deleteOrder"/>
                                    <button type="submit">Видалити</button>
                                </form>
<%--                            </span>--%>
                    </div>

                </div>
                <div class="col">
                    <h3>Статус: ${one_order.status}</h3>
                </div>
            </div>
            <br>
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