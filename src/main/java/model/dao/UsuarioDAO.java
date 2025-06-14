package model.dao;

import model.ModelException;
import model.Usuario;

public interface UsuarioDAO {
    Usuario findByUsernameAndPassword(String username, String password) throws ModelException;
}