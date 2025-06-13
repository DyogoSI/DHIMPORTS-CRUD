<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulário de Carro</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/css/style.css">
</head>
<body>

<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${contextPath}/posts">DH Imports</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="${contextPath}/posts">Posts</a></li>
                <li class="active"><a href="${contextPath}/cars">Carros</a></li>
                <li><a href="${contextPath}/companies">Empresas</a></li>
                <li><a href="${contextPath}/users">Usuários</a></li>
            </ul>
             <ul class="nav navbar-nav navbar-right">
                <li><a href="${contextPath}/logout"><span class="glyphicon glyphicon-log-out"></span> Sair</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="card">
        <div class="header">
            <h2><c:out value="${action == 'insert' ? 'Adicionar Novo' : 'Editar'}"/> Carro</h2>
        </div>

        <form action="${contextPath}/car/${action}" method="POST">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="carId" value="${car.id}">
            </c:if>

            <div class="form-group">
                <label for="model">Modelo:</label>
                <input type="text" class="form-control" id="model" name="model" value="${car.model}" required>
            </div>
            <div class="form-group">
                <label for="year">Ano:</label>
                <input type="number" class="form-control" id="year" name="year" value="${car.year}" required>
            </div>
            <div class="form-group">
                <label for="price">Preço:</label>
                <input type="text" class="form-control" id="price" name="price" value="${car.price}" required>
            </div>
             <div class="form-group">
                <label for="color">Cor:</label>
                <input type="text" class="form-control" id="color" name="color" value="${car.color}" required>
            </div>
            <div class="form-group">
                <label for="company">Marca (Empresa):</label>
                <select class="form-control" id="company" name="company" required>
                    <option value="">Selecione a marca</option>
                    <c:forEach var="company" items="${companies}">
                        <option value="${company.id}" ${car.company.id == company.id ? 'selected' : ''}>
                            <c:out value="${company.name}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <hr>
            <div class="text-right">
                <a href="${contextPath}/cars" class="btn btn-default">Cancelar</a>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>