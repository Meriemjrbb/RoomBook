<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Salle, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } Salle salle=(Salle)
            request.getAttribute("salle"); boolean isEdit=salle !=null; %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <%= isEdit ? "Modifier" : "Ajouter" %> une Salle
                </title>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>
                        <%= isEdit ? "Modification" : "Création" %> d'Espace - Administration
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

                        .form-container {
                            background: var(--surface);
                            padding: 50px;
                            border-radius: 24px;
                            box-shadow: var(--shadow);
                            width: 100%;
                            max-width: 550px;
                            margin: 60px auto;
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
                            width: 70px;
                            height: 70px;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            border-radius: 20px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            color: white;
                            font-size: 30px;
                            margin: 0 auto 20px;
                            box-shadow: 0 10px 25px rgba(56, 87, 174, 0.3);
                        }

                        .header h1 {
                            font-size: 24px;
                            font-weight: 800;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            -webkit-background-clip: text;
                            background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        .form-group {
                            margin-bottom: 25px;
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

                        input {
                            width: 100%;
                            padding: 16px;
                            border: 2px solid #f1f5f9;
                            border-radius: 12px;
                            font-size: 15px;
                            font-family: inherit;
                            background: #f8fafc;
                            transition: all 0.3s ease;
                        }

                        input:focus {
                            outline: none;
                            border-color: var(--primary);
                            background: white;
                            box-shadow: 0 0 0 4px rgba(56, 87, 174, 0.1);
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
                            margin-top: 20px;
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
                            font-size: 14px;
                        }

                        .back-link:hover {
                            color: var(--primary);
                        }
                    </style>
                </head>

            <body>
                <jsp:include page="navbar.jsp" />

                <div class="form-container">
                    <div class="header">
                        <div class="header-icon">
                            <i class="fas <%= isEdit ? " fa-pen-to-square" : "fa-plus-circle" %>"></i>
                        </div>
                        <h1>
                            <%= isEdit ? "Modifier l'Espace" : "Créer un Nouvel Espace" %>
                        </h1>
                        <p style="color: #64748b; font-size: 14px; margin-top: 10px;">Configuration des paramètres de
                            l'infrastructure</p>
                    </div>

                    <form method="POST" action="salles">
                        <% if (isEdit) { %>
                            <input type="hidden" name="id" value="<%= salle.getId() %>">
                            <% } %>

                                <div class="form-group">
                                    <label for="nom"><i class="fas fa-tag"></i> Désignation de l'espace</label>
                                    <input type="text" id="nom" name="nom"
                                        placeholder="Ex: Amphi Ibn Khaldoun, Salle B10..."
                                        value="<%= isEdit ? salle.getNom() : "" %>" required>
                                </div>

                                <div class="form-group">
                                    <label for="capacite"><i class="fas fa-users"></i> Capacité d'accueil
                                        (places)</label>
                                    <input type="number" id="capacite" name="capacite"
                                        placeholder="Nombre de places assises"
                                        value="<%= isEdit ? salle.getCapacite() : "" %>" min="1" required>
                                </div>

                                <button type="submit" class="btn-submit">
                                    <i class="fas <%= isEdit ? " fa-save" : "fa-check" %>"></i>
                                    <%= isEdit ? "Enregistrer les modifications" : "Valider la création" %>
                                </button>
                    </form>

                    <a href="salles" class="back-link">
                        <i class="fas fa-arrow-left"></i> Retour à la gestion des salles
                    </a>
                </div>
            </body>

            </html>