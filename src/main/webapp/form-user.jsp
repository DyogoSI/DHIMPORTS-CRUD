<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulário de Usuário</title>
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
                <li><a href="${contextPath}/companies">Empresas</a></li>
                <li class="active"><a href="${contextPath}/users">Usuários</a></li>
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
            <h2><c:out value="${action == 'insert' ? 'Adicionar Novo' : 'Editar'}"/> Usuário</h2>
        </div>
        
        <form action="${contextPath}/user/${action}" method="POST">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="userId" value="${user.id}">
            </c:if>

            <div class="form-group">
                <label for="name">Nome:</label>
                <input type="text" class="form-control" id="name" name="name" value="${user.name}" required>
            </div>
             <div class="form-group">
                <label for="gender">Gênero:</label>
                <input type="text" class="form-control" id="gender" name="gender" value="${user.gender}" required>
            </div>
            <div class="form-group">
                <label for="mail">Email:</label>
                <input type="email" class="form-control" id="mail" name="mail" value="${user.email}" required>
            </div>
            <hr>
            <div class="text-right">
                <a href="${contextPath}/users" class="btn btn-default">Cancelar</a>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>