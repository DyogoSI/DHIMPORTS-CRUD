package model.dao;

import model.ModelException;
import model.Usuario;

public class MySQLUsuarioDAO implements UsuarioDAO {

    @Override
    public Usuario findByUsernameAndPassword(String username, String password) throws ModelException {
        Usuario usuario = null;
        try (DBHandler db = new DBHandler()) {
            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?;";
            db.prepareStatement(sql);
            db.setString(1, username);
            db.setString(2, password);
            db.executeQuery();

            if (db.next()) {
                usuario = new Usuario();
                usuario.setId(db.getInt("id"));
                usuario.setUsername(db.getString("username"));
                usuario.setPassword(db.getString("password"));
            }
        } catch (Exception e) {
            throw new ModelException("Erro ao autenticar usuário: " + e.getMessage(), e);
        }
        return usuario;
    }
}