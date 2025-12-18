<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null ||
            !user.getRole().equals("admin")) { response.sendRedirect("login"); return; } // Récupérer les statistiques
            Integer totalUsers=(Integer) request.getAttribute("totalUsers"); Integer totalSalles=(Integer)
            request.getAttribute("totalSalles"); Integer totalReservations=(Integer)
            request.getAttribute("totalReservations"); Integer reservationsEnAttente=(Integer)
            request.getAttribute("reservationsEnAttente"); Integer reservationsValidees=(Integer)
            request.getAttribute("reservationsValidees"); Integer reservationsAnnulees=(Integer)
            request.getAttribute("reservationsAnnulees"); // Valeurs par défaut si null if (totalUsers==null)
            totalUsers=0; if (totalSalles==null) totalSalles=0; if (totalReservations==null) totalReservations=0; if
            (reservationsEnAttente==null) reservationsEnAttente=0; if (reservationsValidees==null)
            reservationsValidees=0; if (reservationsAnnulees==null) reservationsAnnulees=0; %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard Admin - Gestion des Réservations</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');

                    :root {
                        --bg: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                        --surface: #ffffff;
                        --text: #1a202c;
                        --text-light: #718096;
                        --border: #e2e8f0;
                        --shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
                        --shadow-sm: 0 4px 15px rgba(0, 0, 0, 0.08);
                        --gradient-1: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        --gradient-2: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                        --gradient-3: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                        --gradient-4: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
                        --gradient-5: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                        --gradient-6: linear-gradient(135deg, #30cfd0 0%, #330867 100%);
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
                        padding-bottom: 40px;
                    }

                    .dashboard-container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 30px 20px;
                    }

                    .dashboard-header {
                        background: rgba(255, 255, 255, 0.95);
                        backdrop-filter: blur(10px);
                        border-radius: 20px;
                        padding: 30px 40px;
                        margin-bottom: 30px;
                        box-shadow: var(--shadow);
                        animation: slideDown 0.6s ease-out;
                    }

                    .dashboard-header h1 {
                        font-size: 32px;
                        font-weight: 800;
                        background: var(--gradient-1);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        margin-bottom: 8px;
                    }

                    .dashboard-header p {
                        color: var(--text-light);
                        font-size: 16px;
                    }

                    .stats-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 25px;
                        margin-bottom: 30px;
                    }

                    .stat-card {
                        background: var(--surface);
                        border-radius: 20px;
                        padding: 30px;
                        box-shadow: var(--shadow);
                        position: relative;
                        overflow: hidden;
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        animation: fadeInUp 0.6s ease-out backwards;
                    }

                    .stat-card:nth-child(1) {
                        animation-delay: 0.1s;
                    }

                    .stat-card:nth-child(2) {
                        animation-delay: 0.2s;
                    }

                    .stat-card:nth-child(3) {
                        animation-delay: 0.3s;
                    }

                    .stat-card:nth-child(4) {
                        animation-delay: 0.4s;
                    }

                    .stat-card:nth-child(5) {
                        animation-delay: 0.5s;
                    }

                    .stat-card:nth-child(6) {
                        animation-delay: 0.6s;
                    }

                    .stat-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        height: 5px;
                        background: var(--gradient);
                    }

                    .stat-card.purple::before {
                        background: var(--gradient-1);
                    }

                    .stat-card.pink::before {
                        background: var(--gradient-2);
                    }

                    .stat-card.blue::before {
                        background: var(--gradient-3);
                    }

                    .stat-card.green::before {
                        background: var(--gradient-4);
                    }

                    .stat-card.orange::before {
                        background: var(--gradient-5);
                    }

                    .stat-card.teal::before {
                        background: var(--gradient-6);
                    }

                    .stat-card:hover {
                        transform: translateY(-10px) scale(1.02);
                        box-shadow: 0 25px 70px rgba(0, 0, 0, 0.2);
                    }

                    .stat-icon {
                        width: 60px;
                        height: 60px;
                        border-radius: 15px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 28px;
                        color: white;
                        margin-bottom: 20px;
                        background: var(--gradient);
                    }

                    .stat-card.purple .stat-icon {
                        background: var(--gradient-1);
                    }

                    .stat-card.pink .stat-icon {
                        background: var(--gradient-2);
                    }

                    .stat-card.blue .stat-icon {
                        background: var(--gradient-3);
                    }

                    .stat-card.green .stat-icon {
                        background: var(--gradient-4);
                    }

                    .stat-card.orange .stat-icon {
                        background: var(--gradient-5);
                    }

                    .stat-card.teal .stat-icon {
                        background: var(--gradient-6);
                    }

                    .stat-value {
                        font-size: 42px;
                        font-weight: 800;
                        color: var(--text);
                        margin-bottom: 8px;
                        line-height: 1;
                    }

                    .stat-label {
                        font-size: 15px;
                        color: var(--text-light);
                        font-weight: 500;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .quick-actions {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 25px;
                    }

                    .action-card {
                        background: var(--surface);
                        border-radius: 20px;
                        padding: 35px;
                        box-shadow: var(--shadow);
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        position: relative;
                        overflow: hidden;
                        animation: fadeInUp 0.6s ease-out backwards;
                    }

                    .action-card:nth-child(1) {
                        animation-delay: 0.7s;
                    }

                    .action-card:nth-child(2) {
                        animation-delay: 0.8s;
                    }

                    .action-card:nth-child(3) {
                        animation-delay: 0.9s;
                    }

                    .action-card::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -50%;
                        width: 200%;
                        height: 200%;
                        background: var(--gradient);
                        opacity: 0.05;
                        border-radius: 50%;
                        transition: all 0.6s ease;
                        pointer-events: none;
                        /* Ne pas bloquer les clics */
                        z-index: 0;
                    }

                    .action-card:hover::before {
                        top: -60%;
                        right: -60%;
                        opacity: 0.1;
                    }

                    .action-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 25px 70px rgba(0, 0, 0, 0.2);
                    }

                    .action-card h3 {
                        font-size: 22px;
                        font-weight: 700;
                        color: var(--text);
                        margin-bottom: 15px;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        position: relative;
                        z-index: 1;
                    }

                    .action-card h3 i {
                        font-size: 28px;
                        background: var(--gradient);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                    }

                    .action-card p {
                        color: var(--text-light);
                        margin-bottom: 25px;
                        line-height: 1.6;
                        position: relative;
                        z-index: 1;
                    }

                    .action-btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 10px;
                        background: var(--gradient);
                        color: white;
                        padding: 14px 28px;
                        border-radius: 12px;
                        text-decoration: none;
                        font-weight: 600;
                        font-size: 15px;
                        transition: all 0.3s ease;
                        box-shadow: var(--shadow-sm);
                        position: relative;
                        z-index: 2;
                        /* Au-dessus du ::before */
                        cursor: pointer;
                    }

                    .action-btn:hover {
                        transform: translateX(5px);
                        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                    }

                    .action-card:nth-child(1) h3 i,
                    .action-card:nth-child(1) .action-btn {
                        background: var(--gradient-1);
                    }

                    .action-card:nth-child(2) h3 i,
                    .action-card:nth-child(2) .action-btn {
                        background: var(--gradient-3);
                    }

                    .action-card:nth-child(3) h3 i,
                    .action-card:nth-child(3) .action-btn {
                        background: var(--gradient-2);
                    }

                    @keyframes slideDown {
                        from {
                            opacity: 0;
                            transform: translateY(-30px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
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

                    /* Responsive */
                    @media (max-width: 768px) {
                        .dashboard-header h1 {
                            font-size: 24px;
                        }

                        .stats-grid,
                        .quick-actions {
                            grid-template-columns: 1fr;
                        }

                        .stat-value {
                            font-size: 32px;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="navbar.jsp" />

                <div class="dashboard-container">
                    <!-- Header -->
                    <div class="dashboard-header">
                        <h1><i class="fas fa-university"></i> Tableau de Bord - Administration Universitaire</h1>
                        <p>Bienvenue <%= user.getPrenom() %>
                                <%= user.getNom() %> - Gestion centralisée des réservations des clubs universitaires</p>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">
                                <i class="fas fa-door-open"></i>
                            </div>
                            <div class="stat-value">
                                <%= totalSalles %>
                            </div>
                            <div class="stat-label">Salles & Amphithéâtres</div>
                        </div>

                        <div class="stat-card pink">
                            <div class="stat-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <div class="stat-value">
                                <%= totalReservations %>
                            </div>
                            <div class="stat-label">Réservations Totales</div>
                        </div>

                        <div class="stat-card orange">
                            <div class="stat-icon">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-value">
                                <%= reservationsEnAttente %>
                            </div>
                            <div class="stat-label">En Attente de Validation</div>
                        </div>

                        <div class="stat-card green">
                            <div class="stat-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-value">
                                <%= reservationsValidees %>
                            </div>
                            <div class="stat-label">Événements Validés</div>
                        </div>

                        <div class="stat-card teal">
                            <div class="stat-icon">
                                <i class="fas fa-ban"></i>
                            </div>
                            <div class="stat-value">
                                <%= reservationsAnnulees %>
                            </div>
                            <div class="stat-label">Annulées</div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <div class="action-card">
                            <h3><i class="fas fa-user-graduate"></i> Gérer les Clubs</h3>
                            <p>Administrer les comptes des présidents de clubs universitaires</p>
                            <a href="${pageContext.request.contextPath}/users" class="action-btn">
                                Accéder <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>

                        <div class="action-card">
                            <h3><i class="fas fa-building"></i> Gérer les Espaces</h3>
                            <p>Administrer les salles et amphithéâtres disponibles pour les événements</p>
                            <a href="${pageContext.request.contextPath}/salles" class="action-btn">
                                Accéder <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>

                        <div class="action-card">
                            <h3><i class="fas fa-tasks"></i> Valider les Demandes</h3>
                            <p>Approuver ou refuser les demandes de réservation des clubs</p>
                            <a href="${pageContext.request.contextPath}/adminReservations" class="action-btn">
                                Accéder <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </body>

            </html>