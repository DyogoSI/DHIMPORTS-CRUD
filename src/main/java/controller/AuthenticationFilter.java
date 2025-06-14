package controller;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/*"})
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("authenticatedUser") != null);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        boolean isLoginRequest = requestURI.equals(contextPath + "/login");
        boolean isPublicResource = requestURI.startsWith(contextPath + "/css/") ||
                                   requestURI.startsWith(contextPath + "/js/");

        
        if (isLoggedIn || isLoginRequest || isPublicResource) {
            chain.doFilter(request, response);
        } else {
            
            ControllerUtil.errorMessage(httpRequest, "Acesso negado. Por favor, faça login.");
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }

    
    @Override public void init(jakarta.servlet.FilterConfig filterConfig) throws ServletException {}
    @Override public void destroy() {}
}