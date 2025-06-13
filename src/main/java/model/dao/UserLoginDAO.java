package model.dao;

import model.ModelException;
import model.UserLogin;

public interface UserLoginDAO {
    UserLogin findByUsernameAndPassword(String username, String password) throws ModelException;
}