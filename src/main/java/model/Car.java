package model;

public class Car {
    private int id;
    private String model;
    private int year;
    private double price;
    private String color;
    private Company company; // Relacionamento com a entidade Company

    public Car() {
        this(0);
    }

    public Car(int id) {
        this.id = id;
        this.model = "";
        this.year = 0;
        this.price = 0.0;
        this.color = "";
        this.company = null;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    @Override
    public String toString() {
        return "Car [id=" + id + ", model=" + model + ", year=" + year + ", price=" + price + ", color=" + color + ", company=" + (company != null ? company.getName() : "N/A") + "]";
    }
}