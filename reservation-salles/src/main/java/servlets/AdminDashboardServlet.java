package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import beans.Utilisateur;
import dao.UtilisateurDAO;
import dao.SalleDAO;
import dao.ReservationDAO;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
    private SalleDAO salleDAO = new SalleDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        // Récupérer les statistiques
        int totalUsers = utilisateurDAO.getAll().size();
        int totalSalles = salleDAO.getAll().size();
        int totalReservations = reservationDAO.getAll().size();

        // Compter les réservations par statut
        int reservationsEnAttente = 0;
        int reservationsValidees = 0;
        int reservationsAnnulees = 0;

        for (var reservation : reservationDAO.getAll()) {
            String status = reservation.getStatus();
            if ("en attente".equals(status)) {
                reservationsEnAttente++;
            } else if ("validée".equals(status)) {
                reservationsValidees++;
            } else if ("annulée".equals(status)) {
                reservationsAnnulees++;
            }
        }

        // Passer les statistiques à la JSP
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalSalles", totalSalles);
        request.setAttribute("totalReservations", totalReservations);
        request.setAttribute("reservationsEnAttente", reservationsEnAttente);
        request.setAttribute("reservationsValidees", reservationsValidees);
        request.setAttribute("reservationsAnnulees", reservationsAnnulees);

        request.getServletContext().getRequestDispatcher("/WEB-INF/dashboard.jsp").forward(request, response);

    }
}
