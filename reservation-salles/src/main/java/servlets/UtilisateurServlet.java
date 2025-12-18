package servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.nio.file.Paths;

import dao.UtilisateurDAO;
import beans.Utilisateur;
import utils.ValidationUtil;

@WebServlet("/users")
@MultipartConfig(maxFileSize = 5242880) // 5MB
public class UtilisateurServlet extends HttpServlet {

    private UtilisateurDAO dao = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur loggedUser = (Utilisateur) request.getSession().getAttribute("user");
        if (loggedUser == null || !loggedUser.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            request.setAttribute("users", dao.getAll());
            request.getServletContext()
                .getRequestDispatcher("/WEB-INF/gestionUtilisateurs.jsp")
                .forward(request, response);
        }
        else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.delete(id);
            response.sendRedirect("users");
        }
        else if (action.equals("add")) {
            request.getServletContext()
                .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                .forward(request, response);
        }
        else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Utilisateur u = dao.getById(id);
            request.setAttribute("user", u);
            request.getServletContext()
                .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur loggedUser = (Utilisateur) request.getSession().getAttribute("user");
        if (loggedUser == null || !loggedUser.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        try {
            int id = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            
            // ✅ NOUVEAUX CHAMPS POUR LE CLUB
            String nomClub = request.getParameter("nomClub");
            String descriptionClub = request.getParameter("descriptionClub");
            String logoClub = null;

            // Validation basique
            if (nom == null || nom.isEmpty() || prenom == null || prenom.isEmpty()) {
                request.setAttribute("error", "Nom et prénom sont obligatoires !");
                request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                    .forward(request, response);
                return;
            }

            if (!ValidationUtil.isValidEmail(email)) {
                request.setAttribute("error", "Email invalide !");
                request.getServletContext()
                    .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                    .forward(request, response);
                return;
            }

            // Créer l'utilisateur avec les nouvelles infos
            Utilisateur u = new Utilisateur(id, nom, prenom, email, password, role, nomClub, descriptionClub, logoClub);

            // ✅ GÉRER L'UPLOAD DU LOGO SI C'EST UN USER (PRÉSIDENT)
            if (role != null && role.equals("user")) {
                try {
                    Part filePart = request.getPart("logoClub");
                    if (filePart != null && filePart.getSize() > 0) {
                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        String uploadPath = getServletContext().getRealPath("/assets/club-logos");
                        
                        java.io.File uploadDir = new java.io.File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + "/" + uniqueFileName);
                        logoClub = uniqueFileName;
                        u.setLogoClub(logoClub);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (id == 0) {
                // Ajouter un nouvel utilisateur
                if (password == null || password.isEmpty()) {
                    request.setAttribute("error", "Le mot de passe est obligatoire pour un nouvel utilisateur !");
                    request.getServletContext()
                        .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                        .forward(request, response);
                    return;
                }
                dao.add(u);
            }
            else {
                // Mettre à jour un utilisateur existant
                Utilisateur existing = dao.getById(id);
                
                // Si pas de nouveau password, garder l'ancien
                if (password == null || password.isEmpty()) {
                    u.setPassword(existing.getPassword());
                }
                
                // Si pas de nouveau logo, garder l'ancien
                if (logoClub == null && existing.getLogoClub() != null) {
                    u.setLogoClub(existing.getLogoClub());
                }
                
                dao.update(u);
            }

            response.sendRedirect("users");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur : " + e.getMessage());
            request.getServletContext()
                .getRequestDispatcher("/WEB-INF/ajouterUtilisateur.jsp")
                .forward(request, response);
        }
    }
}
