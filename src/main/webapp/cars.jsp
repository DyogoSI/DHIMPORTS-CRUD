<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carros - DH Imports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">DH Imports</a>
        <a href="logout" class="btn btn-outline-light">Sair</a>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="mb-3">Carros Cadastrados</h2>
    <a href="car/form" class="btn btn-primary mb-3">Novo Carro</a>

    <c:if test="${not empty message}">
        <div class="alert alert-${alertType == 1 ? 'success' : 'danger'}">${message}</div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Modelo</th><th>Ano</th><th>Preço</th><th>Cor</th><th>Empresa</th><th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="car" items="${cars}">
                <tr>
                    <td>${car.id}</td>
                    <td>${car.model}</td>
                    <td>${car.year}</td>
                    <td>R$ ${car.price}</td>
                    <td>${car.color}</td>
                    <td>${car.company.name}</td>
                    <td>
                        <a href="car/update?carId=${car.id}" class="btn btn-warning btn-sm">Editar</a>
                        <a href="car/delete?id=${car.id}" onclick="return confirm('Confirmar exclusão?')" class="btn btn-danger btn-sm">Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
