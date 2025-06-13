<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - DH Imports</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/css/style.css">
    <style>
        .login-container { max-width: 400px; margin: 50px auto; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card login-container">
            <h2 class="text-center">Login</h2>
            <hr/>
            
            <c:if test="${not empty message}">
                <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'}">
                    ${message}
                </div>
            </c:if>

            <form action="${contextPath}/login" method="POST">
                <div class="form-group">
                    <label for="username">Usuário:</label>
                    <input type="text" class="form-control" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Senha:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Entrar</button>
            </form>
        </div>
    </div>
</body>
</html>