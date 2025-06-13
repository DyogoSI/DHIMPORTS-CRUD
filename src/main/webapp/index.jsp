<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DH Imports - CRUD</title>
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
                <li class="active"><a href="${contextPath}/posts">Posts</a></li>
                <li><a href="${contextPath}/cars">Carros</a></li>
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
            <h2>Gerenciamento de Posts</h2>
            <a href="${contextPath}/post/form" class="btn btn-primary">Adicionar Novo Post</a>
        </div>
        <c:if test="${not empty message}">
            <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'}">${message}</div>
        </c:if>
        <table class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th> <th>Conteúdo</th> <th>Data</th> <th>Usuário</th> <th class="text-right">Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${posts}">
                    <tr>
                        <td>${post.id}</td>
                        <td><c:out value="${post.content}"/></td>
                        <td><fmt:formatDate value="${post.postDate}" pattern="dd/MM/yyyy" /></td>
                        <td><c:out value="${post.user.name}"/></td>
                        <td class="text-right">
                            <a href="${contextPath}/post/update?postId=${post.id}" class="btn btn-info btn-sm">Editar</a>
                            <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#delete-modal" 
                                    data-id="${post.id}" data-entity-name="post" data-description="${post.content}">Excluir</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty posts}"><td colspan="5" class="text-center">Nenhum post encontrado.</td></c:if>
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