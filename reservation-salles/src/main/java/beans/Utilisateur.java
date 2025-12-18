package beans;

public class Utilisateur {
    private int id;
    private String nom;
    private String prenom;
    private String email;
    private String password;
    private String role; // "user" ou "admin"
    
    // ✅ NOUVEAUX CHAMPS POUR LE CLUB
    private String nomClub;
    private String descriptionClub;
    private String logoClub;

    // Constructeur vide
    public Utilisateur() {}

    // Constructeur complet
    public Utilisateur(int id, String nom, String prenom, String email, 
                       String password, String role, String nomClub, 
                       String descriptionClub, String logoClub) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.password = password;
        this.role = role;
        this.nomClub = nomClub;
        this.descriptionClub = descriptionClub;
        this.logoClub = logoClub;
    }

    // Getters
    public int getId() { return id; }
    public String getNom() { return nom; }
    public String getPrenom() { return prenom; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getNomClub() { return nomClub; }
    public String getDescriptionClub() { return descriptionClub; }
    public String getLogoClub() { return logoClub; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setNom(String nom) { this.nom = nom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setNomClub(String nomClub) { this.nomClub = nomClub; }
    public void setDescriptionClub(String descriptionClub) { this.descriptionClub = descriptionClub; }
    public void setLogoClub(String logoClub) { this.logoClub = logoClub; }
}
