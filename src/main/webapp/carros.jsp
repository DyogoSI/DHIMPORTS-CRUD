<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="card shadow-sm border-0">
  <div class="card-header bg-white pb-0 border-0">
    <div class="d-flex justify-content-between align-items-center">
        <h3 class="fw-light">Catálogo de Carros</h3>
        <a href="${pageContext.request.contextPath}/carro/form" class="btn btn-primary">
            <i class="bi bi-plus-lg"></i> Novo Carro
        </a>
    </div>
  </div>
  <div class="card-body">
    <c:if test="${not empty message}">
      <div class="alert ${alertType == 1 ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
          ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    </c:if>

    <div class="row">
      <c:if test="${empty carros}">
        <div class="col-12">
            <p class="text-center text-muted mt-4">Nenhum carro cadastrado ainda.</p>
        </div>
      </c:if>

      <c:forEach var="carro" items="${carros}">
        <div class="col-md-6 col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">${carro.modelo}</h5>
              <h6 class="card-subtitle mb-2 text-muted">${carro.marca.nome} • ${carro.ano}</h6>
              <p class="card-text mt-3">
                <strong>Preço:</strong> <fmt:formatNumber value="${carro.preco}" type="currency" currencySymbol="R$ " /><br>
                <fmt:formatDate value="${carro.dataCompra}" var="data" pattern="dd/MM/yyyy" />
                <c:if test="${not empty data}">
                    <strong>Comprado em:</strong> ${data}<br>
                </c:if>
                
                <%-- ✅ CORREÇÃO DEFINITIVA: Estilos aplicados diretamente no elemento para garantir a exibição. --%>
                <strong>Cor:</strong> 
                <span style="display: inline-block; width: 20px; height: 20px; border-radius: 50%; background-color: ${carro.cor}; border: 1px solid #ddd; vertical-align: middle;"></span>
              </p>
              <div class="mt-auto text-end">
                <a href="${pageContext.request.contextPath}/carro/update?id=${carro.id}" class="btn btn-sm btn-outline-primary">
                  <i class="bi bi-pencil"></i> Editar
                </a>
                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#delete-modal"
                        data-id="${carro.id}" data-name="${carro.modelo}">
                  <i class="bi bi-trash"></i> Excluir
                </button>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

<div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Excluir Carro</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Deseja realmente excluir o carro <strong id="item-name"></strong>?
      </div>
      <div class="modal-footer">
        <form id="delete-form" action="${pageContext.request.contextPath}/carro/delete" method="POST">
          <input type="hidden" name="id" id="id-para-excluir">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-danger">Excluir</button>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp" />

<script>
  $('#delete-modal').on('show.bs.modal', function (event) {
    const button = $(event.relatedTarget);
    const carId = button.data('id');
    const carName = button.data('name');
    const modal = $(this);
    
    modal.find('#item-name').text(carName);
    modal.find('#id-para-excluir').val(carId);
  });
</script>