package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.ModelException;
import model.UserLogin;
import model.dao.DAOFactory;
import model.dao.UserLoginDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        // Verifica se a ação é logout
        if (action.equals(req.getContextPath() + "/logout")) {
            // Invalida a sessão e redireciona para a página de login
            HttpSession session = req.getSession(false); // Não cria nova sessão se não existir
            if (session != null) {
                session.invalidate(); // Invalida a sessão
            }
            ControllerUtil.sucessMessage(req, "Você foi desconectado com sucesso.");
            ControllerUtil.redirect(resp, req.getContextPath() + "/login");
            return;
        }

        // Se a requisição for para /login e não for logout, exibe a página de login
        ControllerUtil.transferSessionMessagesToRequest(req);
        ControllerUtil.forward(req, resp, "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserLoginDAO userLoginDAO = DAOFactory.createDAO(UserLoginDAO.class);
        try {
            UserLogin userLogin = userLoginDAO.findByUsernameAndPassword(username, password);

            if (userLogin != null) {
                // Autenticação bem-sucedida
                HttpSession session = req.getSession(); // Cria uma nova sessão se não existir
                session.setAttribute("authenticatedUser", userLogin); // Armazena o objeto UserLogin na sessão
                ControllerUtil.sucessMessage(req, "Login realizado com sucesso!");
                // Redireciona para a página principal (posts) após o login
                ControllerUtil.redirect(resp, req.getContextPath() + "/posts");
            } else {
                // Autenticação falhou
                ControllerUtil.errorMessage(req, "Usuário ou senha inválidos.");
                ControllerUtil.redirect(resp, req.getContextPath() + "/login");
            }
        } catch (ModelException e) {
            e.printStackTrace(); // Loga a exceção no servidor
            ControllerUtil.errorMessage(req, "Erro no processo de login: " + e.getMessage());
            ControllerUtil.redirect(resp, req.getContextPath() + "/login");
        }
    }
}