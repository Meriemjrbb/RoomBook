package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import dao.ReservationDAO;
import dao.SalleDAO;
import beans.Reservation;
import beans.Utilisateur;
import beans.Salle;
import utils.ValidationUtil;

import java.util.List;

@WebServlet("/reservation-salle")
public class ReservationSalleServlet extends HttpServlet {

    ReservationDAO reservationDAO = new ReservationDAO();
    SalleDAO salleDAO = new SalleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Afficher la liste des salles avec formulaires de réservation
        List<Salle> salles = salleDAO.getAll();
        request.setAttribute("salles", salles);

        request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int salleId = Integer.parseInt(request.getParameter("salleId"));
            String dateStr = request.getParameter("date");
            String heureDebutStr = request.getParameter("heureDebut");
            String heureFinStr = request.getParameter("heureFin");

            // Validation
            if (dateStr == null || dateStr.isEmpty() ||
                    heureDebutStr == null || heureDebutStr.isEmpty() ||
                    heureFinStr == null || heureFinStr.isEmpty()) {

                List<Salle> salles = salleDAO.getAll();
                request.setAttribute("salles", salles);
                request.setAttribute("error", "Tous les champs sont obligatoires !");
                request.setAttribute("errorSalleId", salleId);
                request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
                return;
            }

            Date date = Date.valueOf(dateStr);
            Time heureDebut = Time.valueOf(heureDebutStr + ":00");
            Time heureFin = Time.valueOf(heureFinStr + ":00");

            // Vérifier que heure fin > heure début
            if (!ValidationUtil.isValidTimeSlot(heureDebut, heureFin)) {
                List<Salle> salles = salleDAO.getAll();
                request.setAttribute("salles", salles);
                request.setAttribute("error", "L'heure de fin doit être après l'heure de début !");
                request.setAttribute("errorSalleId", salleId);
                request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
                return;
            }

            // Vérifier que la salle est disponible
            boolean salleDisponible = reservationDAO.checkDisponibilite(salleId, date, heureDebut, heureFin);

            if (!salleDisponible) {
                List<Salle> salles = salleDAO.getAll();
                request.setAttribute("salles", salles);
                request.setAttribute("error", "Cette salle n'est pas disponible à ce créneau !");
                request.setAttribute("errorSalleId", salleId);
                request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
                return;
            }

            // ✅ NOUVELLE RÈGLE MÉTIER : Vérifier que l'utilisateur n'a pas déjà une
            // réservation à ce créneau
            boolean userDisponible = reservationDAO.checkUserAvailability(user.getId(), date, heureDebut, heureFin);

            if (!userDisponible) {
                List<Salle> salles = salleDAO.getAll();
                request.setAttribute("salles", salles);
                request.setAttribute("error",
                        "Vous avez déjà une réservation à ce créneau ! Un utilisateur ne peut réserver qu'une salle à la fois.");
                request.setAttribute("errorSalleId", salleId);
                request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
                return;
            }

            // Créer la réservation
            Reservation r = new Reservation();
            r.setDateReservation(date);
            r.setHeureDebut(heureDebut);
            r.setHeureFin(heureFin);
            r.setStatus("en attente");
            r.setUtilisateurId(user.getId());
            r.setSalleId(salleId);

            if (reservationDAO.addReservation(r)) {
                request.setAttribute("success", "Réservation effectuée avec succès !");
            } else {
                request.setAttribute("error", "Erreur lors de la réservation !");
            }

            // Retourner à la liste
            List<Salle> salles = salleDAO.getAll();
            request.setAttribute("salles", salles);
            request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            List<Salle> salles = salleDAO.getAll();
            request.setAttribute("salles", salles);
            request.setAttribute("error", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/listeSalles.jsp").forward(request, response);
        }
    }
}
