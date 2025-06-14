package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Carro;
import model.Marca;
import model.ModelException;
import model.dao.CarroDAO;
import model.dao.DAOFactory;
import model.dao.MarcaDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/carros", "/carro/form", "/carro/delete", "/carro/insert", "/carro/update"})
public class CarrosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        switch (action.substring(req.getContextPath().length())) {
            case "/carro/form":
                showForm(req, resp);
                break;
            case "/carro/update":
                showFormForUpdate(req, resp);
                break;
            default:
                listCarros(req, resp);
                break;
        }
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        listMarcas(req);
        req.setAttribute("action", "insert");
        ControllerUtil.forward(req, resp, "/form-carro.jsp");
    }

    private void showFormForUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int carroId = Integer.parseInt(req.getParameter("id"));
        CarroDAO dao = DAOFactory.createDAO(CarroDAO.class);
        try {
            Carro carro = dao.findById(carroId);
            req.setAttribute("carro", carro);
            
            listMarcas(req);
            req.setAttribute("action", "update");
            ControllerUtil.forward(req, resp, "/form-carro.jsp");
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, "Erro ao carregar carro para edição: " + e.getMessage());
            ControllerUtil.redirect(resp, req.getContextPath() + "/carros");
        }
    }

    private void listCarros(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CarroDAO dao = DAOFactory.createDAO(CarroDAO.class);
        try {
            List<Carro> carros = dao.listAll();
            req.setAttribute("carros", carros);
        } catch (ModelException e) {
            e.printStackTrace();
        }
        ControllerUtil.transferSessionMessagesToRequest(req);
        ControllerUtil.forward(req, resp, "/carros.jsp");
    }

    private void listMarcas(HttpServletRequest req) {
        try {
            MarcaDAO dao = DAOFactory.createDAO(MarcaDAO.class);
            List<Marca> marcas = dao.listAll();
            req.setAttribute("marcas", marcas);
        } catch (ModelException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        switch (action.substring(req.getContextPath().length())) {
            case "/carro/insert":
                insertCarro(req, resp);
                break;
            case "/carro/delete":
                deleteCarro(req, resp);
                break;
            case "/carro/update":
                updateCarro(req, resp);
                break;
        }

        ControllerUtil.redirect(resp, req.getContextPath() + "/carros");
    }
    
    private void insertCarro(HttpServletRequest req, HttpServletResponse resp) {
        try {
            Carro carro = createCarroFromRequest(req, false);
            CarroDAO dao = DAOFactory.createDAO(CarroDAO.class);
            if (dao.save(carro)) {
                ControllerUtil.sucessMessage(req, "Carro '" + carro.getModelo() + "' salvo com sucesso!");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao salvar o carro.");
            }
        } catch (Exception e) {
            ControllerUtil.errorMessage(req, "Erro ao processar o formulário: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void updateCarro(HttpServletRequest req, HttpServletResponse resp) {
        try {
            Carro carro = createCarroFromRequest(req, true);
            CarroDAO dao = DAOFactory.createDAO(CarroDAO.class);
            if (dao.update(carro)) {
                ControllerUtil.sucessMessage(req, "Carro '" + carro.getModelo() + "' atualizado com sucesso!");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao atualizar o carro.");
            }
        } catch (Exception e) {
            ControllerUtil.errorMessage(req, "Erro ao processar a atualização: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void deleteCarro(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int carroId = Integer.parseInt(req.getParameter("id"));
            CarroDAO dao = DAOFactory.createDAO(CarroDAO.class);
            Carro carro = new Carro(carroId);
            if (dao.delete(carro)) {
                ControllerUtil.sucessMessage(req, "Carro deletado com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Erro ao deletar o carro. Verifique se há dados relacionados.");
            }
        } catch (Exception e) {
            ControllerUtil.errorMessage(req, "Erro ao processar a deleção: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private Carro createCarroFromRequest(HttpServletRequest req, boolean isUpdate) throws Exception {
        Carro carro = new Carro();
        if (isUpdate) {
            carro.setId(Integer.parseInt(req.getParameter("id")));
        }
        carro.setModelo(req.getParameter("modelo"));
        carro.setAno(Integer.parseInt(req.getParameter("ano")));
        carro.setPreco(Double.parseDouble(req.getParameter("preco")));
        carro.setCor(req.getParameter("cor"));

        
        String dataCompraStr = req.getParameter("data_compra");
        if (dataCompraStr != null && !dataCompraStr.isEmpty()) {
            Date dataCompra = new SimpleDateFormat("yyyy-MM-dd").parse(dataCompraStr);
            carro.setDataCompra(dataCompra);
        }

        int marcaId = Integer.parseInt(req.getParameter("marca_id"));
        carro.setMarca(new Marca(marcaId));

        return carro;
    }
}