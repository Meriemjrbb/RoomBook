<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null) {
            response.sendRedirect("login"); return; } %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Accueil - Gestion des Réservations</title>
                <style>
                    :root {
                        --bg: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                        --surface: #ffffff;
                        --text: #1a202c;
                        --text-light: #718096;
                        --border: #e2e8f0;
                        --primary: #3857ae;
                        --primary2: #1d2e57;
                        --shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                        --shadow2: 0 12px 30px rgba(0, 0, 0, 0.10);
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
                        margin: 40px auto;
                        padding: 0 20px;
                    }

                    /* ✅ SECTION PROFIL CLUB */
                    .profile-section {
                        background: var(--surface);
                        border-radius: 20px;
                        box-shadow: var(--shadow);
                        padding: 40px;
                        margin-bottom: 40px;
                        display: grid;
                        grid-template-columns: 220px 1fr;
                        gap: 40px;
                        align-items: center;
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        animation: fadeInUp 0.6s ease-out;
                    }

                    .profile-logo {
                        text-align: center;
                    }

                    .profile-logo img {
                        width: 200px;
                        height: 200px;
                        border-radius: 15px;
                        object-fit: cover;
                        border: 4px solid var(--border);
                        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
                        transition: transform 0.3s ease;
                    }

                    .profile-logo img:hover {
                        transform: scale(1.05);
                    }

                    .profile-logo .no-logo {
                        width: 200px;
                        height: 200px;
                        border-radius: 15px;
                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 70px;
                        color: white;
                        border: 4px solid var(--border);
                        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
                    }

                    .profile-info h2 {
                        color: var(--text);
                        font-size: 32px;
                        margin-bottom: 10px;
                        font-weight: 800;
                    }

                    .profile-info .club-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                        color: white;
                        padding: 8px 20px;
                        border-radius: 25px;
                        font-size: 13px;
                        font-weight: 600;
                        margin-bottom: 20px;
                        box-shadow: 0 4px 10px rgba(56, 87, 174, 0.3);
                    }

                    .profile-info p {
                        color: var(--text-light);
                        line-height: 1.6;
                        margin-bottom: 12px;
                        font-size: 16px;
                    }

                    .profile-info .label {
                        font-weight: 700;
                        color: var(--text);
                    }

                    .profile-description {
                        background: #f8fafc;
                        padding: 20px;
                        border-left: 5px solid var(--primary);
                        border-radius: 8px;
                        margin-top: 20px;
                        color: #475569;
                        font-style: italic;
                        line-height: 1.6;
                        font-size: 15px;
                    }

                    .profile-actions {
                        margin-top: 25px;
                        display: flex;
                        gap: 15px;
                    }

                    .btn-edit-profile {
                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                        color: white;
                        border: none;
                        padding: 12px 25px;
                        border-radius: 12px;
                        cursor: pointer;
                        font-weight: 700;
                        font-size: 15px;
                        transition: all 0.3s ease;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        box-shadow: 0 4px 12px rgba(56, 87, 174, 0.3);
                    }

                    .btn-edit-profile:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 8px 20px rgba(56, 87, 174, 0.4);
                    }

                    /* Section d'accueil */
                    .welcome-section {
                        background: rgba(255, 255, 255, 0.95);
                        backdrop-filter: blur(10px);
                        padding: 40px;
                        border-radius: 20px;
                        box-shadow: var(--shadow);
                        margin-bottom: 40px;
                        animation: fadeInUp 0.6s ease-out 0.1s;
                        animation-fill-mode: both;
                    }

                    .welcome-section h2 {
                        font-size: 30px;
                        font-weight: 800;
                        background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        margin-bottom: 15px;
                    }

                    .welcome-section p {
                        color: var(--text-light);
                        font-size: 17px;
                        line-height: 1.7;
                        max-width: 800px;
                    }

                    /* Menu grid */
                    .menu-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                        gap: 30px;
                        margin-bottom: 40px;
                    }

                    .menu-card {
                        background: var(--surface);
                        padding: 35px;
                        border-radius: 20px;
                        box-shadow: var(--shadow);
                        text-align: left;
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        border: 1px solid var(--border);
                        display: flex;
                        flex-direction: column;
                        animation: fadeInUp 0.6s ease-out;
                        animation-fill-mode: both;
                    }

                    .menu-card:nth-child(1) {
                        animation-delay: 0.2s;
                    }

                    .menu-card:nth-child(2) {
                        animation-delay: 0.3s;
                    }

                    .menu-card:nth-child(3) {
                        animation-delay: 0.4s;
                    }

                    .menu-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 25px 70px rgba(0, 0, 0, 0.2);
                    }

                    .menu-icon {
                        width: 60px;
                        height: 60px;
                        background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                        border-radius: 15px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 24px;
                        color: white;
                        margin-bottom: 25px;
                        box-shadow: 0 8px 15px rgba(56, 87, 174, 0.2);
                    }

                    .menu-card h3 {
                        font-size: 22px;
                        font-weight: 800;
                        color: var(--text);
                        margin-bottom: 15px;
                    }

                    .menu-card p {
                        color: var(--text-light);
                        font-size: 15px;
                        line-height: 1.6;
                        margin-bottom: 30px;
                        flex-grow: 1;
                    }

                    .menu-card a {
                        align-self: flex-start;
                        background: linear-gradient(135deg, var(--primary) 0%, var(--primary2) 100%);
                        color: white;
                        padding: 12px 28px;
                        border-radius: 12px;
                        text-decoration: none;
                        font-weight: 700;
                        font-size: 15px;
                        transition: all 0.3s ease;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        box-shadow: 0 4px 12px rgba(56, 87, 174, 0.2);
                    }

                    .menu-card a:hover {
                        transform: translateX(5px);
                        box-shadow: 0 8px 20px rgba(56, 87, 174, 0.4);
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

                    @media (max-width: 768px) {
                        .profile-section {
                            grid-template-columns: 1fr;
                            text-align: center;
                            padding: 30px;
                        }

                        .profile-logo {
                            order: -1;
                        }

                        .profile-logo img,
                        .profile-logo .no-logo {
                            width: 150px;
                            height: 150px;
                            margin: 0 auto;
                        }

                        .profile-actions {
                            justify-content: center;
                        }

                        .welcome-section {
                            padding: 30px;
                        }

                        .welcome-section h2 {
                            font-size: 24px;
                        }
                    }
                </style>
            </head>

            <body>
                <!-- ✅ INCLURE LA NAVBAR -->

                <jsp:include page="navbar.jsp" />

                <div class="container">
                    <!-- ✅ SECTION PROFIL CLUB -->
                    <% if (user.getNomClub() !=null && !user.getNomClub().isEmpty()) { %>
                        <div class="profile-section">
                            <div class="profile-logo">
                                <% if (user.getLogoClub() !=null && !user.getLogoClub().isEmpty()) { %>
                                    <img src="assets/club-logos/<%= user.getLogoClub() %>"
                                        alt="Logo <%= user.getNomClub() %>">
                                    <% } else { %>
                                        <div class="no-logo"><i class="fas fa-university"></i></div>
                                        <% } %>
                            </div>

                            <div class="profile-info">
                                <h2>
                                    <%= user.getNomClub() %>
                                </h2>
                                <span class="club-badge"><i class="fas fa-user-graduate"></i> Club Universitaire
                                    Certifié</span>

                                <p><span class="label"><i class="fas fa-user-tie"></i> Président :</span>
                                    <%= user.getPrenom() %>
                                        <%= user.getNom() %>
                                </p>
                                <p><span class="label"><i class="fas fa-envelope"></i> Email Contact :</span>
                                    <%= user.getEmail() %>
                                </p>

                                <% if (user.getDescriptionClub() !=null && !user.getDescriptionClub().isEmpty()) { %>
                                    <div class="profile-description">
                                        <i class="fas fa-quote-left"></i>
                                        <%= user.getDescriptionClub() %>
                                    </div>
                                    <% } %>

                                        <div class="profile-actions">
                                            <a href="profil-club" class="btn-edit-profile">
                                                <i class="fas fa-edit"></i> Personnaliser mon Club
                                            </a>
                                        </div>
                            </div>
                        </div>
                        <% } %>

                            <!-- Section d'accueil -->
                            <div class="welcome-section">
                                <h2>Bienvenue <%= user.getPrenom() %>,</h2>
                                <p>C'est ici que commence l'organisation de vos prochaines activités universitaires.
                                    Réservez un espace pour vos formations, réunions de club ou événements majeurs.
                                    Notre plateforme centralisée facilite vos démarches administratives.</p>
                            </div>

                            <!-- Menu principal -->
                            <div class="menu-grid">
                                <div class="menu-card">
                                    <div class="menu-icon"><i class="fas fa-calendar-plus"></i></div>
                                    <h3>Réserver un Espace</h3>
                                    <p>Planifiez vos événements en réservant nos salles et amphithéâtres disponibles.
                                    </p>
                                    <a href="reservations?action=add">Nouvelle Demande <i
                                            class="fas fa-arrow-right"></i></a>
                                </div>

                                <div class="menu-card">
                                    <div class="menu-icon"><i class="fas fa-tasks"></i></div>
                                    <h3>Mes Événements</h3>
                                    <p>Suivez l'état de vos demandes de réservation et gérez votre planning d'activités.
                                    </p>
                                    <a href="reservations">Voir l'historique <i class="fas fa-arrow-right"></i></a>
                                </div>

                                <div class="menu-card">
                                    <div class="menu-icon"><i class="fas fa-search-location"></i></div>
                                    <h3>Consulter les Lieux</h3>
                                    <p>Découvrez tous les espaces universitaires disponibles au sein de l'institut.</p>
                                    <a href="reservation-salle">Voir le catalogue <i class="fas fa-arrow-right"></i></a>
                                </div>
                            </div>
                </div>
            </body>

            </html>