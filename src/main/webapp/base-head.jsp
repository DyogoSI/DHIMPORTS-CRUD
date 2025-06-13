<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DH Imports - Loja de Carros Importados - <c:out value="${pageTitle}" default="Bem-vindo"/></title>

    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"> <%-- ESTE DEVE SER O ÚLTIMO! --%>

</head>
<body>
<%-- nav-menu.jsp só será incluído se o usuário estiver autenticado --%>
<c:if test="${sessionScope.authenticatedUser != null}">
    <jsp:include page="nav-menu.jsp" flush="false"/>
</c:if>

<div class="container">
    <%-- Conteúdo da página real virá aqui --%>
</div>

<%-- O modal de delete, que é global e referenciado por outros JSPs, é incluído aqui se o usuário estiver autenticado --%>
<c:if test="${sessionScope.authenticatedUser != null}">
    <jsp:include page="modal.html" flush="false"/>
</c:if>