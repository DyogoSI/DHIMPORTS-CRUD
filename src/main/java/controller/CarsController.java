package controller;

import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Car;
import model.Company;
import model.ModelException;
import model.dao.CarDAO;
import model.dao.CompanyDAO;
import model.dao.DAOFactory;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/cars", "/car/form", "/car/insert", "/car/delete", "/car/update"})
public class CarsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        if (action.endsWith("/car/form")) {
            listCompanies(req); // <-- ESTA LINHA CHAMA O MÉTODO PARA CARREGAR AS EMPRESAS
            req.setAttribute("action", "insert");
            ControllerUtil.forward(req, resp, "/form-car.jsp");
        } else if (action.endsWith("/car/update")) {
            listCompanies(req); // <-- E AQUI TAMBÉM!
            Car car = loadCar(req);
            req.setAttribute("car", car);
            req.setAttribute("action", "update");
            ControllerUtil.forward(req, resp, "/form-car.jsp");
        } else {
            listCars(req);
            ControllerUtil.transferSessionMessagesToRequest(req);
            ControllerUtil.forward(req, resp, "/cars.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getRequestURI();

        if (action == null || action.equals("")) {
            ControllerUtil.forward(req, resp, "/cars.jsp");
            return;
        }

        if (action.endsWith("/car/insert")) {
            insertCar(req, resp);
        } else if (action.endsWith("/car/delete")) {
            deleteCar(req, resp);
        } else if (action.endsWith("/car/update")) {
            updateCar(req, resp);
        } else {
            System.out.println("URL inválida: " + action);
        }

        ControllerUtil.redirect(resp, req.getContextPath() + "/cars");
    }

    private void listCars(HttpServletRequest req) {
        CarDAO dao = DAOFactory.createDAO(CarDAO.class);
        List<Car> cars = null;
        try {
            cars = dao.listAll();
        } catch (ModelException e) {
            e.printStackTrace();
        }
        if (cars != null) {
            req.setAttribute("cars", cars);
        }
    }

    // Este método é responsável por carregar a lista de empresas (marcas)
    private void listCompanies(HttpServletRequest req) {
        CompanyDAO dao = DAOFactory.createDAO(CompanyDAO.class);
        List<Company> companies = null;
        try {
            companies = dao.listAll(); // Chama o DAO para buscar todas as empresas
        } catch (ModelException e) {
            e.printStackTrace(); // MUITO IMPORTANTE: Verifique o console do Tomcat para ver se há erros aqui!
        }
        if (companies != null) {
            req.setAttribute("companies", companies); // Adiciona a lista de empresas ao request
        }
    }

    private Car loadCar(HttpServletRequest req) {
        String carIdStr = req.getParameter("carId");
        int carId = Integer.parseInt(carIdStr);

        CarDAO dao = DAOFactory.createDAO(CarDAO.class);
        Car car = null;
        try {
            car = dao.findById(carId);
            if (car == null) {
                throw new ModelException("Carro não encontrado para alteração.");
            }
            return car;
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
        return null;
    }

    private void insertCar(HttpServletRequest req, HttpServletResponse resp) {
        String model = req.getParameter("model");
        int year = Integer.parseInt(req.getParameter("year"));
        double price = Double.parseDouble(req.getParameter("price"));
        String color = req.getParameter("color");
        int companyId = Integer.parseInt(req.getParameter("company")); // Do input select

        Car car = new Car();
        car.setModel(model);
        car.setYear(year);
        car.setPrice(price);
        car.setColor(color);
        car.setCompany(new Company(companyId)); // Definir a empresa pelo ID

        CarDAO dao = DAOFactory.createDAO(CarDAO.class);
        try {
            if (dao.save(car)) {
                ControllerUtil.sucessMessage(req, "Carro '" + car.getModel() + "' salvo com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Carro '" + car.getModel() + "' não pode ser salvo.");
            }
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
    }

    private void updateCar(HttpServletRequest req, HttpServletResponse resp) {
        String carIdStr = req.getParameter("carId");
        String model = req.getParameter("model");
        int year = Integer.parseInt(req.getParameter("year"));
        double price = Double.parseDouble(req.getParameter("price"));
        String color = req.getParameter("color");
        int companyId = Integer.parseInt(req.getParameter("company"));

        Car car = loadCar(req); // Carrega o carro existente para atualização
        if (car == null) {
            return; // Mensagem de erro já foi definida por loadCar
        }

        car.setModel(model);
        car.setYear(year);
        car.setPrice(price);
        car.setColor(color);
        car.setCompany(new Company(companyId)); // Definir a empresa pelo ID

        CarDAO dao = DAOFactory.createDAO(CarDAO.class);
        try {
            if (dao.update(car)) {
                ControllerUtil.sucessMessage(req, "Carro '" + car.getModel() + "' atualizado com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Carro '" + car.getModel() + "' não pode ser atualizado.");
            }
        } catch (ModelException e) {
            e.printStackTrace();
            ControllerUtil.errorMessage(req, e.getMessage());
        }
    }

    private void deleteCar(HttpServletRequest req, HttpServletResponse resp) {
        String carIdStr = req.getParameter("id");
        int carId = Integer.parseInt(carIdStr);

        CarDAO dao = DAOFactory.createDAO(CarDAO.class);
        try {
            Car car = dao.findById(carId);
            if (car == null) {
                throw new ModelException("Carro não encontrado para deleção.");
            }
            if (dao.delete(car)) {
                ControllerUtil.sucessMessage(req, "Carro '" + car.getModel() + "' deletado com sucesso.");
            } else {
                ControllerUtil.errorMessage(req, "Carro '" + car.getModel() + "' não pode ser deletado. Pode haver dados relacionados ao carro.");
            }
        } catch (ModelException e) {
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                ControllerUtil.errorMessage(req, "Não foi possível deletar o carro devido a dados relacionados.");
            } else {
                ControllerUtil.errorMessage(req, e.getMessage());
            }
            e.printStackTrace();
        }
    }
}