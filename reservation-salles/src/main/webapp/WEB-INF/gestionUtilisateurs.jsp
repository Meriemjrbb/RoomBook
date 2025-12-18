<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) request.getSession().getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } @SuppressWarnings("unchecked")
            List<Utilisateur> users = (List<Utilisateur>) request.getAttribute("users");
                if (users == null) {
                users = new java.util.ArrayList<>();
                    }
                    %>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Gestion des Utilisateurs</title>

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Annuaire des Responsables - Administration</title>
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

                                .container {
                                    max-width: 1400px;
                                    margin: 50px auto;
                                    padding: 0 20px;
                                }

                                .page-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    margin-bottom: 50px;
                                    background: rgba(255, 255, 255, 0.95);
                                    padding: 35px;
                                    border-radius: 24px;
                                    box-shadow: var(--shadow);
                                    backdrop-filter: blur(10px);
                                }

                                .page-header h1 {
                                    font-size: 30px;
                                    font-weight: 800;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    -webkit-background-clip: text;
                                    -webkit-text-fill-color: transparent;
                                }

                                .btn-new {
                                    background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                                    color: white;
                                    padding: 15px 30px;
                                    border: none;
                                    border-radius: 12px;
                                    cursor: pointer;
                                    text-decoration: none;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 10px;
                                    font-weight: 700;
                                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                                    box-shadow: 0 5px 15px rgba(56, 87, 174, 0.4);
                                }

                                .btn-new:hover {
                                    transform: translateY(-3px);
                                    box-shadow: 0 10px 25px rgba(56, 87, 174, 0.5);
                                }

                                .users-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
                                    gap: 30px;
                                }

                                .user-card {
                                    background: var(--surface);
                                    border-radius: 24px;
                                    box-shadow: var(--shadow);
                                    overflow: hidden;
                                    transition: all 0.4s ease;
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    display: flex;
                                    flex-direction: column;
                                }

                                .user-card:hover {
                                    transform: translateY(-10px);
                                    box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3);
                                }

                                .user-card-header {
                                    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                                    padding: 30px;
                                    display: flex;
                                    align-items: center;
                                    gap: 20px;
                                    border-bottom: 1px solid var(--border);
                                }

                                .avatar-container {
                                    width: 80px;
                                    height: 80px;
                                    border-radius: 20px;
                                    background: white;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                                    border: 2px solid white;
                                    flex-shrink: 0;
                                    overflow: hidden;
                                }

                                .avatar-container i {
                                    font-size: 35px;
                                    color: var(--primary);
                                }

                                .avatar-container img {
                                    width: 100%;
                                    height: 100%;
                                    object-fit: cover;
                                }

                                .header-meta h3 {
                                    font-size: 19px;
                                    font-weight: 800;
                                    color: #1e293b;
                                    margin-bottom: 5px;
                                }

                                .role-badge {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 6px;
                                    padding: 5px 12px;
                                    border-radius: 20px;
                                    font-size: 11px;
                                    font-weight: 800;
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                }

                                .role-admin {
                                    background: #fee2e2;
                                    color: #991b1b;
                                }

                                .role-user {
                                    background: #dcfce7;
                                    color: #166534;
                                }

                                .user-card-body {
                                    padding: 30px;
                                    flex-grow: 1;
                                }

                                .info-tile {
                                    background: #f8fafc;
                                    padding: 15px;
                                    border-radius: 12px;
                                    margin-bottom: 15px;
                                    border: 1px solid #f1f5f9;
                                }

                                .tile-label {
                                    display: block;
                                    font-size: 11px;
                                    font-weight: 700;
                                    color: #94a3b8;
                                    text-transform: uppercase;
                                    margin-bottom: 5px;
                                }

                                .tile-value {
                                    font-size: 14px;
                                    font-weight: 600;
                                    color: #334155;
                                    word-break: break-all;
                                }

                                .club-spotlight {
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    padding: 20px;
                                    border-radius: 15px;
                                    color: white;
                                    margin-top: 20px;
                                    position: relative;
                                    overflow: hidden;
                                }

                                .club-spotlight h4 {
                                    font-size: 15px;
                                    font-weight: 800;
                                    margin-bottom: 8px;
                                    display: flex;
                                    align-items: center;
                                    gap: 8px;
                                }

                                .club-spotlight p {
                                    font-size: 12px;
                                    opacity: 0.8;
                                    line-height: 1.5;
                                    font-style: italic;
                                }

                                .card-footer {
                                    padding: 20px 30px;
                                    background: #f8fafc;
                                    border-top: 1px solid var(--border);
                                    display: grid;
                                    grid-template-columns: 1fr 1fr;
                                    gap: 15px;
                                }

                                .btn-action {
                                    padding: 12px;
                                    border-radius: 10px;
                                    font-weight: 700;
                                    font-size: 13px;
                                    text-decoration: none;
                                    text-align: center;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 8px;
                                    transition: all 0.2s;
                                }

                                .btn-edit {
                                    background: white;
                                    color: #3857ae;
                                    border: 2px solid #3857ae;
                                }

                                .btn-edit:hover {
                                    background: #3857ae;
                                    color: white;
                                }

                                .btn-delete {
                                    background: #fee2e2;
                                    color: #ef4444;
                                    border: 2px solid transparent;
                                }

                                .btn-delete:hover {
                                    background: #ef4444;
                                    color: white;
                                }

                                .no-data {
                                    grid-column: 1 / -1;
                                    text-align: center;
                                    background: white;
                                    padding: 100px;
                                    border-radius: 30px;
                                    box-shadow: var(--shadow);
                                }

                                .no-data i {
                                    font-size: 60px;
                                    color: #e2e8f0;
                                    margin-bottom: 20px;
                                }
                            </style>
                        </head>

                    <body>
                        <jsp:include page="navbar.jsp" />

                        <div class="container">
                            <div class="page-header">
                                <h1><i class="fas fa-users-gear"></i> Responsables & Administrateurs</h1>
                                <a href="users?action=add" class="btn-new">
                                    <i class="fas fa-plus-circle"></i> Nouveau Profil
                                </a>
                            </div>

                            <div class="users-grid">
                                <% for (Utilisateur u : users) { %>
                                    <div class="user-card">
                                        <div class="user-card-header">
                                            <div class="avatar-container">
                                                <% if (u.getRole().equals("admin")) { %>
                                                    <i class="fas fa-shield-halved"></i>
                                                    <% } else if (u.getLogoClub() !=null && !u.getLogoClub().isEmpty())
                                                        { %>
                                                        <img src="assets/club-logos/<%= u.getLogoClub() %>"
                                                            alt="Club Logo">
                                                        <% } else { %>
                                                            <i class="fas fa-user-graduate"></i>
                                                            <% } %>
                                            </div>
                                            <div class="header-meta">
                                                <h3>
                                                    <%= u.getPrenom() %>
                                                        <%= u.getNom() %>
                                                </h3>
                                                <span class="role-badge <%= u.getRole().equals(" admin") ? "role-admin"
                                                    : "role-user" %>">
                                                    <%= u.getRole().equals("admin") ? "Administrateur" : "Réf. Club" %>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="user-card-body">
                                            <div class="info-tile">
                                                <span class="tile-label"><i class="fas fa-envelope"></i> Contact
                                                    Institutionnel</span>
                                                <span class="tile-value">
                                                    <%= u.getEmail() %>
                                                </span>
                                            </div>

                                            <% if (!u.getRole().equals("admin")) { %>
                                                <% if (u.getNomClub() !=null && !u.getNomClub().isEmpty()) { %>
                                                    <div class="club-spotlight">
                                                        <h4><i class="fas fa-university"></i>
                                                            <%= u.getNomClub() %>
                                                        </h4>
                                                        <% if (u.getDescriptionClub() !=null &&
                                                            !u.getDescriptionClub().isEmpty()) { %>
                                                            <p>"<%= u.getDescriptionClub().length()> 80 ?
                                                                    u.getDescriptionClub().substring(0, 80) + "..." :
                                                                    u.getDescriptionClub() %>"</p>
                                                            <% } %>
                                                    </div>
                                                    <% } else { %>
                                                        <div class="info-tile"
                                                            style="border-style: dashed; opacity: 0.6;">
                                                            <span class="tile-value">Aucun club rattaché</span>
                                                        </div>
                                                        <% } %>
                                                            <% } %>
                                        </div>

                                        <div class="card-footer">
                                            <a href="users?action=edit&id=<%= u.getId() %>" class="btn-action btn-edit">
                                                <i class="fas fa-user-pen"></i> Modifier
                                            </a>
                                            <a href="users?action=delete&id=<%= u.getId() %>"
                                                class="btn-action btn-delete"
                                                onclick="return confirm('Voulez-vous révoquer l\'accès pour ce profil ?')">
                                                <i class="fas fa-user-minus"></i> Révoquer
                                            </a>
                                        </div>
                                    </div>
                                    <% } %>

                                        <% if (users.isEmpty()) { %>
                                            <div class="no-data">
                                                <i class="fas fa-people-group"></i>
                                                <h3>Aucun utilisateur enregistré</h3>
                                                <p>La base de données des responsables est actuellement vide.</p>
                                            </div>
                                            <% } %>
                            </div>
                        </div>
                    </body>

                    </html>

                    </html>