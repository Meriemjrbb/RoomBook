package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import beans.Utilisateur;

@WebServlet("/accueil")
public class AccueilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        
       request.getServletContext().getRequestDispatcher("/WEB-INF/accueil.jsp").forward(request, response);
    }
}


