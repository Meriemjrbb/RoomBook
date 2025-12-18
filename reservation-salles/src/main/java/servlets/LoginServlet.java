package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.UtilisateurDAO;
import beans.Utilisateur;
import utils.ValidationUtil;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ✅ Si déjà connecté, rediriger vers l'accueil
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        if (user != null) {
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("accueil");
            }
            return;
        }
        
        // Sinon afficher la page login
        request.getServletContext()
                .getRequestDispatcher("/WEB-INF/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Email et mot de passe requis !");
            request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/login.jsp")
                    .forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Format d'email invalide !");
            request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/login.jsp")
                    .forward(request, response);
            return;
        }

        Utilisateur user = utilisateurDAO.login(email, password);

        if (user == null) {
            request.setAttribute("error", "Email ou mot de passe incorrect !");
            request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/login.jsp")
                    .forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(1800); // 30 minutes

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("accueil");
            }
        }
    }
}
