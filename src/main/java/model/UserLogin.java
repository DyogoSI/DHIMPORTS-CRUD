package model;

public class UserLogin {
    private int id;
    private String username;
    private String password; // Em um sistema real, use hash para senhas!
    private String role; // Ex: admin, user

    public UserLogin() {
        this(0);
    }

    public UserLogin(int id) {
        this.id = id;
        this.username = "";
        this.password = "";
        this.role = "user";
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}