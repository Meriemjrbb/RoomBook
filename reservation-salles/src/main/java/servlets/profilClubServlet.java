package servlets;

import java.io.IOException;
import java.nio.file.Paths;

import beans.Utilisateur;
import dao.UtilisateurDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/profil-club")
@MultipartConfig(maxFileSize = 5242880) // 5MB
public class profilClubServlet extends HttpServlet {

    private UtilisateurDAO utilisateurDAO = new UtilisateurDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        if (user == null || user.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }
        
        request.getServletContext().getRequestDispatcher("/WEB-INF/profilClub.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Utilisateur user = (Utilisateur) request.getSession().getAttribute("user");
        if (user == null || user.getRole().equals("admin")) {
            response.sendRedirect("login");
            return;
        }

        String nomClub = request.getParameter("nomClub");
        String descriptionClub = request.getParameter("descriptionClub");

        if (nomClub == null || nomClub.isEmpty()) {
            request.setAttribute("error", "Le nom du club est obligatoire !");
            request.getServletContext().getRequestDispatcher("/WEB-INF/profilClub.jsp").forward(request, response);
            return;
        }

        try {
            Part filePart = request.getPart("logoClub");
            String logoClub = user.getLogoClub(); // Conserver l'ancien logo par défaut

            // Si un fichier est uploadé
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/assets/club-logos");
                
                // Créer dossier s'il n'existe pas
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Générer un nom unique
                String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadPath + "/" + uniqueFileName);
                logoClub = uniqueFileName;
            }

            // Mettre à jour en BD
            user.setNomClub(nomClub);
            user.setDescriptionClub(descriptionClub);
            user.setLogoClub(logoClub);

            // Sauvegarder (tu dois ajouter updateProfile() dans UtilisateurDAO)
            utilisateurDAO.updateClubProfile(user.getId(), nomClub, descriptionClub, logoClub);

            // Mettre à jour la session
            request.getSession().setAttribute("user", user);

            request.setAttribute("success", "Profil club mis à jour avec succès !");
            request.getServletContext().getRequestDispatcher("/WEB-INF/profilClub.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur : " + e.getMessage());
            request.getServletContext().getRequestDispatcher("/WEB-INF/profilClub.jsp").forward(request, response);
        }
    }
}
