<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html lang="ua">
<head>
    <meta charset="utf-8">
    <title>Пошук товарів</title>
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
    <sec:authorize access="hasRole('ROLE_MANAGER')">
        <a href="/addCargo"><h2>Додати товар</h2></a>
        <br>
    </sec:authorize>
    <h2>Пошук товарів</h2>

    <div class="form-group">
        <form method="GET" action="/cargo_search/{name}">
            <div>
                <input name="name" type="text" class="form-control" placeholder="Що ви шукаєте?" autofocus="true"/>
                <br>
                <button type="submit">Знайти схожі товари</button>
            </div>
        </form>
    </div>


    <div class="container">
        <br>
        <table id="example" class="table table-striped">
<%--    <table id="example" class="table table-striped table-bordered text-center">--%>
        <thead>
        <th>Назва</th>
        <th>Зображення</th>
        <th>Опис</th>
        <th>Характеристики</th>
        </thead>

        <c:forEach items="${allCargos}" var="cargo">
            <tr>
                <td>${cargo.name}</td>
                <td>
                    <div class="container">
<%--                        <h2>Rounded Corners</h2>--%>
<%--                        <p>The .rounded class adds rounded corners to an image:</p>--%>
                        <img src="/myImage/imageDisplay?id=${cargo.id}" class="rounded" alt="Cinque Terre" width="300">
                    </div>
<%--                    <img src="/myImage/imageDisplay?id=${cargo.id}" class="card img-fluid" style="width:300px" alt=""/>--%>
                </td>
                <td>
                    <p>${cargo.description}</p>
                </td>
                <td>${cargo.characteristics}</td>
                <td>
                    <div class="container">
                        <form action="${pageContext.request.contextPath}/cargo_search" method="post">
                            <input type="hidden" name="cargoId" value="${cargo.id}"/>
                            <input type="hidden" name="action" value="showCargo"/>
                            <button type="submit">Перейти</button>
                        </form>
                    </div>

<%--                </td>--%>
<%--                <td>--%>

                    <sec:authorize access="hasRole('ROLE_MANAGER')">
                        <p/>
                        <div class="container">
                            <form action="${pageContext.request.contextPath}/cargo_search" method="post">
                                <input type="hidden" name="cargoId" value="${cargo.id}"/>
                                <input type="hidden" name="action" value="deleteCargo"/>
                                <button type="submit" >Видалити</button>
                            </form>
                        </div>
                    </sec:authorize>
                </td>
            </tr>
        </c:forEach>
<%--    </table>--%>
        </table>
    </div>

<%--    <a href="/">Головна</a>--%>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap.min.js"></script>
<%--    <script type="text/javascript">--%>
<%--        $(document).ready(function() {--%>
<%--            $('#example').DataTable();--%>
<%--        } );--%>
<%--    </script>--%>
</div>
</body>
</html>