<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="header.jsp" />

<div class="container">
  <div class="card">
    <div class="card-header">
      <h3>${action == 'update' ? 'Editar Carro' : 'Cadastrar Novo Carro'}</h3>
    </div>

    
    <form action="${pageContext.request.contextPath}/${action == 'update' ? 'carro/update' : 'carro/insert'}" method="post">
      <c:if test="${action == 'update'}">
        <input type="hidden" name="id" value="${carro.id}" />
      </c:if>

      <div class="mb-3">
        <label for="modelo" class="form-label">Modelo:</label>
        <input type="text" class="form-control" id="modelo" name="modelo" value="${carro.modelo}" required />
      </div>

      <div class="mb-3">
        <label for="ano" class="form-label">Ano:</label>
        <input type="number" class="form-control" id="ano" name="ano" value="${carro.ano}" required />
      </div>

      <div class="mb-3">
        <label for="preco" class="form-label">Preço (R$):</label>
        <input type="number" step="0.01" class="form-control" id="preco" name="preco" value="${carro.preco}" required />
      </div>

      <div class="mb-3">
        <label for="cor" class="form-label">Cor:</label>
        <input type="color" class="form-control" id="cor" name="cor" value="${empty carro.cor ? '#000000' : carro.cor}" required />
      </div>

      <div class="mb-3">
        <label for="data_compra" class="form-label">Data da Compra:</label>
        <fmt:formatDate value="${carro.dataCompra}" pattern="yyyy-MM-dd" var="dataCompraFormatada" />
        <input type="date" class="form-control" id="data_compra" name="data_compra" value="${dataCompraFormatada}" />
      </div>

      <div class="mb-3">
        <label for="marca_id" class="form-label">Marca:</label>
        <select class="form-control" id="marca_id" name="marca_id" required>
          <option value="">-- Selecione uma Marca --</option>
          <c:forEach var="marca" items="${marcas}">
            <option value="${marca.id}" ${carro.marca.id == marca.id ? 'selected' : ''}>${marca.nome}</option>
          </c:forEach>
        </select>
      </div>

      <div class="d-flex justify-content-between mt-4">
        <a href="${pageContext.request.contextPath}/carros" class="btn btn-secondary">Cancelar</a>
        <button type="submit" class="btn btn-primary">Salvar</button>
      </div>
    </form>
  </div>
</div>

<jsp:include page="footer.jsp" />
