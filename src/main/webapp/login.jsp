<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - DH Imports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4 shadow" style="width: 22rem;">
        <h3 class="text-center mb-4">Login</h3>
        <form action="login" method="post">
            <div class="mb-3">
                <label>Usuário</label>
                <input type="text" name="username" class="form-control" required />
            </div>
            <div class="mb-3">
                <label>Senha</label>
                <input type="password" name="password" class="form-control" required />
            </div>
            <button class="btn btn-primary w-100">Entrar</button>
        </form>
        <c:if test="${not empty message}">
            <div class="alert alert-${alertType == 1 ? 'success' : 'danger'} mt-3">${message}</div>
        </c:if>
    </div>
</div>
</body>
</html>
