<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Reservation, beans.Utilisateur, java.util.Date" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } @SuppressWarnings("unchecked")
            List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                if (reservations == null) {
                reservations = new java.util.ArrayList<>();
                    }
                    %>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Gestion des Réservations - Admin</title>

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Contrôle des Réservations - Administration</title>
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
                                    --success: #10b981;
                                    --warning: #f59e0b;
                                    --danger: #ef4444;
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
                                    max-width: 1300px;
                                    margin: 50px auto;
                                    padding: 0 20px;
                                }

                                .page-header {
                                    background: rgba(255, 255, 255, 0.95);
                                    padding: 35px;
                                    border-radius: 24px;
                                    box-shadow: var(--shadow);
                                    backdrop-filter: blur(10px);
                                    margin-bottom: 40px;
                                    display: flex;
                                    align-items: center;
                                    gap: 20px;
                                }

                                .header-icon {
                                    width: 60px;
                                    height: 60px;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    border-radius: 18px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    color: white;
                                    font-size: 24px;
                                    box-shadow: 0 10px 20px rgba(56, 87, 174, 0.2);
                                }

                                .page-header h1 {
                                    font-size: 26px;
                                    font-weight: 800;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    -webkit-background-clip: text;
                                    background-clip: text;
                                    -webkit-text-fill-color: transparent;
                                }

                                .table-container {
                                    background: var(--surface);
                                    border-radius: 24px;
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
                                    padding: 20px 25px;
                                    text-align: left;
                                    font-size: 13px;
                                    font-weight: 700;
                                    color: #64748b;
                                    text-transform: uppercase;
                                    letter-spacing: 0.8px;
                                }

                                td {
                                    padding: 22px 25px;
                                    border-bottom: 1px solid #f1f5f9;
                                    font-size: 14px;
                                    color: #334155;
                                    vertical-align: middle;
                                }

                                tr:last-child td {
                                    border-bottom: none;
                                }

                                tr:hover td {
                                    background: #f8fafc;
                                }

                                .status-badge {
                                    padding: 6px 14px;
                                    border-radius: 20px;
                                    font-size: 12px;
                                    font-weight: 700;
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 6px;
                                }

                                .status-pending {
                                    background: #fffbeb;
                                    color: #b45309;
                                }

                                .status-validated {
                                    background: #ecfdf5;
                                    color: #065f46;
                                }

                                .status-cancelled {
                                    background: #fef2f2;
                                    color: #991b1b;
                                }

                                .action-form select {
                                    padding: 10px 30px 10px 15px;
                                    border-radius: 10px;
                                    border: 2px solid #e2e8f0;
                                    background: #f8fafc;
                                    color: #475569;
                                    font-weight: 600;
                                    font-size: 13px;
                                    cursor: pointer;
                                    transition: all 0.2s;
                                    appearance: none;
                                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                                    background-repeat: no-repeat;
                                    background-position: right 10px center;
                                    background-size: 16px;
                                }

                                .action-form select:hover {
                                    border-color: var(--primary);
                                    background-color: white;
                                }

                                .user-id-pill,
                                .salle-id-pill {
                                    background: #f1f5f9;
                                    padding: 4px 10px;
                                    border-radius: 8px;
                                    font-weight: 600;
                                    font-size: 13px;
                                    color: #475569;
                                }

                                .time-box {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 8px;
                                    color: #3857ae;
                                    font-weight: 700;
                                }

                                .expired-label {
                                    color: #94a3b8;
                                    font-size: 12px;
                                    font-style: italic;
                                    display: flex;
                                    align-items: center;
                                    gap: 5px;
                                }
                            </style>
                        </head>

                    <body>
                        <jsp:include page="navbar.jsp" />

                        <div class="container">
                            <div class="page-header">
                                <div class="header-icon"><i class="fas fa-clipboard-list"></i></div>
                                <div>
                                    <h1>Surveillance des Réservations</h1>
                                    <p style="color: #64748b; font-size: 14px; margin-top: 5px;">Pilotage et validation
                                        des événements universitaires</p>
                                </div>
                            </div>

                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Responsable</th>
                                            <th>Date & Heure</th>
                                            <th>Espace</th>
                                            <th>État actuel</th>
                                            <th>Actions de Pilotage</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (Reservation r : reservations) { %>
                                            <tr>
                                                <td><span style="color: #94a3b8; font-family: monospace;">#<%= r.getId()
                                                            %></span></td>
                                                <td><span class="user-id-pill">ID: <%= r.getUtilisateurId() %></span>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 600;"><i class="far fa-calendar-alt"></i>
                                                        <%= r.getDateReservation() %>
                                                    </div>
                                                    <div class="time-box"><i class="far fa-clock"></i>
                                                        <%= r.getHeureDebut() %> - <%= r.getHeureFin() %>
                                                    </div>
                                                </td>
                                                <td><span class="salle-id-pill">ID Salle: <%= r.getSalleId() %></span>
                                                </td>
                                                <td>
                                                    <span class="status-badge status-<%= r.getStatus().equals(" en attente") ? "pending" : (r.getStatus().equals("validée")
                                                        ? "validated" : "cancelled" ) %>">
                                                        <i class="fas <%= r.getStatus().equals(" en attente")
                                                            ? "fa-clock" : (r.getStatus().equals("validée")
                                                            ? "fa-check-circle" : "fa-times-circle" ) %>"></i>
                                                        <%= r.getStatus() %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <% Date today=new Date(); Date
                                                        reservationDate=r.getDateReservation(); boolean
                                                        isDatePassed=reservationDate.before(today); %>

                                                        <% if (isDatePassed) { %>
                                                            <span class="expired-label"><i class="fas fa-history"></i>
                                                                Séance passée</span>
                                                            <% } else { %>
                                                                <form action="adminReservations" method="get"
                                                                    class="action-form">
                                                                    <input type="hidden" name="action"
                                                                        value="updateStatus">
                                                                    <input type="hidden" name="id"
                                                                        value="<%= r.getId() %>">
                                                                    <select name="status"
                                                                        onchange="if(confirm('Appliquer ce changement de statut ?')) this.form.submit();">
                                                                        <option value="en attente"
                                                                            <%=r.getStatus().equals("en attente")
                                                                            ? "selected" : "" %>>En attente</option>
                                                                        <option value="validée"
                                                                            <%=r.getStatus().equals("validée")
                                                                            ? "selected" : "" %>>Validée</option>
                                                                        <option value="annulée"
                                                                            <%=r.getStatus().equals("annulée")
                                                                            ? "selected" : "" %>>Annulée</option>
                                                                    </select>
                                                                </form>
                                                                <% } %>
                                                </td>
                                            </tr>
                                            <% } %>
                                    </tbody>
                                </table>

                                <% if (reservations.isEmpty()) { %>
                                    <div style="text-align: center; padding: 100px; color: #94a3b8;">
                                        <i class="fas fa-inbox"
                                            style="font-size: 50px; margin-bottom: 20px; opacity: 0.3;"></i>
                                        <p>Aucune réservation enregistrée à ce jour.</p>
                                    </div>
                                    <% } %>
                            </div>
                        </div>
                    </body>

                    </html>

                    </html>