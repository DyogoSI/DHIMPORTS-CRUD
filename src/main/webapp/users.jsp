<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Usuários</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2>Usuários</h2>
    <a href="user/form" class="btn btn-primary mb-3">Novo Usuário</a>

    <c:if test="${not empty message}">
        <div class="alert alert-${alertType == 1 ? 'success' : 'danger'}">${message}</div>
    </c:if>

    <table class="table table-bordered">
        <thead class="table-dark">
            <tr><th>ID</th><th>Nome</th><th>Sexo</th><th>Email</th><th>Ações</th></tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.gender}</td>
                <td>${user.email}</td>
                <td>
                    <a href="user/update?userId=${user.id}" class="btn btn-warning btn-sm">Editar</a>
                    <a href="user/delete?id=${user.id}" class="btn btn-danger btn-sm" onclick="return confirm('Deseja excluir?')">Excluir</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
