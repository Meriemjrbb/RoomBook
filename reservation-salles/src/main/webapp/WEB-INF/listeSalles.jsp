<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Salle, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null) {
            response.sendRedirect("login"); return; } @SuppressWarnings("unchecked") List<Salle> salles = (List<Salle>)
                request.getAttribute("salles");
                if (salles == null) {
                salles = new java.util.ArrayList<>();
                    }
                    Integer errorSalleId = (Integer) request.getAttribute("errorSalleId");
                    if (errorSalleId == null) errorSalleId = -1;
                    %>
                    <!DOCTYPE html>
                    <html lang="fr">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Réserver une Salle</title>

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Guide des Espaces - Club Universitaire</title>
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
                                    --success: #10b981;
                                    --error: #ef4444;
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
                                    text-align: center;
                                    background: rgba(255, 255, 255, 0.95);
                                    padding: 40px;
                                    border-radius: 24px;
                                    box-shadow: var(--shadow);
                                    margin-bottom: 50px;
                                    backdrop-filter: blur(10px);
                                }

                                .page-header h1 {
                                    font-size: 32px;
                                    font-weight: 800;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    -webkit-background-clip: text;
                                    -webkit-text-fill-color: transparent;
                                    margin-bottom: 15px;
                                }

                                .page-header p {
                                    color: var(--text-light);
                                    font-size: 17px;
                                    max-width: 700px;
                                    margin: 0 auto;
                                    line-height: 1.6;
                                }

                                .alert {
                                    padding: 20px 30px;
                                    border-radius: 15px;
                                    margin-bottom: 40px;
                                    display: flex;
                                    align-items: center;
                                    gap: 15px;
                                    font-weight: 600;
                                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                                    animation: slideIn 0.4s ease-out;
                                }

                                .alert-success {
                                    background: #d1fae5;
                                    color: #065f46;
                                    border-left: 5px solid #10b981;
                                }

                                .alert-error {
                                    background: #fee2e2;
                                    color: #991b1b;
                                    border-left: 5px solid #ef4444;
                                }

                                @keyframes slideIn {
                                    from {
                                        transform: translateY(-30px);
                                        opacity: 0;
                                    }

                                    to {
                                        transform: translateY(0);
                                        opacity: 1;
                                    }
                                }

                                .salles-grid {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
                                    gap: 30px;
                                }

                                .salle-card {
                                    background: var(--surface);
                                    border-radius: 20px;
                                    box-shadow: var(--shadow);
                                    overflow: hidden;
                                    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    display: flex;
                                    flex-direction: column;
                                    animation: fadeInUp 0.6s ease-out;
                                    animation-fill-mode: both;
                                }

                                @keyframes fadeInUp {
                                    from {
                                        opacity: 0;
                                        transform: translateY(40px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                .salle-card:hover {
                                    transform: translateY(-10px);
                                    box-shadow: 0 30px 70px rgba(0, 0, 0, 0.25);
                                }

                                .salle-banner {
                                    height: 160px;
                                    background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                                    display: flex;
                                    flex-direction: column;
                                    align-items: center;
                                    justify-content: center;
                                    color: white;
                                    position: relative;
                                }

                                .salle-banner i {
                                    font-size: 50px;
                                    margin-bottom: 10px;
                                    opacity: 0.9;
                                }

                                .salle-banner h3 {
                                    font-size: 24px;
                                    font-weight: 800;
                                    letter-spacing: 0.5px;
                                }

                                .capacity-badge {
                                    position: absolute;
                                    bottom: -15px;
                                    right: 30px;
                                    background: white;
                                    color: var(--primary);
                                    padding: 8px 15px;
                                    border-radius: 20px;
                                    font-weight: 800;
                                    font-size: 13px;
                                    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
                                    display: flex;
                                    align-items: center;
                                    gap: 6px;
                                    border: 2px solid var(--border);
                                }

                                .salle-body {
                                    padding: 35px 30px;
                                    flex-grow: 1;
                                    display: flex;
                                    flex-direction: column;
                                }

                                .salle-info {
                                    margin-bottom: 25px;
                                    color: var(--text-light);
                                    font-size: 15px;
                                    line-height: 1.5;
                                }

                                .btn-show-form {
                                    width: 100%;
                                    padding: 15px;
                                    background: #f1f5f9;
                                    color: var(--primary);
                                    border: 2px solid #e2e8f0;
                                    border-radius: 12px;
                                    font-weight: 700;
                                    cursor: pointer;
                                    font-size: 15px;
                                    transition: all 0.3s ease;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    gap: 10px;
                                }

                                .btn-show-form:hover {
                                    background: var(--primary);
                                    color: white;
                                    border-color: var(--primary);
                                    transform: translateY(-2px);
                                }

                                .reservation-form {
                                    display: none;
                                    margin-top: 25px;
                                    padding-top: 25px;
                                    border-top: 2px dashed #e2e8f0;
                                    animation: fadeIn 0.3s ease;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                    }

                                    to {
                                        opacity: 1;
                                    }
                                }

                                .form-group {
                                    margin-bottom: 20px;
                                }

                                label {
                                    display: block;
                                    margin-bottom: 8px;
                                    color: var(--text);
                                    font-weight: 700;
                                    font-size: 14px;
                                }

                                input {
                                    width: 100%;
                                    padding: 12px 15px;
                                    border: 2px solid #f1f5f9;
                                    border-radius: 10px;
                                    font-size: 14px;
                                    font-family: inherit;
                                    background: #f8fafc;
                                    transition: all 0.3s ease;
                                }

                                input:focus {
                                    border-color: var(--primary);
                                    background: white;
                                    outline: none;
                                    box-shadow: 0 0 0 4px rgba(56, 87, 174, 0.1);
                                }

                                .btn-submit {
                                    width: 100%;
                                    padding: 14px;
                                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                                    color: white;
                                    border: none;
                                    border-radius: 10px;
                                    font-weight: 700;
                                    cursor: pointer;
                                    font-size: 15px;
                                    transition: all 0.3s ease;
                                    margin-top: 10px;
                                    box-shadow: 0 5px 15px rgba(16, 185, 129, 0.3);
                                }

                                .btn-submit:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
                                }

                                .btn-cancel {
                                    width: 100%;
                                    padding: 12px;
                                    background: transparent;
                                    color: #94a3b8;
                                    border: none;
                                    font-weight: 600;
                                    cursor: pointer;
                                    font-size: 14px;
                                    margin-top: 10px;
                                    transition: color 0.3s;
                                }

                                .btn-cancel:hover {
                                    color: #ef4444;
                                }

                                .salle-error {
                                    border: 2px solid #ef4444;
                                }

                                .salle-error .salle-banner {
                                    background: linear-gradient(135deg, #ef4444 0%, #991b1b 100%);
                                }

                                .input-group {
                                    display: grid;
                                    grid-template-columns: 1fr 1fr;
                                    gap: 15px;
                                }

                                .empty-state {
                                    grid-column: 1 / -1;
                                    text-align: center;
                                    background: white;
                                    padding: 80px 40px;
                                    border-radius: 24px;
                                    box-shadow: var(--shadow);
                                    color: var(--text-light);
                                }

                                .empty-state i {
                                    font-size: 60px;
                                    margin-bottom: 20px;
                                    opacity: 0.3;
                                }
                            </style>
                        </head>

                    <body>
                        <jsp:include page="navbar.jsp" />

                        <div class="container">
                            <div class="page-header">
                                <h1><i class="fas fa-university"></i> Catalogue des Espaces</h1>
                                <p>Découvrez notre sélection de salles et amphithéâtres équipés pour accueillir vos
                                    événements de club, formations et séminaires.</p>
                            </div>

                            <!-- Messages d'erreur/succès -->
                            <% if (request.getAttribute("error") !=null) { %>
                                <div class="alert alert-error">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <%= request.getAttribute("error") %>
                                </div>
                                <% } %>

                                    <% if (request.getAttribute("success") !=null) { %>
                                        <div class="alert alert-success">
                                            <i class="fas fa-check-circle"></i>
                                            <%= request.getAttribute("success") %>
                                        </div>
                                        <% } %>

                                            <div class="salles-grid">
                                                <% for (Salle salle : salles) { %>
                                                    <% boolean isError=(errorSalleId==salle.getId()); String
                                                        amphiIcon=(salle.getCapacite()> 50) ? "building-columns" :
                                                        "door-open";
                                                        %>
                                                        <div class="salle-card <%= isError ? " salle-error" : "" %>">
                                                            <div class="salle-banner">
                                                                <i class="fas fa-<%= amphiIcon %>"></i>
                                                                <h3>
                                                                    <%= salle.getNom() %>
                                                                </h3>
                                                                <div class="capacity-badge">
                                                                    <i class="fas fa-users"></i>
                                                                    <%= salle.getCapacite() %> Places
                                                                </div>
                                                            </div>

                                                            <div class="salle-body">
                                                                

                                                                <button type="button" class="btn-show-form"
                                                                    id="btn-trigger-<%= salle.getId() %>"
                                                                    onclick="toggleForm(this, 'form-<%= salle.getId() %>')">
                                                                    <i class="fas fa-calendar-plus"></i> Réserver cet
                                                                    Espace
                                                                </button>

                                                                <!-- Formulaire de réservation -->
                                                                <form method="POST" action="reservation-salle"
                                                                    class="reservation-form <%= isError ? " show" : ""
                                                                    %>"
                                                                    id="form-<%= salle.getId() %>"
                                                                        style="<%= isError ? "display: block;" : "" %>">
                                                                            <input type="hidden" name="salleId"
                                                                                value="<%= salle.getId() %>">

                                                                            <div class="form-group">
                                                                                <label><i
                                                                                        class="fas fa-calendar-day"></i>
                                                                                    Date de l'activité</label>
                                                                                <input type="date" name="date" required
                                                                                    min="<%= java.time.LocalDate.now() %>">
                                                                            </div>

                                                                            <div class="form-group input-group">
                                                                                <div>
                                                                                    <label><i class="fas fa-clock"></i>
                                                                                        Début</label>
                                                                                    <input type="time" name="heureDebut"
                                                                                        required>
                                                                                </div>
                                                                                <div>
                                                                                    <label><i class="fas fa-clock"></i>
                                                                                        Fin</label>
                                                                                    <input type="time" name="heureFin"
                                                                                        required>
                                                                                </div>
                                                                            </div>

                                                                            <button type="submit" class="btn-submit">
                                                                                <i class="fas fa-paper-plane"></i>
                                                                                Envoyer la demande
                                                                            </button>

                                                                            <button type="button" class="btn-cancel"
                                                                                onclick="toggleForm(document.getElementById('btn-trigger-<%= salle.getId() %>'), 'form-<%= salle.getId() %>')">
                                                                                Ignorer
                                                                            </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <% } %>

                                                            <% if (salles.isEmpty()) { %>
                                                                <div class="empty-state">
                                                                    <i class="fas fa-building-circle-exclamation"></i>
                                                                    <h3>Aucun espace disponible</h3>
                                                                    <p>Les espaces universitaires ne sont pas encore
                                                                        ouverts à la réservation ou sont tous occupés.
                                                                    </p>
                                                                </div>
                                                                <% } %>
                                            </div>
                        </div>

                        <script>
                            function toggleForm(button, formId) {
                                const form = document.getElementById(formId);
                                const isShowing = form.style.display === 'block';

                                if (isShowing) {
                                    form.style.display = 'none';
                                    button.innerHTML = '<i class="fas fa-calendar-plus"></i> Réserver cet Espace';
                                    button.style.background = '#f1f5f9';
                                    button.style.color = '#3857ae';
                                } else {
                                    form.style.display = 'block';
                                    button.innerHTML = '<i class="fas fa-times"></i> Masquer le formulaire';
                                    button.style.background = '#ef4444';
                                    button.style.color = 'white';
                                }
                            }
                        </script>
                    </body>

                    </html>

                    </html>