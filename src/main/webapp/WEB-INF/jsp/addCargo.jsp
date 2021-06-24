<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Додати товар</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/style2.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body style="background-color: #eee">
<jsp:include page="index.jsp" />
<div class="contact py-sm-5 py-4">
    <div class="container py-xl-4 py-lg-2">
        <!-- form -->
        <form id="form">
            <div class="contact-grids1 w3agile-6">
                <div class="row">
                    <div class="col-md-6 col-sm-6 contact-form1 form-group">
                        <label class="col-form-label">Назва</label>
                        <input type="text" class="form-control" placeholder="Назва товару" id="name" name="name" required="required">
                        <p id="error_name"></p>
                    </div>
                    <div class="col-md-6 col-sm-6 contact-form1 form-group">
                        <label class="col-form-label">Опис</label>
                        <textarea class="form-control" placeholder="Опис товару" id="description" rows="3" cols="45"
                                  name="description" required="required"></textarea>
                        <p id="error_description"></p>
                    </div>
                    <div class="col-md-6 col-sm-6 contact-form1 form-group">
                        <label class="col-form-label">Зображення</label>
                        <input type="file" class="form-control" placeholder="" name="image" id="image" required="required">
                        <p id="error_file"></p>
                    </div>
                    <div class="col-md-6 col-sm-6 contact-form1 form-group">
                        <label class="col-form-label">Характеристики</label>
                        <textarea type="text" class="form-control" placeholder="Параметри товару" rows="3" cols="45"
                                  name="characteristics" id="characteristics" required="required"></textarea>
                        <p id="error_characteristics"></p>
                    </div>
                    <div class="col-md-6 col-sm-6 contact-form1 form-group">
                        <label class="col-form-label">Ціна</label>
                        <input type="text" class="form-control" placeholder="Ціна"
                               name="price" id="price" required="required"/>
                        <p id="error_price"></p>
                    </div>
                </div>

                <div class="right-w3l col-md-6">
                    <input type="button" id="submit" class="btn btn-primary form-control" value="Додати товар">
                    <br><br>
                </div>
            </div>
            <br>
            <div id="success" class="text-center" style="color:green;"></div>
            <div id="error" class="text-center" style="color:red;"></div>
        </form>
    </div>
</div>


<script src="${contextPath}/resources/js/addCargo.js"></script>
</body>
</html>