package model;

import java.util.Date;

public class Carro {
    private int id;
    private String modelo;
    private int ano;
    private double preco;
    private String cor;
    private Date dataCompra;
    private Marca marca; // Relacionamento com Marca

    public Carro() {}

    public Carro(int id) {
        this.id = id;
    }
    
    // Getters e Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }
    public int getAno() { return ano; }
    public void setAno(int ano) { this.ano = ano; }
    public double getPreco() { return preco; }
    public void setPreco(double preco) { this.preco = preco; }
    public String getCor() { return cor; }
    public void setCor(String cor) { this.cor = cor; }
    public Date getDataCompra() { return dataCompra; }
    public void setDataCompra(Date dataCompra) { this.dataCompra = dataCompra; }
    public Marca getMarca() { return marca; }
    public void setMarca(Marca marca) { this.marca = marca; }
}