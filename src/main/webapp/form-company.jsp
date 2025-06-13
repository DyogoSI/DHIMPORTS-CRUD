<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Formulário de Empresa</title>
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
            <h2><c:out value="${action == 'insert' ? 'Adicionar Nova' : 'Editar'}"/> Empresa</h2>
        </div>
        
        <form action="${contextPath}/company/${action}" method="POST">
            <c:if test="${action == 'update'}">
                <input type="hidden" name="companyId" value="${company.id}">
            </c:if>

            <div class="form-group">
                <label for="name">Nome da Empresa:</label>
                <input type="text" class="form-control" id="name" name="name" value="${company.name}" required>
            </div>
            <div class="form-group">
                <label for="role">Cargo:</label>
                <input type="text" class="form-control" id="role" name="role" value="${company.role}" required>
            </div>
             <div class="form-group">
                <label for="start">Data de Início:</label>
                <fmt:formatDate value="${company.start}" pattern="yyyy-MM-dd" var="startDate" />
                <input type="date" class="form-control" id="start" name="start" value="${startDate}" required>
            </div>
            <div class="form-group">
                <label for="end">Data de Fim:</label>
                <fmt:formatDate value="${company.end}" pattern="yyyy-MM-dd" var="endDate" />
                <input type="date" class="form-control" id="end" name="end" value="${endDate}">
            </div>
            <div class="form-group">
                <label for="user">Usuário Associado:</label>
                <select class="form-control" id="user" name="user" required>
                    <option value="">Selecione um usuário</option>
                    <c:forEach var="user" items="${users}">
                        <option value="${user.id}" ${company.user.id == user.id ? 'selected' : ''}>
                            <c:out value="${user.name}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <hr>
            <div class="text-right">
                <a href="${contextPath}/companies" class="btn btn-default">Cancelar</a>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>