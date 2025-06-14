package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ModelException;
import model.Usuario;
import model.dao.DAOFactory;
import model.dao.UsuarioDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        if (action.endsWith("/logout")) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            ControllerUtil.sucessMessage(req, "Você foi desconectado com sucesso.");
            ControllerUtil.redirect(resp, req.getContextPath() + "/login");
            return;
        }

        ControllerUtil.transferSessionMessagesToRequest(req);
        ControllerUtil.forward(req, resp, "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            ControllerUtil.errorMessage(req, "Usuário e senha são obrigatórios.");
            ControllerUtil.redirect(resp, req.getContextPath() + "/login");
            return;
        }

        UsuarioDAO dao = DAOFactory.createDAO(UsuarioDAO.class);
        try {
            Usuario usuario = dao.findByUsernameAndPassword(username, password);

            if (usuario != null) {
                HttpSession session = req.getSession(true);
                session.setAttribute("authenticatedUser", usuario);
                ControllerUtil.redirect(resp, req.getContextPath() + "/carros");
            } else {
                ControllerUtil.errorMessage(req, "Usuário ou senha inválidos.");
                ControllerUtil.redirect(resp, req.getContextPath() + "/login");
            }
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, "Erro no processo de login: " + e.getMessage());
            ControllerUtil.redirect(resp, req.getContextPath() + "/login");
        }
    }
}