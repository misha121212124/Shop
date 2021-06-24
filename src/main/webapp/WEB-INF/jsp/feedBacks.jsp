<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Нерозглянуті відгуки</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<br>
<div class="container">
    <c:choose>
        <c:when test="${not empty feedbacks}">
            <table id="example" class="table table-striped table-bordered text-center">
                <thead>
                <th>
                    <h4>Користувач</h4>
                </th>
                <th>
                    <h4>Товар</h4>
                </th>

<%--&lt;%&ndash;                <th></th>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <th></th>&ndash;%&gt;--%>

                </thead>
                <c:forEach items="${feedbacks}" var="feedback">
                    <tr>
                        <td style="width:140px;">
                                ${feedback.user.fname} ${feedback.user.sname}
                                ${feedback.user.id}
                        </td>
                        <td style="width:150px;">
                            ${feedback.cargo.name}
                            ${feedback.cargo.id}
                        </td>

                        <td>${feedback.text}</td>
                        <td style="width:110px;">
                            <form action="${pageContext.request.contextPath}/feedBacks" method="post">
                                <input type="hidden" name="feedBackId" value="${feedback.id}"/>
                                <input type="hidden" name="action" value="submitFeedBack"/>
                                <button type="submit">Дозволити</button>
                            </form>
                        </td>
                        <td style="width:110px;">
                            <form action="${pageContext.request.contextPath}/feedBacks" method="post">
                                <input type="hidden" name="feedBackId" value="${feedback.id}"/>
                                <input type="hidden" name="action" value="deleteFeedBack"/>
                                <button type="submit">Видалити</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <h3>Немає необроблених відгуків</h3>
        </c:otherwise>
    </c:choose>


<%--    <a href="/">Головна</a>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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




