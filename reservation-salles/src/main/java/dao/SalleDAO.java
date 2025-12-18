package dao;



import beans.Salle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalleDAO {

    // ============================
    // LISTE DES SALLES
    // ============================
    public List<Salle> getAll() {
        List<Salle> salles = new ArrayList<>();

        String sql = "SELECT * FROM salle ORDER BY nom ASC";

        try (Connection cnx = DBConnection.getConnection();
             Statement st = cnx.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                salles.add(extractSalle(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return salles;
    }

    // ============================
    // CHERCHER SALLE PAR ID
    // ============================
    public Salle getById(int id) {
        Salle salle = null;

        String sql = "SELECT * FROM salle WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
             PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                salle = extractSalle(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return salle;
    }

    // ============================
    // AJOUTER UNE SALLE
    // ============================
    public boolean addSalle(Salle s) {
        String sql = "INSERT INTO salle (nom, capacite) VALUES (?, ?)";

        try (Connection cnx = DBConnection.getConnection();
             PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, s.getNom());
            ps.setInt(2, s.getCapacite());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ============================
    // MODIFIER UNE SALLE
    // ============================
    public boolean updateSalle(Salle s) {
        String sql = "UPDATE salle SET nom=?, capacite=? WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
             PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, s.getNom());
            ps.setInt(2, s.getCapacite());
            ps.setInt(3, s.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ============================
    // SUPPRIMER UNE SALLE
    // ============================
    public boolean deleteSalle(int id) {
        String sql = "DELETE FROM salle WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
             PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ============================
    // Helper : extraire un bean salle
    // ============================
    private Salle extractSalle(ResultSet rs) throws SQLException {
        Salle s = new Salle();

        s.setId(rs.getInt("id"));
        s.setNom(rs.getString("nom"));
        s.setCapacite(rs.getInt("capacite"));

        return s;
    }
    public List<Salle> getAvailableSalles(Date date, Time debut, Time fin) {
        List<Salle> salles = new ArrayList<>();

        String sql = """
            SELECT * FROM salle s 
            WHERE s.id NOT IN (
                SELECT salle_id FROM reservation 
                WHERE date_reservation = ?
                AND (
                        (heure_debut < ? AND heure_fin > ?)   -- chevauchement
                    OR  (heure_debut < ? AND heure_fin > ?)
                    OR  (heure_debut >= ? AND heure_fin <= ?)
                )
            )
            ORDER BY s.nom ASC
            """;

        try (Connection cnx = DBConnection.getConnection();
             PreparedStatement ps = cnx.prepareStatement(sql)) {

            // date
            ps.setDate(1, date);

            // chevauchement
            ps.setTime(2, fin);
            ps.setTime(3, debut);

            ps.setTime(4, debut);
            ps.setTime(5, fin);

            ps.setTime(6, debut);
            ps.setTime(7, fin);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                salles.add(extractSalle(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return salles;
    }

}

