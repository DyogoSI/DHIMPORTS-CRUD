package model.dao;

import model.ModelException;
import model.UserLogin;
// A importação de java.sql.SQLException não é mais estritamente necessária aqui se você só capturar ModelException.

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
            db.executeQuery(); // Este método no DBHandler lança ModelException

            if (db.next()) { // Este método no DBHandler lança ModelException
                userLogin = new UserLogin(db.getInt("id")); // getInt no DBHandler lança ModelException
                userLogin.setUsername(db.getString("username")); // getString no DBHandler lança ModelException
                userLogin.setPassword(db.getString("password")); // getString no DBHandler lança ModelException
                userLogin.setRole(db.getString("role")); // getString no DBHandler lança ModelException
            }
        } catch (ModelException e) { // <-- CORREÇÃO: Capturando ModelException
            throw new ModelException("Erro ao buscar credenciais de login: " + e.getMessage(), e);
        } finally {
            db.close(); // <-- CORREÇÃO: O método close() agora é público e pode ser chamado aqui.
        }
        return userLogin;
    }
}