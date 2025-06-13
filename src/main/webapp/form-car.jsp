<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulário de Carro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>${action == 'update' ? 'Editar Carro' : 'Cadastrar Carro'}</h2>
    <form method="post" action="car/${action}">
        <c:if test="${car != null}">
            <input type="hidden" name="carId" value="${car.id}" />
        </c:if>

        <div class="mb-3">
            <label class="form-label">Modelo:</label>
            <input type="text" class="form-control" name="model" value="${car.model}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Ano:</label>
            <input type="number" class="form-control" name="year" value="${car.year}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Preço:</label>
            <input type="number" step="0.01" class="form-control" name="price" value="${car.price}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Cor:</label>
            <input type="text" class="form-control" name="color" value="${car.color}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Empresa:</label>
            <select name="company" class="form-select" required>
                <c:forEach var="c" items="${companies}">
                    <option value="${c.id}" ${car.company.id == c.id ? 'selected' : ''}>${c.name}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Salvar</button>
        <a href="cars" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
