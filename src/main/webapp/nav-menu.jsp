<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/posts"> <%-- Redireciona para posts ou para a página principal após login --%>
                <img alt="DH Imports Logo" src="${pageContext.request.contextPath}/images/logo.png" width="30px" style="display: inline-block; vertical-align: middle; margin-right: 5px;">
                DH Imports
            </a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li <c:if test="${pageContext.request.requestURI eq pageContext.request.contextPath || pageContext.request.requestURI eq pageContext.request.contextPath}/posts">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/posts">Posts</a>
                </li>
                <li <c:if test="${pageContext.request.requestURI eq pageContext.request.contextPath}/users">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/users">Usuários</a>
                </li>
                <li <c:if test="${pageContext.request.requestURI eq pageContext.request.contextPath}/companies">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/companies">Empresas</a>
                </li>
                <li <c:if test="${pageContext.request.requestURI eq pageContext.request.contextPath}/cars">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/cars">Carros</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
            </ul>
        </div>
    </div>
</nav>