package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

import dao.SalleDAO;
import beans.Salle;

@WebServlet("/salles")
public class SalleServlet extends HttpServlet {

    private SalleDAO salleDAO = new SalleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Salle> salles = salleDAO.getAll();
            request.setAttribute("salles", salles);
            request.getServletContext().getRequestDispatcher("/WEB-INF/gestionSalles.jsp").forward(request, response);
        }
        else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            salleDAO.deleteSalle(id);
            response.sendRedirect("salles");
        }
        else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Salle salle = salleDAO.getById(id);
            request.setAttribute("salle", salle);
            request.getServletContext().getRequestDispatcher("/WEB-INF/ajouterSalle.jsp").forward(request, response);
        }
        else if (action.equals("add")) {
        	request.getServletContext().getRequestDispatcher("/WEB-INF/ajouterSalle.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                ? Integer.parseInt(request.getParameter("id"))
                : 0;

        String nom = request.getParameter("nom");
        int capacite = Integer.parseInt(request.getParameter("capacite"));

        Salle salle = new Salle(id, nom, capacite);

        if (id == 0) {
            salleDAO.addSalle(salle);
        } else {
            salleDAO.updateSalle(salle);
        }

        response.sendRedirect("salles");
    }
}
