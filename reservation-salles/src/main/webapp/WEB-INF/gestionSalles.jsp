<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Salle, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } @SuppressWarnings("unchecked")
            List<Salle> salles = (List<Salle>) request.getAttribute("salles");
                if (salles == null) {
                salles = new java.util.ArrayList<>();
                    }
                    %>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Gestion des Salles</title>

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Gestion des Espaces - Administration</title>
                            <style>
                                :root {
                                    --bg: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    --surface: #ffffff;
                                    --text: #1a202c;
                                    --text-light: #718096;
                                    --border: #e2e8f0;
                                    --primary: #3857ae;
                                    --primary2: #1d2e57;
                                    --shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
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

                                .container {
                                    max-width: 1200px;
                                    margin: 50px auto;
                                    padding: 0 20px;
                                }

                                .page-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    margin-bottom: 40px;
                                    background: rgba(255, 255, 255, 0.95);
                                    padding: 30px;
                                    border-radius: 20px;
                                    box-shadow: var(--shadow);
                                    backdrop-filter: blur(10px);
                                }

                                .page-header h1 {
                                    font-size: 28px;
                                    font-weight: 800;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    -webkit-background-clip: text;
                                    -webkit-text-fill-color: transparent;
                                }

                                .btn-new {
                                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                                    color: white;
                                    padding: 14px 28px;
                                    border: none;
                                    border-radius: 12px;
                                    cursor: pointer;
                                    text-decoration: none;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 10px;
                                    font-weight: 700;
                                    transition: all 0.3s ease;
                                    box-shadow: 0 5px 15px rgba(56, 87, 174, 0.4);
                                }

                                .btn-new:hover {
                                    transform: translateY(-3px);
                                    box-shadow: 0 8px 25px rgba(56, 87, 174, 0.5);
                                }

                                .table-container {
                                    background: var(--surface);
                                    border-radius: 20px;
                                    box-shadow: var(--shadow);
                                    overflow: hidden;
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                }

                                thead {
                                    background: #f8fafc;
                                    border-bottom: 2px solid var(--border);
                                }

                                th {
                                    padding: 20px;
                                    text-align: left;
                                    font-size: 14px;
                                    font-weight: 700;
                                    color: #475569;
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                }

                                td {
                                    padding: 20px;
                                    border-bottom: 1px solid var(--border);
                                    font-size: 15px;
                                    color: #1e293b;
                                }

                                tr:last-child td {
                                    border-bottom: none;
                                }

                                tr:hover td {
                                    background: #f1f5f9;
                                }

                                .btn-edit,
                                .btn-delete {
                                    padding: 10px 18px;
                                    border-radius: 10px;
                                    cursor: pointer;
                                    font-size: 13px;
                                    font-weight: 700;
                                    transition: all 0.3s ease;
                                    text-decoration: none;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 8px;
                                    border: none;
                                }

                                .btn-edit {
                                    background: #dcfce7;
                                    color: #166534;
                                    margin-right: 10px;
                                }

                                .btn-edit:hover {
                                    background: #bbf7d0;
                                    transform: scale(1.05);
                                }

                                .btn-delete {
                                    background: #fee2e2;
                                    color: #991b1b;
                                }

                                .btn-delete:hover {
                                    background: #fca5a5;
                                    transform: scale(1.05);
                                }

                                .capacity-pill {
                                    background: #e2e8f0;
                                    padding: 5px 12px;
                                    border-radius: 20px;
                                    font-size: 13px;
                                    font-weight: 700;
                                    color: #475569;
                                }
                            </style>
                        </head>

                    <body>
                        <jsp:include page="navbar.jsp" />

                        <div class="container">
                            <div class="page-header">
                                <h1><i class="fas fa-tools"></i> Administration des Espaces</h1>
                                <a href="salles?action=add" class="btn-new">
                                    <i class="fas fa-plus"></i> Ajouter un Espace
                                </a>
                            </div>

                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-door-open"></i> Nom de l'Espace</th>
                                            <th><i class="fas fa-users"></i> Capacité d'Accueil</th>
                                            <th>Actions de Gestion</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Salle s : salles) { %>
                                            <tr>
                                                <td>
                                                    <strong>
                                                        <%= s.getNom() %>
                                                    </strong>
                                                </td>
                                                <td>
                                                    <span class="capacity-pill">
                                                        <%= s.getCapacite() %> places
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="salles?action=edit&id=<%= s.getId() %>" class="btn-edit"><i
                                                            class="fas fa-edit"></i> Modifier</a>
                                                    <a href="salles?action=delete&id=<%= s.getId() %>"
                                                        class="btn-delete"
                                                        onclick="return confirm('Confirmez-vous la suppression de cet espace universitaire ?')">
                                                        <i class="fas fa-trash-alt"></i> Supprimer
                                                    </a>
                                                </td>
                                            </tr>
                                            <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </body>

                    </html>

                    </html>