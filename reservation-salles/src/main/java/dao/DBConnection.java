package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // Lus depuis les variables d'environnement (production) ; valeurs locales par défaut
    private static final String URL = env("DB_URL",
            "jdbc:mysql://localhost:3306/reservation_salles?useSSL=false&serverTimezone=UTC");
    private static final String USER = env("DB_USER", "root");
    private static final String PASSWORD = env("DB_PASSWORD", "1234");

    private static String env(String key, String defaultValue) {
        String v = System.getenv(key);
        return (v == null || v.isBlank()) ? defaultValue : v;
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✔ Connexion réussie à MySQL !");
        } catch (Exception e) {
            System.out.println("❌ Erreur de connexion : " + e.getMessage());
        }
        return connection;
    }
}
