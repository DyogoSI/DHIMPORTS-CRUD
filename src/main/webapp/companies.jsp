<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gerenciamento de Empresas - DH Imports</title>
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
                <li><a href="${contextPath}/cars">Carros</a></li>
                <li class="active"><a href="${contextPath}/companies">Empresas</a></li>
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
            <h2>Gerenciamento de Empresas</h2>
            <%-- CORREÇÃO DEFINITIVA DO BOTÃO --%>
            <a href="${contextPath}/company/form" class="btn btn-primary">Adicionar Nova Empresa</a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'}">${message}</div>
        </c:if>

        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Cargo</th>
                    <th>Início</th>
                    <th>Fim</th>
                    <th>Usuário Associado</th>
                    <th class="text-right">Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="company" items="${companies}">
                    <tr>
                        <td>${company.id}</td>
                        <td><c:out value="${company.name}"/></td>
                        <td><c:out value="${company.role}"/></td>
                        <td><fmt:formatDate value="${company.start}" pattern="dd/MM/yyyy" /></td>
                        <td><fmt:formatDate value="${company.end}" pattern="dd/MM/yyyy" /></td>
                        <td><c:out value="${company.user.name}"/></td>
                        <td class="text-right">
                            <a href="${contextPath}/company/update?companyId=${company.id}" class="btn btn-info btn-sm">Editar</a>
                            <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal"
                                    data-id="${company.id}"
                                    data-entity-name="company"
                                    data-description="${company.name}">
                                Excluir
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty companies}">
                    <tr>
                        <td colspan="7" class="text-center">Nenhuma empresa encontrada.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="modal.html" />

<script src="${contextPath}/js/jquery.min.js"></script>
<script src="${contextPath}/js/bootstrap.min.js"></script>
<script>
// Script genérico para o modal de exclusão
$('#delete-modal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var id = button.data('id');
    var description = button.data('description');
    var entityName = button.data('entity-name');

    var modal = $(this);
    modal.find('.modal-body #hiddenValue').text(description);
    
    var form = modal.find('#form');
    form.attr('action', '${contextPath}/' + entityName + '/delete');
    
    modal.find('#id').val(id);
});
</script>

</body>
</html>