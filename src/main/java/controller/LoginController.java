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

        if (action.equals(req.getContextPath() + "/logout")) {
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

        UserLoginDAO userLoginDAO = DAOFactory.createDAO(UserLoginDAO.class);
        try {
            UserLogin userLogin = userLoginDAO.findByUsernameAndPassword(username, password);

            if (userLogin != null) {
                HttpSession session = req.getSession(); 
                session.setAttribute("authenticatedUser", userLogin); 
                ControllerUtil.sucessMessage(req, "Login realizado com sucesso!");
                ControllerUtil.redirect(resp, req.getContextPath() + "/posts");
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