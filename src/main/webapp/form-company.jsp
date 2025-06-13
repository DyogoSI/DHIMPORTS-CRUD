<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Empresa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>${action == 'update' ? 'Editar Empresa' : 'Cadastrar Empresa'}</h2>
    <form method="post" action="company/${action}">
        <c:if test="${company != null}">
            <input type="hidden" name="companyId" value="${company.id}" />
        </c:if>

        <div class="mb-3">
            <label>Nome:</label>
            <input type="text" name="name" class="form-control" value="${company.name}" required />
        </div>

        <div class="mb-3">
            <label>Função:</label>
            <input type="text" name="role" class="form-control" value="${company.role}" required />
        </div>

        <div class="mb-3">
            <label>Data de Início:</label>
            <input type="date" name="start" class="form-control" value="${company.start}" required />
        </div>

        <div class="mb-3">
            <label>Data de Fim:</label>
            <input type="date" name="end" class="form-control" value="${company.end}" />
        </div>

        <div class="mb-3">
            <label>Usuário Responsável:</label>
            <select name="user" class="form-select" required>
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}" ${company.user.id == user.id ? 'selected' : ''}>${user.name}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="btn btn-success">Salvar</button>
        <a href="companies" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
