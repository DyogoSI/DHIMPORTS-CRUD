package model.dao;

import java.util.List;
import model.ModelException;
import model.Car;

public interface CarDAO {
    boolean save(Car car) throws ModelException;
    boolean update(Car car) throws ModelException;
    boolean delete(Car car) throws ModelException;
    List<Car> listAll() throws ModelException;
    Car findById(int id) throws ModelException;
}