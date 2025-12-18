<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null ||
            user.getRole().equals("admin")) { response.sendRedirect("login"); return; } %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Mon Profil Club</title>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Identité du Club - Administration</title>
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
                            min-height: 100vh;
                            color: var(--text);
                        }

                        .container {
                            max-width: 750px;
                            margin: 60px auto;
                            background: var(--surface);
                            padding: 50px;
                            border-radius: 24px;
                            box-shadow: var(--shadow);
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
                            margin-bottom: 40px;
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

                        h1 {
                            font-size: 30px;
                            font-weight: 800;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            margin-bottom: 10px;
                        }

                        .subtitle {
                            color: var(--text-light);
                            font-size: 16px;
                        }

                        .form-group {
                            margin-bottom: 30px;
                        }

                        label {
                            display: block;
                            margin-bottom: 10px;
                            color: var(--text);
                            font-weight: 700;
                            font-size: 15px;
                        }

                        input[type="text"],
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
                        textarea:focus {
                            outline: none;
                            border-color: var(--primary);
                            background: white;
                            box-shadow: 0 0 0 4px rgba(56, 87, 174, 0.1);
                        }

                        textarea {
                            resize: vertical;
                            min-height: 120px;
                            line-height: 1.6;
                        }

                        input[type="file"] {
                            padding: 10px;
                            background: #f8fafc;
                            border: 2px dashed #cbd5e1;
                            border-radius: 12px;
                            width: 100%;
                            cursor: pointer;
                        }

                        .btn-submit {
                            width: 100%;
                            padding: 18px;
                            background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                            color: white;
                            border: none;
                            border-radius: 12px;
                            font-weight: 800;
                            font-size: 16px;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            box-shadow: 0 10px 25px rgba(56, 87, 174, 0.4);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 12px;
                        }

                        .btn-submit:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 15px 35px rgba(56, 87, 174, 0.5);
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
                        }

                        .back-link:hover {
                            color: var(--primary);
                        }

                        .alert {
                            padding: 18px;
                            border-radius: 12px;
                            margin-bottom: 30px;
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            font-weight: 600;
                            background: #dcfce7;
                            color: #166534;
                            border: 1px solid #bbf7d0;
                        }

                        .file-preview {
                            margin-top: 20px;
                            padding: 20px;
                            background: #f1f5f9;
                            border-radius: 12px;
                            text-align: center;
                        }

                        .preview-title {
                            font-size: 13px;
                            font-weight: 700;
                            color: #64748b;
                            text-transform: uppercase;
                            margin-bottom: 15px;
                            display: block;
                        }

                        .file-preview img {
                            max-width: 150px;
                            height: 150px;
                            object-fit: contain;
                            background: white;
                            padding: 15px;
                            border-radius: 15px;
                            border: 1px solid var(--border);
                            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                        }
                    </style>
                </head>

            <body>
                <jsp:include page="navbar.jsp" />

                <div class="container">
                    <div class="header">
                        <div class="header-icon"><i class="fas fa-id-card"></i></div>
                        <h1>Identité de votre Club</h1>
                        <p class="subtitle">Façonnez l'image de votre association au sein de l'institut.</p>
                    </div>

                    <% if (request.getAttribute("success") !=null) { %>
                        <div class="alert">
                            <i class="fas fa-check-circle"></i>
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>

                            <form method="POST" action="profil-club" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="nomClub"><i class="fas fa-signature"></i> Nom officiel du Club</label>
                                    <input type="text" id="nomClub" name="nomClub"
                                        value="<%= user.getNomClub() != null ? user.getNomClub() : "" %>" required
                                        placeholder="Ex: Club Robotique, Club Musique...">
                                </div>

                                <div class="form-group">
                                    <label for="descriptionClub"><i class="fas fa-align-left"></i> Présentation &
                                        Objectifs</label>
                                    <textarea id="descriptionClub" name="descriptionClub" required
                                        placeholder="Décrivez brièvement les activités et l'ambiance de votre club..."><%= user.getDescriptionClub() != null ? user.getDescriptionClub() : "" %></textarea>
                                </div>

                                <div class="form-group">
                                    <label for="logoClub"><i class="fas fa-image"></i> Emblème du Club</label>
                                    <input type="file" id="logoClub" name="logoClub" accept="image/*">

                                    <% if (user.getLogoClub() !=null && !user.getLogoClub().isEmpty()) { %>
                                        <div class="file-preview">
                                            <span class="preview-title">Aperçu du logo actuel</span>
                                            <img src="assets/club-logos/<%= user.getLogoClub() %>" alt="Logo">
                                        </div>
                                        <% } %>
                                </div>

                                <button type="submit" class="btn-submit">
                                    <i class="fas fa-save"></i> Enregistrer l'Identité
                                </button>

                                <a href="accueil" class="back-link"><i class="fas fa-chevron-left"></i> Retour au
                                    Tableau de bord</a>
                            </form>
                </div>
            </body>

            </html>

            </html>