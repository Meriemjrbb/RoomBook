package utils;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

public class ValidationUtil {
    
    /**
     * Valide un email
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) return false;
        return email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    /**
     * Valide un mot de passe (min 6 caractères)
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.isEmpty()) return false;
        return password.length() >= 6;
    }
    
    /**
     * Valide que l'heure de fin est après l'heure de début
     */
    public static boolean isValidTimeSlot(Time debut, Time fin) {
        if (debut == null || fin == null) return false;
        return fin.after(debut);
    }
    
    /**
     * Valide que la date n'est pas dans le passé
     */
    public static boolean isFutureDate(Date date) {
        if (date == null) return false;
        return date.after(new Date(System.currentTimeMillis()));
    }
    
    /**
     * Valide une capacité de salle
     */
    public static boolean isValidCapacity(int capacity) {
        return capacity > 0 && capacity <= 1000;
    }
    
    /**
     * Valide qu'un nom n'est pas vide
     */
    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.length() <= 100;
    }
}
