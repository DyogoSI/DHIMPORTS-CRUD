<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Empresas - DH Imports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
    <h2>Empresas</h2>
    <a href="company/form" class="btn btn-primary mb-3">Nova Empresa</a>

    <c:if test="${not empty message}">
        <div class="alert alert-${alertType == 1 ? 'success' : 'danger'}">${message}</div>
    </c:if>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Nome</th><th>Função</th><th>Início</th><th>Fim</th><th>Usuário</th><th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="company" items="${companies}">
                <tr>
                    <td>${company.id}</td>
                    <td>${company.name}</td>
                    <td>${company.role}</td>
                    <td>${company.start}</td>
                    <td>${company.end}</td>
                    <td>${company.user.name}</td>
                    <td>
                        <a href="company/update?companyId=${company.id}" class="btn btn-warning btn-sm">Editar</a>
                        <a href="company/delete?id=${company.id}" onclick="return confirm('Deseja excluir?')" class="btn btn-danger btn-sm">Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
