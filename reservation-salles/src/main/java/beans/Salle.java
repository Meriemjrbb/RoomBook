package beans;

public class Salle {

    private int id;
    private String nom;
    private int capacite;

    // Constructeur vide
    public Salle() {}

    // Constructeur complet
    public Salle(int id, String nom, int capacite) {
        this.id = id;
        this.nom = nom;
        this.capacite = capacite;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public int getCapacite() { return capacite; }
    public void setCapacite(int capacite) { this.capacite = capacite; }

    @Override
    public String toString() {
        return nom + " (capacité : " + capacite + ")";
    }
}
