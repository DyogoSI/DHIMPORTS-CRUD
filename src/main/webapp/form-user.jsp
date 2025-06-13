<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Usuário</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>${action == 'update' ? 'Editar Usuário' : 'Cadastrar Usuário'}</h2>
    <form method="post" action="user/${action}">
        <c:if test="${user != null}">
            <input type="hidden" name="userId" value="${user.id}" />
        </c:if>

        <div class="mb-3">
            <label>Nome:</label>
            <input type="text" name="name" class="form-control" value="${user.name}" required />
        </div>

        <div class="mb-3">
            <label>Sexo:</label>
            <select name="gender" class="form-select" required>
                <option value="M" ${user.gender == 'M' ? 'selected' : ''}>Masculino</option>
                <option value="F" ${user.gender == 'F' ? 'selected' : ''}>Feminino</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Email:</label>
            <input type="email" name="mail" class="form-control" value="${user.email}" required />
        </div>

        <button type="submit" class="btn btn-success">Salvar</button>
        <a href="users" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
</body>
</html>
