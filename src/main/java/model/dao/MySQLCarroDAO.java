package model.dao;

import java.util.ArrayList;
import java.util.List;
import model.Carro;
import model.Marca;
import model.ModelException;

public class MySQLCarroDAO implements CarroDAO {

    @Override
    public boolean save(Carro carro) throws ModelException {
        try (DBHandler db = new DBHandler()) {
            String sql = "INSERT INTO carros (modelo, ano, preco, cor, data_compra, marca_id) VALUES (?, ?, ?, ?, ?, ?);";
            db.prepareStatement(sql);
            db.setString(1, carro.getModelo());
            db.setInt(2, carro.getAno());
            db.setDouble(3, carro.getPreco());
            db.setString(4, carro.getCor());
            db.setDate(5, carro.getDataCompra());
            db.setInt(6, carro.getMarca().getId());
            return db.executeUpdate() > 0;
        } catch (Exception e) {
            throw new ModelException("Erro ao salvar carro.", e);
        }
    }

    @Override
    public boolean update(Carro carro) throws ModelException {
        try (DBHandler db = new DBHandler()) {
            String sql = "UPDATE carros SET modelo = ?, ano = ?, preco = ?, cor = ?, data_compra = ?, marca_id = ? WHERE id = ?;";
            db.prepareStatement(sql);
            db.setString(1, carro.getModelo());
            db.setInt(2, carro.getAno());
            db.setDouble(3, carro.getPreco());
            db.setString(4, carro.getCor());
            db.setDate(5, carro.getDataCompra());
            db.setInt(6, carro.getMarca().getId());
            db.setInt(7, carro.getId());
            return db.executeUpdate() > 0;
        } catch (Exception e) {
            throw new ModelException("Erro ao atualizar carro.", e);
        }
    }

    @Override
    public boolean delete(Carro carro) throws ModelException {
        try (DBHandler db = new DBHandler()) {
            String sql = "DELETE FROM carros WHERE id = ?;";
            db.prepareStatement(sql);
            db.setInt(1, carro.getId());
            return db.executeUpdate() > 0;
        } catch (Exception e) {
            throw new ModelException("Erro ao deletar carro.", e);
        }
    }

    @Override
    public List<Carro> listAll() throws ModelException {
        List<Carro> carros = new ArrayList<>();
        String sql = "SELECT c.*, m.nome as marca_nome FROM carros c JOIN marcas m ON c.marca_id = m.id ORDER BY c.modelo;";
        try (DBHandler db = new DBHandler()) {
            db.createStatement();
            db.executeQuery(sql);
            while (db.next()) {
                carros.add(createCarro(db, true));
            }
        } catch (Exception e) {
            throw new ModelException("Erro ao listar carros.", e);
        }
        return carros;
    }

    @Override
    public Carro findById(int id) throws ModelException {
        Carro carro = null;
        String sql = "SELECT * FROM carros WHERE id = ?;";
        try (DBHandler db = new DBHandler()) {
            db.prepareStatement(sql);
            db.setInt(1, id);
            db.executeQuery();
            if (db.next()) {
                carro = createCarro(db, false);
            }
        } catch (Exception e) {
            throw new ModelException("Erro ao buscar carro por ID.", e);
        }
        return carro;
    }

    private Carro createCarro(DBHandler db, boolean fromList) throws ModelException {
        Carro carro = new Carro(db.getInt("id"));
        carro.setModelo(db.getString("modelo"));
        carro.setAno(db.getInt("ano"));
        carro.setPreco(db.getDouble("preco"));
        carro.setCor(db.getString("cor"));
        carro.setDataCompra(db.getDate("data_compra"));

        Marca marca = new Marca(db.getInt("marca_id"));
        if (fromList) {
            // No listAll, o nome da marca já vem do JOIN
            marca.setNome(db.getString("marca_nome"));
        } else {
            // No findById, buscamos a marca separadamente
            MarcaDAO marcaDAO = DAOFactory.createDAO(MarcaDAO.class);
            marca = marcaDAO.findById(marca.getId());
        }
        carro.setMarca(marca);
        return carro;
    }
}