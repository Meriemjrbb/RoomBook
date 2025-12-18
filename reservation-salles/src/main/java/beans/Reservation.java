package beans;

import java.sql.Time;
import java.util.Date;

public class Reservation {

    private int id;
    private Date dateReservation; // java.sql.Date

    public Date getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(Date dateReservation) {
        this.dateReservation = dateReservation;
    }

    public Time getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(Time heureDebut) {
        this.heureDebut = heureDebut;
    }

    public Time getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(Time heureFin) {
        this.heureFin = heureFin;
    }

    private Time heureDebut; // java.sql.Time
    private Time heureFin; // java.sql.Time

    private String status; // "en attente" | "validée" | "annulée" (peut être mis par l'admin ou
                           // l'utilisateur)

    private int utilisateurId; // FK
    private int salleId; // FK

    // Constructeur vide
    public Reservation() {
    }

    // Constructeur complet
    public Reservation(int id, Date dateReservation, Time heureDebut, Time heureFin, String status, int utilisateurId,
            int salleId) {
        this.id = id;
        this.dateReservation = dateReservation;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.status = status;
        this.utilisateurId = utilisateurId;
        this.salleId = salleId;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUtilisateurId() {
        return utilisateurId;
    }

    public void setUtilisateurId(int utilisateurId) {
        this.utilisateurId = utilisateurId;
    }

    public int getSalleId() {
        return salleId;
    }

    public void setSalleId(int salleId) {
        this.salleId = salleId;
    }

    @Override
    public String toString() {
        return "Reservation [id=" + id + ", dateReservation=" + dateReservation + ", heureDebut=" + heureDebut
                + ", heureFin=" + heureFin + ", status=" + status + ", utilisateurId=" + utilisateurId + ", salleId="
                + salleId + "]";
    }

}
