<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) request.getSession().getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } Utilisateur
            editUser=(Utilisateur) request.getAttribute("user"); boolean isEdit=editUser !=null; %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <%= isEdit ? "Modifier" : "Ajouter" %> un Utilisateur
                </title>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>
                        <%= isEdit ? "Modification" : "Ajout" %> d'Utilisateur - Management
                    </title>
                    <style>
                        :root {
                            --bg: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            --surface: #ffffff;
                            --text: #1a202c;
                            --text-light: #718096;
                            --border: #e2e8f0;
                            --primary: #3857ae;
                            --primary2: #1d2e57;
                            --shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                            background: var(--bg);
                            color: var(--text);
                            min-height: 100vh;
                        }

                        .page-wrapper {
                            display: flex;
                            justify-content: center;
                            padding: 60px 20px;
                        }

                        .form-container {
                            background: var(--surface);
                            padding: 50px;
                            border-radius: 30px;
                            box-shadow: var(--shadow);
                            width: 100%;
                            max-width: 700px;
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            animation: fadeIn 0.6s ease-out;
                        }

                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                                transform: translateY(20px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .header {
                            text-align: center;
                            margin-bottom: 45px;
                        }

                        .header-icon {
                            width: 80px;
                            height: 80px;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            border-radius: 22px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: white;
                            font-size: 35px;
                            margin: 0 auto 20px;
                            box-shadow: 0 10px 25px rgba(56, 87, 174, 0.3);
                        }

                        .header h1 {
                            font-size: 28px;
                            font-weight: 800;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            -webkit-background-clip: text;
                            background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        .section-title {
                            font-size: 14px;
                            font-weight: 800;
                            color: #94a3b8;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                            margin: 35px 0 20px;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .section-title::after {
                            content: "";
                            flex-grow: 1;
                            height: 2px;
                            background: #f1f5f9;
                        }

                        .form-grid {
                            display: grid;
                            grid-template-columns: 1fr 1fr;
                            gap: 20px;
                        }

                        .form-group {
                            margin-bottom: 22px;
                        }

                        .form-group.full {
                            grid-column: span 2;
                        }

                        label {
                            display: block;
                            margin-bottom: 10px;
                            color: #1e293b;
                            font-weight: 700;
                            font-size: 14px;
                            display: flex;
                            align-items: center;
                            gap: 8px;
                        }

                        input,
                        select,
                        textarea {
                            width: 100%;
                            padding: 16px;
                            border: 2px solid #f1f5f9;
                            border-radius: 12px;
                            font-size: 15px;
                            font-family: inherit;
                            background: #f8fafc;
                            transition: all 0.3s ease;
                        }

                        input:focus,
                        select:focus,
                        textarea:focus {
                            outline: none;
                            border-color: var(--primary);
                            background: white;
                            box-shadow: 0 0 0 4px rgba(56, 87, 174, 0.1);
                        }

                        .club-section {
                            display: none;
                            background: #f8fafc;
                            padding: 30px;
                            border-radius: 20px;
                            margin-top: 10px;
                            border: 2px dashed #e2e8f0;
                            animation: slideDown 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        }

                        .club-section.show {
                            display: block;
                        }

                        @keyframes slideDown {
                            from {
                                opacity: 0;
                                transform: scaleY(0.9);
                            }

                            to {
                                opacity: 1;
                                transform: scaleY(1);
                            }
                        }

                        .btn-submit {
                            width: 100%;
                            padding: 20px;
                            background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                            color: white;
                            border: none;
                            border-radius: 15px;
                            font-weight: 800;
                            font-size: 16px;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            box-shadow: 0 10px 25px rgba(56, 87, 174, 0.4);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 12px;
                            margin-top: 40px;
                        }

                        .btn-submit:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 15px 35px rgba(56, 87, 174, 0.5);
                        }

                        .alert {
                            padding: 20px;
                            border-radius: 15px;
                            margin-bottom: 30px;
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            font-weight: 600;
                            font-size: 14px;
                        }

                        .alert-error {
                            background: #fef2f2;
                            color: #991b1b;
                            border: 1px solid #fee2e2;
                        }

                        .back-link {
                            display: inline-flex;
                            align-items: center;
                            gap: 8px;
                            color: var(--text-light);
                            text-decoration: none;
                            font-weight: 600;
                            margin-top: 30px;
                            width: 100%;
                            justify-content: center;
                            transition: color 0.3s;
                            font-size: 14px;
                        }

                        .back-link:hover {
                            color: var(--primary);
                        }

                        .file-upload-wrapper {
                            position: relative;
                            background: white;
                            padding: 20px;
                            border: 2px solid #f1f5f9;
                            border-radius: 12px;
                            text-align: center;
                        }

                        .file-preview {
                            margin-top: 15px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            flex-direction: column;
                            border-top: 1px solid #f1f5f9;
                            padding-top: 15px;
                        }

                        .file-preview img {
                            width: 80px;
                            height: 80px;
                            border-radius: 12px;
                            object-fit: cover;
                            border: 3px solid white;
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                        }

                        @media (max-width: 600px) {
                            .form-grid {
                                grid-template-columns: 1fr;
                            }

                            .form-group.full {
                                grid-column: auto;
                            }
                        }
                    </style>
                </head>

            <body>
                <jsp:include page="navbar.jsp" />

                <div class="page-wrapper">
                    <div class="form-container">
                        <div class="header">
                            <div class="header-icon">
                                <i class="fas <%= isEdit ? " fa-user-pen" : "fa-user-plus" %>"></i>
                            </div>
                            <h1>
                                <%= isEdit ? "Actualiser le Profil" : "Créer un Nouveau Responsable" %>
                            </h1>
                            <p style="color: #64748b; font-size: 14px; margin-top: 10px;">Enregistrement des accès
                                institutionnels</p>
                        </div>

                        <% if (request.getAttribute("error") !=null) { %>
                            <div class="alert alert-error">
                                <i class="fas fa-triangle-exclamation"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                            <% } %>

                                <form method="POST" action="users" enctype="multipart/form-data">
                                    <% if (isEdit) { %>
                                        <input type="hidden" name="id" value="<%= editUser.getId() %>">
                                        <% } %>

                                            <div class="section-title"><i class="fas fa-id-card"></i> Identité & Accès
                                            </div>

                                            <div class="form-grid">
                                                <div class="form-group">
                                                    <label for="prenom">Prénom</label>
                                                    <input type="text" id="prenom" name="prenom" placeholder="Ex: Karim"
                                                        value="<%= isEdit ? editUser.getPrenom() : "" %>" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="nom">Nom de famille</label>
                                                    <input type="text" id="nom" name="nom" placeholder="Ex: Bennani"
                                                        value="<%= isEdit ? editUser.getNom() : "" %>" required>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label for="email"><i class="fas fa-envelope"></i> Email
                                                    Institutionnel</label>
                                                <input type="email" id="email" name="email"
                                                    placeholder="nom.prenom@universite.ma"
                                                    value="<%= isEdit ? editUser.getEmail() : "" %>" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="password"><i class="fas fa-lock"></i> Mot de passe</label>
                                                <input type="password" id="password" name="password"
                                                    placeholder="<%= isEdit ? " •••••••• (inchangé si vide)"
                                                    : "Définir un mot de passe sécurisé" %>"
                                                <%= !isEdit ? "required" : "" %>>
                                            </div>

                                            <div class="form-group">
                                                <label for="role"><i class="fas fa-shield-user"></i> Niveau
                                                    d'Accès</label>
                                                <select id="role" name="role" required onchange="toggleClubSection()">
                                                    <option value="">Sélectionner une responsabilité</option>
                                                    <option value="user" <%=isEdit && editUser.getRole().equals("user")
                                                        ? "selected" : "" %>>Président de Club (Espace dédié)</option>
                                                    <option value="admin" <%=isEdit &&
                                                        editUser.getRole().equals("admin") ? "selected" : "" %>
                                                        >Administrateur Système</option>
                                                </select>
                                            </div>

                                            <!-- SECTION CLUB DYNAMIQUE -->
                                            <div class="club-section" id="clubSection">
                                                <div class="section-title"><i class="fas fa-university"></i> Identité du
                                                    Club</div>

                                                <div class="form-group">
                                                    <label for="nomClub">Dénomination officielle</label>
                                                    <input type="text" id="nomClub" name="nomClub"
                                                        placeholder="Ex: Club Robotique, BDE..."
                                                        value="<%= isEdit && editUser.getNomClub() != null ? editUser.getNomClub() : "" %>">
                                                </div>

                                                <div class="form-group">
                                                    <label for="descriptionClub">Mission du club</label>
                                                    <textarea id="descriptionClub" name="descriptionClub" rows="3"
                                                        placeholder="Décrivez brièvement les objectifs du club..."><%= isEdit && editUser.getDescriptionClub() != null ? editUser.getDescriptionClub().trim() : "" %></textarea>
                                                </div>

                                                <div class="form-group">
                                                    <label for="logoClub">Emblème du Club</label>
                                                    <div class="file-upload-wrapper">
                                                        <input type="file" id="logoClub" name="logoClub"
                                                            accept="image/*">
                                                        <p style="font-size: 11px; color: #94a3b8; margin-top: 10px;">
                                                            Formats: PNG, JPG (Max 5MB)</p>

                                                        <% if (isEdit && editUser.getLogoClub() !=null &&
                                                            !editUser.getLogoClub().isEmpty()) { %>
                                                            <div class="file-preview">
                                                                <span
                                                                    style="font-size: 12px; font-weight: 700; margin-bottom: 10px; color: #64748b;">Logo
                                                                    actuel :</span>
                                                                <img src="assets/club-logos/<%= editUser.getLogoClub() %>"
                                                                    alt="Current Logo">
                                                            </div>
                                                            <% } %>
                                                    </div>
                                                </div>
                                            </div>

                                            <button type="submit" class="btn-submit">
                                                <i class="fas <%= isEdit ? " fa-floppy-disk" : "fa-user-check" %>"></i>
                                                <%= isEdit ? "Sauvegarder les modifications" : "Finaliser l'inscription"
                                                    %>
                                            </button>
                                </form>

                                <a href="users" class="back-link">
                                    <i class="fas fa-arrow-left"></i> Retour à l'annuaire
                                </a>
                    </div>
                </div>

                <script>
                    function toggleClubSection() {
                        const role = document.getElementById('role').value;
                        const clubSection = document.getElementById('clubSection');
                        if (role === 'user') {
                            clubSection.classList.add('show');
                        } else {
                            clubSection.classList.remove('show');
                        }
                    }
                    document.addEventListener('DOMContentLoaded', toggleClubSection);
                </script>
            </body>

            <script>
                /**
                 * Affiche/masque la section club selon le rôle sélectionné
                 */
                function toggleClubSection() {
                    const role = document.getElementById('role').value;
                    const clubSection = document.getElementById('clubSection');

                    if (role === 'user') {
                        // Afficher la section club
                        clubSection.classList.add('show');
                    } else {
                        // Masquer la section club
                        clubSection.classList.remove('show');
                    }
                }

                // Initialiser au chargement de la page
                document.addEventListener('DOMContentLoaded', function () {
                    toggleClubSection();
                });
            </script>
            </body>

            </html>