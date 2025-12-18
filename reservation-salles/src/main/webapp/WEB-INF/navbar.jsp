<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="beans.Utilisateur" %>
        <% Utilisateur currentUser=(Utilisateur) session.getAttribute("user"); String
            currentPage=request.getServletPath(); boolean isAdmin=currentUser !=null && "admin"
            .equals(currentUser.getRole()); %>

            <!-- Font Awesome pour les icônes -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

            <style>
                :root {
                    --nb-bg-start: #0f172a;   /* slate-900 */
                    --nb-bg-end: #1e3a8a;     /* indigo-900 */
                    --nb-surface: rgba(255, 255, 255, 0.10);
                    --nb-surface-2: rgba(255, 255, 255, 0.16);
                    --nb-text: #ffffff;
                    --nb-shadow: 0 10px 30px rgba(2, 6, 23, 0.25);
                }
                /* ========== NAVBAR MODERNE ========== */
                .modern-navbar {
                    background: linear-gradient(135deg, var(--nb-bg-start) 0%, var(--nb-bg-end) 100%);
                    box-shadow: var(--nb-shadow);
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    transition: all 0.3s ease;
                }

                .modern-navbar.scrolled {
                    box-shadow: 0 14px 40px rgba(2, 6, 23, 0.35);
                }

                .navbar-container {
                    max-width: 1400px;
                    margin: 0 auto;
                    padding: 0 30px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    min-height: 70px;
                }

                /* ===== LOGO ===== */
                .navbar-logo {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    text-decoration: none;
                    color: white;
                    font-size: 22px;
                    font-weight: 700;
                    transition: transform 0.3s ease;
                }

                .navbar-logo:hover {
                    transform: scale(1.05);
                }

                .navbar-logo img {
                    height: 38px;
                    width: auto;
                    border-radius: 6px;
                    background: white;
                    padding: 2px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.25);
                }

                @keyframes pulse {

                    0%,
                    100% {
                        transform: scale(1);
                    }

                    50% {
                        transform: scale(1.1);
                    }
                }

                .navbar-logo span {
                    background: linear-gradient(to right, #fff, #e0e7ff);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                /* ===== NAVIGATION LINKS ===== */
                .navbar-links {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    list-style: none;
                    margin: 0;
                    padding: 0;
                }

                .navbar-links li {
                    position: relative;
                }

                .navbar-links a,
                .navbar-links button {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    padding: 10px 18px;
                    color: white;
                    text-decoration: none;
                    font-weight: 500;
                    font-size: 15px;
                    border-radius: 8px;
                    transition: all 0.3s ease;
                    background: transparent;
                    border: none;
                    cursor: pointer;
                    position: relative;
                    overflow: hidden;
                }

                .navbar-links a::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: -100%;
                    width: 100%;
                    height: 100%;
                    background: var(--nb-surface);
                    transition: left 0.3s ease;
                    z-index: -1;
                }

                .navbar-links a:hover::before {
                    left: 0;
                }

                .navbar-links a:hover,
                .navbar-links button:hover {
                    background: var(--nb-surface-2);
                    transform: translateY(-2px);
                }

                .navbar-links a.active {
                    background: rgba(255, 255, 255, 0.22);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
                }

                .navbar-links a i,
                .navbar-links button i {
                    font-size: 16px;
                }

                /* ===== USER INFO ===== */
                .navbar-user {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .user-avatar {
                    width: 42px;
                    height: 42px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, #fde68a, #f59e0b);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 700;
                    color: #2d3436;
                    font-size: 18px;
                    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
                    transition: transform 0.3s ease;
                }

                .user-avatar:hover {
                    transform: rotate(360deg) scale(1.1);
                }

                .user-info {
                    display: flex;
                    flex-direction: column;
                    align-items: flex-start;
                }

                .user-name {
                    font-weight: 600;
                    color: white;
                    font-size: 15px;
                }

                .user-role {
                    font-size: 12px;
                    padding: 2px 8px;
                    border-radius: 10px;
                    font-weight: 600;
                    margin-top: 2px;
                }

                .user-role.admin {
                    background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
                    color: white;
                }

                .user-role.user {
                    background: linear-gradient(135deg, #48dbfb, #0abde3);
                    color: white;
                }

                /* ===== LOGOUT BUTTON ===== */
                .logout-btn {
                    background: rgba(255, 107, 107, 0.9);
                    color: white;
                    border: none;
                    padding: 10px 18px;
                    border-radius: 8px;
                    cursor: pointer;
                    font-weight: 600;
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    transition: all 0.3s ease;
                    box-shadow: 0 3px 10px rgba(255, 107, 107, 0.3);
                }

                .logout-btn:hover {
                    background: rgba(255, 107, 107, 1);
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
                }

                /* ===== MOBILE MENU TOGGLE ===== */
                .menu-toggle {
                    display: none;
                    flex-direction: column;
                    gap: 5px;
                    background: transparent;
                    border: none;
                    cursor: pointer;
                    padding: 8px;
                }

                .menu-toggle span {
                    width: 28px;
                    height: 3px;
                    background: white;
                    border-radius: 3px;
                    transition: all 0.3s ease;
                }

                .menu-toggle.active span:nth-child(1) {
                    transform: rotate(45deg) translate(8px, 8px);
                }

                .menu-toggle.active span:nth-child(2) {
                    opacity: 0;
                }

                .menu-toggle.active span:nth-child(3) {
                    transform: rotate(-45deg) translate(8px, -8px);
                }

                /* ===== RESPONSIVE ===== */
                @media (max-width: 1024px) {
                    .navbar-container {
                        padding: 0 20px;
                    }

                    .navbar-links {
                        gap: 5px;
                    }

                    .navbar-links a,
                    .navbar-links button {
                        padding: 8px 14px;
                        font-size: 14px;
                    }

                    .user-info {
                        display: none;
                    }
                }

                @media (max-width: 768px) {
                    .menu-toggle {
                        display: flex;
                    }

                    .navbar-links {
                        position: absolute;
                        top: 70px;
                        left: 0;
                        right: 0;
                        background: linear-gradient(135deg, var(--nb-bg-start) 0%, var(--nb-bg-end) 100%);
                        flex-direction: column;
                        gap: 0;
                        padding: 15px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                        transform: translateY(-100%);
                        opacity: 0;
                        visibility: hidden;
                        transition: all 0.3s ease;
                    }

                    .navbar-links.active {
                        transform: translateY(0);
                        opacity: 1;
                        visibility: visible;
                    }

                    .navbar-links li {
                        width: 100%;
                    }

                    .navbar-links a,
                    .navbar-links button {
                        width: 100%;
                        justify-content: flex-start;
                        padding: 15px 20px;
                        border-radius: 8px;
                    }

                    .navbar-user {
                        gap: 10px;
                    }

                    .logout-btn {
                        padding: 8px 14px;
                        font-size: 13px;
                    }
                }

                /* ===== BADGE NOTIFICATION ===== */
                .nav-badge {
                    position: absolute;
                    top: 5px;
                    right: 5px;
                    background: #ff6b6b;
                    color: white;
                    border-radius: 50%;
                    width: 18px;
                    height: 18px;
                    font-size: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: 700;
                    animation: bounce 1s infinite;
                }

                @keyframes bounce {

                    0%,
                    100% {
                        transform: translateY(0);
                    }

                    50% {
                        transform: translateY(-5px);
                    }
                }
            </style>

            <nav class="modern-navbar" id="navbar">
                <div class="navbar-container">
                    <!-- LOGO -->
                    <a href="<%= isAdmin ? " adminDashboard" : "accueil" %>" class="navbar-logo">
                        <img src="assets/institut.png" alt="Institut" />
                        <span>RoomBook</span>
                    </a>

                    <!-- MOBILE MENU TOGGLE -->
                    <button class="menu-toggle" id="menuToggle" onclick="toggleMobileMenu()">
                        <span></span>
                        <span></span>
                        <span></span>
                    </button>

                    <!-- NAVIGATION LINKS -->
                    <ul class="navbar-links" id="navbarLinks">
                        <% if (isAdmin) { %>
                            <!-- ADMIN MENU -->
                            <li>
                                <a href="adminDashboard" class="<%= currentPage.startsWith(" /adminDashboard")
                                    ? "active" : "" %>">
                                    <i class="fas fa-chart-line"></i>
                                    <span>Tableau de bord</span>
                                </a>
                            </li>
                            <li>
                                <a href="users" class="<%= currentPage.startsWith(" /users") ? "active" : "" %>">
                                    <i class="fas fa-users"></i>
                                    <span>Utilisateurs</span>
                                </a>
                            </li>
                            <li>
                                <a href="salles" class="<%= currentPage.startsWith(" /salles") ? "active" : "" %>">
                                    <i class="fas fa-door-open"></i>
                                    <span>Salles</span>
                                </a>
                            </li>
                            <li>
                                <a href="adminReservations" class="<%= currentPage.startsWith(" /adminReservations")
                                    ? "active" : "" %>">
                                    <i class="fas fa-calendar-check"></i>
                                    <span>Réservations</span>
                                </a>
                            </li>
                            <% } else { %>
                                <!-- USER MENU -->
                                <li>
                                    <a href="accueil" class="<%= currentPage.startsWith(" /accueil") ? "active" : ""
                                        %>">
                                        <i class="fas fa-home"></i>
                                        <span>Accueil</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="reservation-salle" class="<%= currentPage.startsWith(" /reservation-salle")
                                        ? "active" : "" %>">
                                        <i class="fas fa-search"></i>
                                        <span>Salles disponibles</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="reservations" class="<%= currentPage.startsWith(" /reservations")
                                        ? "active" : "" %>">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Mes réservations</span>
                                    </a>
                                </li>
                                <% if (currentUser !=null && currentUser.getNomClub() !=null &&
                                    !currentUser.getNomClub().isEmpty()) { %>
                                    <li>
                                        <a href="profil-club" class="<%= currentPage.startsWith(" /profil-club")
                                            ? "active" : "" %>">
                                            <i class="fas fa-user-circle"></i>
                                            <span>Mon Club</span>
                                        </a>
                                    </li>
                                    <% } %>
                                        <% } %>
                    </ul>

                    <!-- USER INFO + LOGOUT -->
                    <div class="navbar-user">
                        <% if (currentUser !=null) { %>
                            <div class="user-avatar">
                                <%= currentUser.getPrenom().substring(0, 1).toUpperCase() %>
                                    <%= currentUser.getNom().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="user-info">
                                <div class="user-name">
                                    <%= currentUser.getPrenom() %>
                                        <%= currentUser.getNom() %>
                                </div>
                                <span class="user-role <%= isAdmin ? " admin" : "user" %>">
                                    <%= isAdmin ? "<i class='fas fa-crown'></i> Administrateur" : "<i class='fas fa-user'></i> Utilisateur" %>
                                </span>
                            </div>
                            <% } %>
                                <form action="logout" method="get" style="margin: 0;">
                                    <button type="submit" class="logout-btn">
                                        <i class="fas fa-sign-out-alt"></i>
                                        <span>Déconnexion</span>
                                    </button>
                                </form>
                    </div>
                </div>
            </nav>

            <script>
                // Mobile menu toggle
                function toggleMobileMenu() {
                    const navbarLinks = document.getElementById('navbarLinks');
                    const menuToggle = document.getElementById('menuToggle');
                    navbarLinks.classList.toggle('active');
                    menuToggle.classList.toggle('active');
                }

                // Navbar scroll effect
                window.addEventListener('scroll', function () {
                    const navbar = document.getElementById('navbar');
                    if (window.scrollY > 50) {
                        navbar.classList.add('scrolled');
                    } else {
                        navbar.classList.remove('scrolled');
                    }
                });

                // Close mobile menu when clicking outside
                document.addEventListener('click', function (event) {
                    const navbarLinks = document.getElementById('navbarLinks');
                    const menuToggle = document.getElementById('menuToggle');
                    const navbar = document.querySelector('.modern-navbar');

                    if (!navbar.contains(event.target) && navbarLinks.classList.contains('active')) {
                        navbarLinks.classList.remove('active');
                        menuToggle.classList.remove('active');
                    }
                });

                // Close mobile menu when clicking on a link
                const navLinks = document.querySelectorAll('.navbar-links a');
                navLinks.forEach(link => {
                    link.addEventListener('click', function () {
                        const navbarLinks = document.getElementById('navbarLinks');
                        const menuToggle = document.getElementById('menuToggle');
                        if (window.innerWidth <= 768) {
                            navbarLinks.classList.remove('active');
                            menuToggle.classList.remove('active');
                        }
                    });
                });
            </script>