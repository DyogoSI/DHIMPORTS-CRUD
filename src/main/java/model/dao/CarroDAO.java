package model.dao;

import java.util.List;
import model.ModelException;
import model.Carro;

public interface CarroDAO {
    boolean save(Carro carro) throws ModelException;
    boolean update(Carro carro) throws ModelException;
    boolean delete(Carro carro) throws ModelException;
    List<Carro> listAll() throws ModelException;
    Carro findById(int id) throws ModelException;
}