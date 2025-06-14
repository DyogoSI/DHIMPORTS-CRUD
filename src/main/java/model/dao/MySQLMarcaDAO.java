package model.dao;

import java.util.ArrayList;
import java.util.List;
import model.ModelException;
import model.Marca;

public class MySQLMarcaDAO implements MarcaDAO {

    @Override
    public Marca findById(int id) throws ModelException {
        Marca marca = null;
        try (DBHandler db = new DBHandler()) {
            String sql = "SELECT * FROM marcas WHERE id = ?;";
            db.prepareStatement(sql);
            db.setInt(1, id);
            db.executeQuery();
            if (db.next()) {
                marca = new Marca();
                marca.setId(db.getInt("id"));
                marca.setNome(db.getString("nome"));
            }
        } catch (Exception e) {
            throw new ModelException("Erro ao encontrar marca por ID.", e);
        }
        return marca;
    }

    @Override
    public List<Marca> listAll() throws ModelException {
        List<Marca> marcas = new ArrayList<>();
        try (DBHandler db = new DBHandler()) {
            String sql = "SELECT * FROM marcas ORDER BY nome;";
            db.createStatement();
            db.executeQuery(sql);
            while (db.next()) {
                Marca m = new Marca();
                m.setId(db.getInt("id"));
                m.setNome(db.getString("nome"));
                marcas.add(m);
            }
        } catch (Exception e) {
            throw new ModelException("Erro ao listar todas as marcas.", e);
        }
        return marcas;
    }
}