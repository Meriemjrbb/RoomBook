package dao;


import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        Connection cnx = DBConnection.getConnection();

        if (cnx != null) {
            System.out.println("Connexion OK !");
        } else {
            System.out.println("Connexion échouée !");
        }
    }
}

