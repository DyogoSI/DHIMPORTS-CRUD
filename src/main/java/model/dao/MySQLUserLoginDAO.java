package model.dao;

import model.ModelException;
import model.UserLogin;


public class MySQLUserLoginDAO implements UserLoginDAO {

    @Override
    public UserLogin findByUsernameAndPassword(String username, String password) throws ModelException {
        DBHandler db = new DBHandler();
        String sql = "SELECT * FROM user_logins WHERE username = ? AND password = ?";

        UserLogin userLogin = null;
        try {
            db.prepareStatement(sql);
            db.setString(1, username);
            db.setString(2, password);
            db.executeQuery(); 

            if (db.next()) { 
                userLogin = new UserLogin(db.getInt("id")); 
                userLogin.setUsername(db.getString("username")); 
                userLogin.setPassword(db.getString("password")); 
                userLogin.setRole(db.getString("role")); 
            }
        } catch (ModelException e) { 
            throw new ModelException("Erro ao buscar credenciais de login: " + e.getMessage(), e);
        } finally {
            db.close(); 
        }
        return userLogin;
    }
}