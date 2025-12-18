<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Reservation, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null) {
            response.sendRedirect("login"); return; } @SuppressWarnings("unchecked") List<Reservation> reservations =
            (List<Reservation>) request.getAttribute("reservations");
                if (reservations == null) {
                reservations = new java.util.ArrayList<>();
                    }
                    %>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Mes Événements - Club Universitaire</title>
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

                            .btn-new-reservation {
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

                            .btn-new-reservation:hover {
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

                            .status-badge {
                                padding: 8px 16px;
                                border-radius: 25px;
                                font-size: 13px;
                                font-weight: 700;
                                display: inline-flex;
                                align-items: center;
                                gap: 6px;
                            }

                            .status-pending {
                                background: #fef3c7;
                                color: #92400e;
                            }

                            .status-validated {
                                background: #dcfce7;
                                color: #166534;
                            }

                            .status-cancelled {
                                background: #fee2e2;
                                color: #991b1b;
                            }

                            .btn-delete {
                                background: #fee2e2;
                                color: #dc2626;
                                border: none;
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
                            }

                            .btn-delete:hover {
                                background: #fca5a5;
                                color: #991b1b;
                                transform: scale(1.05);
                            }

                            .empty-message {
                                text-align: center;
                                background: white;
                                padding: 80px 40px;
                                border-radius: 20px;
                                box-shadow: var(--shadow);
                                color: #64748b;
                            }

                            .empty-icon {
                                font-size: 60px;
                                margin-bottom: 25px;
                                opacity: 0.3;
                            }

                            .empty-message h3 {
                                font-size: 24px;
                                font-weight: 800;
                                margin-bottom: 10px;
                                color: #1e293b;
                            }

                            .empty-message a {
                                color: var(--primary);
                                text-decoration: none;
                                font-weight: 700;
                                border-bottom: 2px solid transparent;
                                transition: border-color 0.3s;
                            }

                            .empty-message a:hover {
                                border-color: var(--primary);
                            }
                        </style>
                    </head>

                    <body>
                        <jsp:include page="navbar.jsp" />

                        <div class="container">
                            <div class="page-header">
                                <h1><i class="fas fa-calendar-check"></i> Mes Demandes d'Événements</h1>
                                <a href="reservations?action=add" class="btn-new-reservation">
                                    <i class="fas fa-plus"></i> Nouvel Événement
                                </a>
                            </div>

                            <div class="table-container">
                                <% if (reservations !=null && !reservations.isEmpty()) { %>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th><i class="fas fa-calendar"></i> Date</th>
                                                <th><i class="fas fa-clock"></i> Créneau</th>
                                                <th><i class="fas fa-door-open"></i> Espace</th>
                                                <th><i class="fas fa-info-circle"></i> État</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Reservation r : reservations) { %>
                                                <tr>
                                                    <td>
                                                        <strong>
                                                            <%= r.getDateReservation() %>
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <%= r.getHeureDebut() %> <i class="fas fa-arrow-right"
                                                                style="font-size: 10px; margin: 0 5px;"></i>
                                                            <%= r.getHeureFin() %>
                                                    </td>
                                                    <td>
                                                        <span
                                                            style="background: #e2e8f0; padding: 4px 10px; border-radius: 5px; font-weight: 600;">Salle
                                                            <%= r.getSalleId() %></span>
                                                    </td>
                                                    <td>
                                                        <% String statusKey=r.getStatus().trim().toLowerCase(); String
                                                            badgeClass="pending" ; String icon="clock" ; if
                                                            (statusKey.contains("valid")) { badgeClass="validated" ;
                                                            icon="check-circle" ; } else if
                                                            (statusKey.contains("annul")) { badgeClass="cancelled" ;
                                                            icon="times-circle" ; } %>
                                                            <span class="status-badge status-<%= badgeClass %>">
                                                                <i class="fas fa-<%= icon %>"></i>
                                                                <%= r.getStatus() %>
                                                            </span>
                                                    </td>
                                                    <td>
                                                        <% if (!statusKey.contains("annul")) { %>
                                                            <a href="reservations?action=delete&id=<%= r.getId() %>"
                                                                class="btn-delete"
                                                                onclick="return confirm('Souhaitez-vous vraiment annuler cette demande d\'événement ?')">
                                                                <i class="fas fa-trash-alt"></i> Annuler
                                                            </a>
                                                            <% } else { %>
                                                                <span
                                                                    style="color: #cbd5e1; font-style: italic; font-size: 13px;">Aucune
                                                                    action</span>
                                                                <% } %>
                                                    </td>
                                                </tr>
                                                <% } %>
                                        </tbody>
                                    </table>
                                    <% } else { %>
                                        <div class="empty-message">
                                            <div class="empty-icon"><i class="fas fa-calendar-times"></i></div>
                                            <h3>Aucun événement planifié</h3>
                                            <p>Vous n'avez pas encore soumis de demande de réservation pour votre club.
                                            </p>
                                            <p style="margin-top: 20px;">
                                                <a href="reservations?action=add"><i class="fas fa-plus-circle"></i>
                                                    Organiser mon premier événement</a>
                                            </p>
                                        </div>
                                        <% } %>
                            </div>
                        </div>
                    </body>

                    </html>

                    </html>