<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - DH Imports</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  
  <style>
    
    body, html {
      height: 100%;
      background-color: #f8f9fa;
    }
    .main-container {
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100%;
    }
  </style>
</head>
<body>

<div class="main-container">
    <div class="col-11 col-sm-8 col-md-6 col-lg-4">
        <div class="card shadow border-0 p-4">
            <div class="card-body">
                <h2 class="card-title text-center mb-1">Bem-vindo!</h2>
                <p class="card-subtitle text-center text-muted mb-4">Faça login para continuar</p>

                <c:if test="${not empty message}">
                    <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">Usuário</label>
                        <input type="text" class="form-control form-control-lg" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Senha</label>
                        <input type="password" class="form-control form-control-lg" id="password" name="password" required>
                    </div>
                    <div class="d-grid mt-4">
                        <button type="submit" class="btn btn-primary btn-lg">Entrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>