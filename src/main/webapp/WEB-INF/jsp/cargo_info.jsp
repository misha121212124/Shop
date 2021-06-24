<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${cargo.name}</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<div class="container">
<%--    <div class="clearfix">--%>
<%--        <span class="float-left">Float left</span>--%>
<%--        <span class="float-right">Float right</span>--%>
<%--        <a class="float-right" href="/">Головна</a>--%>
<%--    </div>--%>
<%--    <div class="mx-auto bg-warning">${cargo.name}</div>--%>
    <h2>${cargo.name}</h2>
    <img src="/myImage/imageDisplay?id=${cargo.id}" class="card img-fluid" style="width:300px" alt=""/>
    <h3>Ціна: ${cargo.price} грн.</h3>
    <br>
    ${cargo.description}
    <br>
    <br>
    ${cargo.characteristics}

<%--</div>--%>
<%--<div>--%>
    <br>
    <sec:authorize access="isAuthenticated()">
        <label>Кількість</label>
        <form action="${pageContext.request.contextPath}/cargo_info" method="POST">
            <input name="count" value="1"/>
            <input type="hidden" name="cargoId" value="${cargo.id}"/>
            <input type="hidden" name="action" value="order"/>
            <input name="address" value="" placeholder="Ваша адреса (дані аккаунту, якщо пусто)"/>

            <button type="submit">Додати до кошику</button>
        </form>
        <h3>${result}</h3>
        <a class="float-right" href="/cargo_search">Каталог</a>
    </sec:authorize>
    <sec:authorize access="!isAuthenticated()">
        <div class="container">
            <br>
            <p>Для формування замовлення та написання відгуку необхідно авторизуватися</p>
        </div>
    </sec:authorize>

</div>


<br>

<div class="container">
    <sec:authorize access="isAuthenticated()">
        <form action="${pageContext.request.contextPath}/cargo_info/addFeedBack" method="POST">
            <input type="hidden" name="cargoId" value="${cargo.id}"/>
            <input type="hidden" name="action" value="addFeedBack"/>
            <textarea type="text" class="form-control" placeholder="Введіть ваш відгук" rows="5" cols="45"
                      name="text" id="text" required="required"></textarea>
                <%--    <input name="text" value="" placeholder="Введіть ваш відгук"/>--%>

            <button type="submit">Опублікувати відгук</button>
        </form>
        <br>
    </sec:authorize>
    <c:if test="${not empty feedbacks}">
        <table id="example" class="table table-striped table-bordered text-center">
            <thead>
            <th>
                <h4>Користувач</h4>
            </th>

            </thead>
            <c:forEach items="${feedbacks}" var="feedback">
                <tr>
                    <td style="width:200px;">
                            ${feedback.user.fname}
                            ${feedback.user.sname}
                    </td>
                    <td>${feedback.text}</td>
                </tr>
            </c:forEach>

        </table>
    </c:if>
</div>

</body>
</html>