package model.dao;

import java.util.List;
import model.ModelException;
import model.Marca;

public interface MarcaDAO {
    Marca findById(int id) throws ModelException;
    List<Marca> listAll() throws ModelException;
}