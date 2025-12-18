package dao;

import beans.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    // ================================
    // AJOUTER RÉSERVATION
    // ================================
    public boolean addReservation(Reservation r) {
        String sql = "INSERT INTO reservation (date_reservation, heure_debut, heure_fin, status, utilisateur_id, salle_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setDate(1, (Date) r.getDateReservation());
            ps.setTime(2, r.getHeureDebut());
            ps.setTime(3, r.getHeureFin());
            ps.setString(4, r.getStatus());
            ps.setInt(5, r.getUtilisateurId());
            ps.setInt(6, r.getSalleId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Vérifier que l'utilisateur n'a pas déjà une réservation sur ce créneau
     * Règle métier : Un utilisateur ne peut réserver qu'une salle à la fois pour un
     * créneau donné
     */
    public boolean checkUserAvailability(int userId, Date date, Time debut, Time fin) {
        String sql = "SELECT * FROM reservation " +
                "WHERE utilisateur_id=? " +
                "AND date_reservation=? " +
                "AND status != 'annulée' " +
                "AND ( (heure_debut < ? AND heure_fin > ?) " +
                "OR (heure_debut < ? AND heure_fin > ?) " +
                "OR (heure_debut >= ? AND heure_fin <= ?) )";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setDate(2, date);
            ps.setTime(3, fin);
            ps.setTime(4, debut);
            ps.setTime(5, debut);
            ps.setTime(6, fin);
            ps.setTime(7, debut);
            ps.setTime(8, fin);

            ResultSet rs = ps.executeQuery();
            return !rs.next(); // true si l'utilisateur est libre à ce créneau

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================================
    // VERIFIER DISPONIBILITE
    // ================================
    public boolean checkDisponibilite(int salleId, Date date, Time debut, Time fin) {

        String sql = "SELECT * FROM reservation " +
                "WHERE salle_id=? " +
                "AND date_reservation=? " +
                "AND ( (heure_debut < ? AND heure_fin > ?) " + // chevauchement
                "OR (heure_debut < ? AND heure_fin > ?) " +
                "OR (heure_debut >= ? AND heure_fin <= ?) )";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, salleId);
            ps.setDate(2, date);

            // chevauchement
            ps.setTime(3, fin);
            ps.setTime(4, debut);

            ps.setTime(5, debut);
            ps.setTime(6, fin);

            ps.setTime(7, debut);
            ps.setTime(8, fin);

            ResultSet rs = ps.executeQuery();

            // si une ligne existe → NON disponible
            return !rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================================
    // LISTER TOUTES LES RÉSERVATIONS
    // ================================
    public List<Reservation> getAll() {
        List<Reservation> liste = new ArrayList<>();

        String sql = "SELECT * FROM reservation ORDER BY date_reservation DESC, heure_debut ASC";

        try (Connection cnx = DBConnection.getConnection();
                Statement st = cnx.createStatement();
                ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                liste.add(extractReservation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return liste;
    }

    // ================================
    // RÉSERVATIONS D’UN UTILISATEUR
    // ================================
    public List<Reservation> getByUser(int userId) {
        List<Reservation> liste = new ArrayList<>();

        String sql = "SELECT * FROM reservation WHERE utilisateur_id=? ORDER BY date_reservation DESC";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                liste.add(extractReservation(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return liste;
    }

    // ================================
    // GET BY ID
    // ================================
    public Reservation getById(int id) {
        String sql = "SELECT * FROM reservation WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractReservation(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================
    // METTRE À JOUR STATUT
    // ================================
    public boolean updateStatus(int id, String newStatus) {
        String sql = "UPDATE reservation SET status=? WHERE id=?";

        try (Connection cnx = DBConnection.getConnection();
                PreparedStatement ps = cnx.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================================
    // Helper: Extraction bean
    // ================================
    private Reservation extractReservation(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();

        r.setId(rs.getInt("id"));

        r.setDateReservation(rs.getDate("date_reservation"));
        r.setHeureDebut(rs.getTime("heure_debut"));
        r.setHeureFin(rs.getTime("heure_fin"));

        r.setStatus(rs.getString("status"));
        r.setUtilisateurId(rs.getInt("utilisateur_id"));
        r.setSalleId(rs.getInt("salle_id"));

        return r;
    }
}
