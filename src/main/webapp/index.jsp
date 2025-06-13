<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Posts - DH Imports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">DH Imports - Painel</a>
        <a href="logout" class="btn btn-outline-light">Sair</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Posts</h2>
    <a href="post/form" class="btn btn-primary mb-3">Novo Post</a>

    <c:if test="${not empty message}">
        <div class="alert alert-${alertType == 1 ? 'success' : 'danger'}">${message}</div>
    </c:if>

    <table class="table table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Conteúdo</th><th>Data</th><th>Usuário</th><th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="post" items="${posts}">
                <tr>
                    <td>${post.id}</td>
                    <td>${post.content}</td>
                    <td>${post.postDate}</td>
                    <td>${post.user.name}</td>
                    <td>
                        <a href="post/update?postId=${post.id}" class="btn btn-warning btn-sm">Editar</a>
                        <a href="post/delete?id=${post.id}" onclick="return confirm('Deseja excluir?')" class="btn btn-danger btn-sm">Excluir</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
