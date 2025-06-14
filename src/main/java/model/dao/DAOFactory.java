package model.dao;

import java.util.HashMap;
import java.util.Map;

public class DAOFactory {

    private static final Map<Class<?>, Object> daos = new HashMap<>();

    static {
        
        daos.put(UsuarioDAO.class, new MySQLUsuarioDAO());
        daos.put(MarcaDAO.class, new MySQLMarcaDAO());
        daos.put(CarroDAO.class, new MySQLCarroDAO());
    }

    @SuppressWarnings("unchecked")
    public static <T> T createDAO(Class<T> daoInterface) {
        return (T) daos.get(daoInterface);
    }
}