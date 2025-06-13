package model.dao;

import java.sql.SQLException; // Ainda pode ser necessário se outras partes do código lançarem diretamente
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

import model.Car;
import model.Company;
import model.ModelException;
import model.User;

public class MySQLCarDAO implements CarDAO {

    @Override
    public boolean save(Car car) throws ModelException {
        DBHandler db = new DBHandler();
        String sqlInsert = "INSERT INTO cars (model, year, price, color, company_id) VALUES (?, ?, ?, ?, ?);";

        try {
            db.prepareStatement(sqlInsert);
            db.setString(1, car.getModel());
            db.setInt(2, car.getYear());
            db.setDouble(3, car.getPrice());
            db.setString(4, car.getColor());
            db.setInt(5, car.getCompany().getId());
            return db.executeUpdate() > 0;
        } catch (ModelException e) { // Mudado de SQLException para ModelException
            throw new ModelException("Erro ao salvar carro: " + e.getMessage(), e);
        } finally {
            // DBHandler.executeUpdate() já fecha a conexão, então não é necessário chamar db.close() aqui
        }
    }

    @Override
    public boolean update(Car car) throws ModelException {
        DBHandler db = new DBHandler();
        String sqlUpdate = "UPDATE cars SET model = ?, year = ?, price = ?, color = ?, company_id = ? WHERE id = ?;";

        try {
            db.prepareStatement(sqlUpdate);
            db.setString(1, car.getModel());
            db.setInt(2, car.getYear());
            db.setDouble(3, car.getPrice());
            db.setString(4, car.getColor());
            db.setInt(5, car.getCompany().getId());
            db.setInt(6, car.getId());
            return db.executeUpdate() > 0;
        } catch (ModelException e) { // Mudado de SQLException para ModelException
            throw new ModelException("Erro ao atualizar carro: " + e.getMessage(), e);
        } finally {
            // DBHandler.executeUpdate() já fecha a conexão
        }
    }

    @Override
    public boolean delete(Car car) throws ModelException {
        DBHandler db = new DBHandler();
        String sqlDelete = "DELETE FROM cars WHERE id = ?;";

        try {
            db.prepareStatement(sqlDelete);
            db.setInt(1, car.getId());
            return db.executeUpdate() > 0;
        } catch (ModelException e) {
            if (e.getCause() instanceof SQLIntegrityConstraintViolationException) {
                throw new ModelException("Não foi possível deletar o carro devido a dados relacionados.", e);
            }
            throw e;
        } finally {
            // DBHandler.executeUpdate() já fecha a conexão
        }
    }

    @Override
    public List<Car> listAll() throws ModelException {
        DBHandler db = new DBHandler();
        List<Car> cars = new ArrayList<>();
        String sqlQuery = "SELECT c.id, c.model, c.year, c.price, c.color, c.company_id, " +
                          "comp.id AS company_id_fk, comp.name AS company_name, comp.role AS company_role, " +
                          "comp.start AS company_start, comp.end AS company_end, comp.user_id AS company_user_id, " +
                          "u.id AS user_id, u.nome AS user_name, u.sexo AS user_gender, u.email AS user_email " +
                          "FROM cars c " +
                          "INNER JOIN companies comp ON c.company_id = comp.id " +
                          "INNER JOIN users u ON comp.user_id = u.id;";

        try {
            db.createStatement();
            db.executeQuery(sqlQuery);

            while (db.next()) {
                cars.add(createCar(db));
            }
        } finally {
            db.close(); // Agora db.close() é acessível
        }
        return cars;
    }

    @Override
    public Car findById(int id) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "SELECT c.id, c.model, c.year, c.price, c.color, c.company_id, " +
                     "comp.id AS company_id_fk, comp.name AS company_name, comp.role AS company_role, " +
                     "comp.start AS company_start, comp.end AS company_end, comp.user_id AS company_user_id, " +
                     "u.id AS user_id, u.nome AS user_name, u.sexo AS user_gender, u.email AS user_email " +
                     "FROM cars c " +
                     "INNER JOIN companies comp ON c.company_id = comp.id " +
                     "INNER JOIN users u ON comp.user_id = u.id " +
                     "WHERE c.id = ?;";

        Car car = null;
        try {
            db.prepareStatement(sql);
            db.setInt(1, id);
            db.executeQuery();

            if (db.next()) {
                car = createCar(db);
            }
        } finally {
            db.close(); // Agora db.close() é acessível
        }
        return car;
    }

    private Car createCar(DBHandler db) throws ModelException {
        Car car = new Car(db.getInt("id"));
        car.setModel(db.getString("model"));
        car.setYear(db.getInt("year"));
        car.setPrice(db.getDouble("price"));
        car.setColor(db.getString("color"));

        Company company = new Company(db.getInt("company_id_fk"));
        company.setName(db.getString("company_name"));
        company.setRole(db.getString("company_role"));
        company.setStart(db.getDate("company_start"));
        company.setEnd(db.getDate("company_end"));

        User user = new User(db.getInt("user_id"));
        user.setName(db.getString("user_name"));
        user.setGender(db.getString("user_gender"));
        user.setEmail(db.getString("user_email"));

        company.setUser(user);
        car.setCompany(company);

        return car;
    }
}