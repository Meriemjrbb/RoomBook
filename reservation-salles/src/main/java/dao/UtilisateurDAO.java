package dao;

import beans.Utilisateur;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtilisateurDAO {

    // ================================
    // LOGIN
    // ================================
    public Utilisateur login(String email, String password) {
        // ✅ AJOUTER les colonnes club dans le SELECT
        String sql = "SELECT id, nom, prenom, email, password, role, nomClub, descriptionClub, logoClub FROM utilisateur WHERE email=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Vérifier le password
                if (rs.getString("password").equals(password)) {
                    Utilisateur u = new Utilisateur();
                    u.setId(rs.getInt("id"));
                    u.setNom(rs.getString("nom"));
                    u.setPrenom(rs.getString("prenom"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRole(rs.getString("role"));
                    // ✅ AJOUTER les infos du club
                    u.setNomClub(rs.getString("nomClub"));
                    u.setDescriptionClub(rs.getString("descriptionClub"));
                    u.setLogoClub(rs.getString("logoClub"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================
    // GET ALL
    // ================================
    public List<Utilisateur> getAll() {
        List<Utilisateur> liste = new ArrayList<>();
        // ✅ AJOUTER les colonnes club
        String sql = "SELECT id, nom, prenom, email, password, role, nomClub, descriptionClub, logoClub FROM utilisateur";

        try (Connection cnx = DBConnection.getConnection();
                Statement st = cnx.createStatement();
                ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setId(rs.getInt("id"));
                u.setNom(rs.getString("nom"));
                u.setPrenom(rs.getString("prenom"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                // ✅ AJOUTER infos club
                u.setNomClub(rs.getString("nomClub"));
                u.setDescriptionClub(rs.getString("descriptionClub"));
                u.setLogoClub(rs.getString("logoClub"));
                liste.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

    // ================================
    // GET BY ID
    // ================================
    public Utilisateur getById(int id) {
        // ✅ AJOUTER les colonnes club
        String sql = "SELECT id, nom, prenom, email, password, role, nomClub, descriptionClub, logoClub FROM utilisateur WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Utilisateur u = new Utilisateur();
                u.setId(rs.getInt("id"));
                u.setNom(rs.getString("nom"));
                u.setPrenom(rs.getString("prenom"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                // ✅ AJOUTER infos club
                u.setNomClub(rs.getString("nomClub"));
                u.setDescriptionClub(rs.getString("descriptionClub"));
                u.setLogoClub(rs.getString("logoClub"));
                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================
    // ADD USER
    // ================================
    public void add(Utilisateur u) {
        // ✅ AJOUTER les colonnes club
        String sql = "INSERT INTO utilisateur (nom, prenom, email, password, role, nomClub, descriptionClub, logoClub) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, u.getNom());
            ps.setString(2, u.getPrenom());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getNomClub());
            ps.setString(7, u.getDescriptionClub());
            ps.setString(8, u.getLogoClub());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================================
    // UPDATE USER
    // ================================
    public void update(Utilisateur u) {
        // ✅ AJOUTER les colonnes club
        String sql = "UPDATE utilisateur SET nom=?, prenom=?, email=?, password=?, role=?, nomClub=?, descriptionClub=?, logoClub=? WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, u.getNom());
            ps.setString(2, u.getPrenom());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getPassword());
            ps.setString(5, u.getRole());
            ps.setString(6, u.getNomClub());
            ps.setString(7, u.getDescriptionClub());
            ps.setString(8, u.getLogoClub());
            ps.setInt(9, u.getId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================================
    // DELETE USER
    // ================================
    public boolean delete(int id) {
        String sql = "DELETE FROM utilisateur WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Mettre à jour le profil du club
     */
    public void updateClubProfile(int userId, String nomClub, String descriptionClub, String logoClub) {
        String sql = "UPDATE utilisateur SET nomClub=?, descriptionClub=?, logoClub=? WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, nomClub);
            ps.setString(2, descriptionClub);
            ps.setString(3, logoClub);
            ps.setInt(4, userId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
