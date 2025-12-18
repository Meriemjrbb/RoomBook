package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import dao.ReservationDAO;
import dao.SalleDAO;
import beans.Reservation;
import beans.Salle;
import beans.Utilisateur;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();
    private SalleDAO salleDAO = new SalleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            List<Reservation> liste = reservationDAO.getByUser(user.getId());
            request.setAttribute("reservations", liste);
            request.getRequestDispatcher("/WEB-INF/mesReservations.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            reservationDAO.updateStatus(id, "annulée");
            response.sendRedirect("reservations");
        } else if (action.equals("add")) {
            request.getRequestDispatcher("/WEB-INF/reserverSalle.jsp").forward(request, response);
        } else if (action.equals("check")) {
            // Étape 2 : vérifier disponibilité des salles
            try {
                String dateStr = request.getParameter("date");
                String debutStr = request.getParameter("heureDebut");
                String finStr = request.getParameter("heureFin");

                Date date = Date.valueOf(dateStr);
                Time heureDebut = Time.valueOf(debutStr + ":00");
                Time heureFin = Time.valueOf(finStr + ":00");

                if (!heureFin.after(heureDebut)) {
                    request.setAttribute("erreur", "L'heure de fin doit être > heure début.");
                    request.getRequestDispatcher("/WEB-INF/reserverSalle.jsp").forward(request, response);
                    return;
                }

                List<Salle> disponibles = salleDAO.getAvailableSalles(date, heureDebut, heureFin);

                request.setAttribute("date", dateStr);
                request.setAttribute("heureDebut", debutStr);
                request.setAttribute("heureFin", finStr);
                request.setAttribute("sallesDisponibles", disponibles);

                request.getRequestDispatcher("/WEB-INF/reserverSalle.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("erreur", "Format incorrect.");
                request.getRequestDispatcher("/WEB-INF/reserverSalle.jsp").forward(request, response);
            }
        }
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
            String debutStr = request.getParameter("heureDebut");
            String finStr = request.getParameter("heureFin");

            Date date = Date.valueOf(dateStr);
            Time heureDebut = Time.valueOf(debutStr + ":00");
            Time heureFin = Time.valueOf(finStr + ":00");

            Reservation r = new Reservation();
            r.setDateReservation(date);
            r.setHeureDebut(heureDebut);
            r.setHeureFin(heureFin);
            r.setStatus("en attente");
            r.setUtilisateurId(user.getId());
            r.setSalleId(salleId);

            reservationDAO.addReservation(r);

            response.sendRedirect("reservations");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur lors de l’enregistrement.");
            request.getRequestDispatcher("/WEB-INF/reserverSalle.jsp").forward(request, response);
        }
    }
}
