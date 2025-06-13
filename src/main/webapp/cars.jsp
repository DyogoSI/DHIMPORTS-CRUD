<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciamento de Carros - DH Imports</title>
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
            <h2>Gerenciamento de Carros</h2>
            <a href="${contextPath}/car/form" class="btn btn-primary">Adicionar Novo Carro</a>
        </div>
        <c:if test="${not empty message}">
            <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'}">${message}</div>
        </c:if>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th> <th>Modelo</th> <th>Ano</th> <th>Preço</th> <th>Cor</th> <th>Marca</th> <th class="text-right">Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="car" items="${cars}">
                    <tr>
                        <td>${car.id}</td>
                        <td><c:out value="${car.model}"/></td>
                        <td><c:out value="${car.year}"/></td>
                        <td><fmt:formatNumber value="${car.price}" type="currency" currencySymbol="R$ "/></td>
                        <td><c:out value="${car.color}"/></td>
                        <td><c:out value="${car.company.name}"/></td>
                        <td class="text-right">
                            <a href="${contextPath}/car/update?carId=${car.id}" class="btn btn-info btn-sm">Editar</a>
                            <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal" 
                                    data-id="${car.id}" data-entity-name="car" data-description="${car.model}">Excluir</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty cars}"><td colspan="7" class="text-center">Nenhum carro encontrado.</td></c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="modal.html" />
<script src="${contextPath}/js/jquery.min.js"></script>
<script src="${contextPath}/js/bootstrap.min.js"></script>
<script>
$('#delete-modal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget), id = button.data('id'), description = button.data('description'), entityName = button.data('entity-name'), modal = $(this);
    modal.find('.modal-body #hiddenValue').text(description);
    modal.find('#form').attr('action', '${contextPath}/' + entityName + '/delete');
    modal.find('#id').val(id);
});
</script>
</body>
</html>