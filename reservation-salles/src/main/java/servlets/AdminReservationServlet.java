package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import dao.ReservationDAO;
import beans.Reservation;
import beans.Utilisateur;

@WebServlet("/adminReservations")
public class AdminReservationServlet extends HttpServlet {

    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        // Vérifier que c'est un admin
        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        // Vérifier les actions
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            // ✅ Admin annule une réservation
            int id = Integer.parseInt(request.getParameter("id"));
            reservationDAO.updateStatus(id, "annulée");
            response.sendRedirect("adminReservations");
            return;
        }

        if ("updateStatus".equals(action)) {
            // ✅ Admin modifie le statut d'une réservation
            int id = Integer.parseInt(request.getParameter("id"));
            String newStatus = request.getParameter("status");

            // Valider le statut
            if (newStatus != null && (newStatus.equals("en attente") ||
                    newStatus.equals("validée") || newStatus.equals("annulée"))) {
                reservationDAO.updateStatus(id, newStatus);
            }

            response.sendRedirect("adminReservations");
            return;
        }

        // Afficher toutes les réservations
        request.setAttribute("reservations", reservationDAO.getAll());
        request.getServletContext()
                .getRequestDispatcher("/WEB-INF/gestionReservations.jsp")
                .forward(request, response);
    }
}
