package controller;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/*"}) // Protege TUDO
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialização do filtro, se necessário
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false); // Não cria nova sessão se não existir

        boolean isLoggedIn = (session != null && session.getAttribute("authenticatedUser") != null);

        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();

        // URLs que não exigem autenticação
        boolean isLoginRequest = requestURI.equals(contextPath + "/login");
        boolean isLogoutRequest = requestURI.equals(contextPath + "/logout");

        // CORREÇÃO AQUI: Detecção mais robusta da página raiz
        // Verifica se a requestURI é exatamente o contextPath OU o contextPath com uma barra no final
        boolean isRootPath = requestURI.equals(contextPath) || requestURI.equals(contextPath + "/");

        boolean isPublicResource = requestURI.startsWith(contextPath + "/css/") ||
                                   requestURI.startsWith(contextPath + "/js/") ||
                                   requestURI.startsWith(contextPath + "/images/");

        // Se o usuário está logado OU a requisição é para login/logout/recurso público
        if (isLoggedIn || isLoginRequest || isLogoutRequest || isPublicResource) {
            // Se for a página raiz E o usuário NÃO estiver logado, redireciona para o login
            if (isRootPath && !isLoggedIn) {
                httpResponse.sendRedirect(contextPath + "/login");
                return; // Importante para parar o processamento aqui
            }
            chain.doFilter(request, response); // Permite que a requisição continue
        } else {
            // Se não estiver logado e tentar acessar um recurso PROTEGIDO
            ControllerUtil.errorMessage(httpRequest, "Acesso negado. Por favor, faça login para acessar esta página.");
            httpResponse.sendRedirect(contextPath + "/login"); // Redireciona para a página de login
        }
    }

    @Override
    public void destroy() {
        // Limpeza do filtro, se necessário
    }
}