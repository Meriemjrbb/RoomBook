package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/reservation_salles?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; 
    private static final String PASSWORD = "1234"; // mets ton mot de passe si tu en as

    public static Connection getConnection() {
        Connection connection = null;

        try {
            // Charger le driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Obtenir la connexion
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✔ Connexion réussie à MySQL !");
        } 
        catch (Exception e) {
            System.out.println("❌ Erreur de connexion : " + e.getMessage());
        }

        return connection;
    }
}