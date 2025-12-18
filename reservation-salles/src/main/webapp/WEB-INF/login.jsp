<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Connexion - Plateforme de Réservation des Clubs Universitaires</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                position: relative;
                overflow: hidden;
            }

            /* Animated background elements */
            body::before,
            body::after {
                content: '';
                position: absolute;
                border-radius: 50%;
                opacity: 0.1;
                animation: float 20s infinite ease-in-out;
            }

            body::before {
                width: 400px;
                height: 400px;
                background: white;
                top: -100px;
                left: -100px;
                animation-delay: 0s;
            }

            body::after {
                width: 300px;
                height: 300px;
                background: white;
                bottom: -50px;
                right: -50px;
                animation-delay: 5s;
            }

            @keyframes float {

                0%,
                100% {
                    transform: translate(0, 0) scale(1);
                }

                33% {
                    transform: translate(30px, -30px) scale(1.1);
                }

                66% {
                    transform: translate(-20px, 20px) scale(0.9);
                }
            }

            .login-wrapper {
                position: relative;
                z-index: 1;
                width: 100%;
                max-width: 1000px;
                display: grid;
                grid-template-columns: 1fr 1fr;
                background: white;
                border-radius: 24px;
                overflow: hidden;
                box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
            }

            /* Left side - Branding */
            .login-branding {
                background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                padding: 60px 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                color: white;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .login-branding::before {
                content: '';
                position: absolute;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
                top: -50%;
                left: -50%;
                animation: rotate 30s linear infinite;
            }

            @keyframes rotate {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(360deg);
                }
            }

            .branding-content {
                position: relative;
                z-index: 1;
            }

            .branding-logo {
                width: 120px;
                height: 120px;
                margin: 0 auto 30px;
                background: white;
                border-radius: 20px;
                padding: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                animation: float-logo 3s ease-in-out infinite;
            }

            .branding-logo img {
                width: 100%;
                height: 100%;
                object-fit: contain;
            }

            @keyframes float-logo {

                0%,
                100% {
                    transform: translateY(0px);
                }

                50% {
                    transform: translateY(-10px);
                }
            }

            .branding-icon {
                font-size: 80px;
                margin-bottom: 30px;
                animation: bounce 2s infinite;
            }

            @keyframes bounce {

                0%,
                100% {
                    transform: translateY(0);
                }

                50% {
                    transform: translateY(-10px);
                }
            }

            .branding-content h1 {
                font-size: 32px;
                font-weight: 800;
                margin-bottom: 20px;
                line-height: 1.2;
            }

            .branding-content p {
                font-size: 16px;
                line-height: 1.6;
                opacity: 0.95;
                margin-bottom: 15px;
            }

            .branding-features {
                margin-top: 40px;
                text-align: left;
            }

            .feature-item {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 20px;
                font-size: 15px;
            }

            .feature-item i {
                font-size: 24px;
                background: rgba(255, 255, 255, 0.2);
                padding: 12px;
                border-radius: 12px;
            }

            /* Right side - Login form */
            .login-form-container {
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-header {
                margin-bottom: 40px;
            }

            .login-header h2 {
                font-size: 28px;
                font-weight: 800;
                color: #1a202c;
                margin-bottom: 10px;
            }

            .login-header p {
                color: #718096;
                font-size: 15px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 10px;
                color: #2d3748;
                font-weight: 600;
                font-size: 14px;
            }

            .input-wrapper {
                position: relative;
            }

            .input-wrapper i {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #a0aec0;
                font-size: 16px;
            }

            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 14px 16px 14px 48px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 15px;
                font-family: 'Inter', sans-serif;
                transition: all 0.3s ease;
                background: #f7fafc;
            }

            input[type="email"]:focus,
            input[type="password"]:focus {
                outline: none;
                border-color: #3857ae;
                background: white;
                box-shadow: 0 0 0 4px rgba(56, 87, 174, 0.1);
            }

            .btn-login {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
                box-shadow: 0 4px 15px rgba(56, 87, 174, 0.4);
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(56, 87, 174, 0.5);
            }

            .btn-login:active {
                transform: translateY(0);
            }

            .error {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #991b1b;
                padding: 16px;
                border-radius: 12px;
                margin-bottom: 25px;
                border-left: 4px solid #dc2626;
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 14px;
                font-weight: 500;
            }

            .error i {
                font-size: 20px;
            }

            .login-footer {
                margin-top: 30px;
                text-align: center;
                color: #718096;
                font-size: 13px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .login-wrapper {
                    grid-template-columns: 1fr;
                    max-width: 450px;
                }

                .login-branding {
                    padding: 40px 30px;
                }

                .branding-icon {
                    font-size: 60px;
                }

                .branding-content h1 {
                    font-size: 24px;
                }

                .branding-features {
                    display: none;
                }

                .login-form-container {
                    padding: 40px 30px;
                }
            }
        </style>
    </head>

    <body>
        <div class="login-wrapper">
            <!-- Left Side - Branding -->
            <div class="login-branding">
                <div class="branding-content">
                    <div class="branding-logo">
                        <img src="assets/institut.png" alt="Logo Institut">
                    </div>
                    <h1>Plateforme de Réservation<br>Clubs Universitaires</h1>
                    <p>Organisez vos événements, formations en toute simplicité</p>

                    <div class="branding-features">
                        <div class="feature-item">
                            <i class="fas fa-calendar-check"></i>
                            <span>Réservation rapide et efficace</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-users"></i>
                            <span>Gestion centralisée des clubs</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-door-open"></i>
                            <span>Salles et amphithéâtres disponibles</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Side - Login Form -->
            <div class="login-form-container">
                <div class="login-header">
                    <h2>Bienvenue !</h2>
                    <p>Connectez-vous pour gérer vos réservations</p>
                </div>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>
                            <%= request.getAttribute("error") %>
                        </span>
                    </div>
                    <% } %>

                        <form method="POST" action="login">
                            <div class="form-group">
                                <label for="email">Adresse email</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" id="email" name="email" placeholder="votre.email@universite.ma"
                                        required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password">Mot de passe</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="password" name="password" placeholder="••••••••"
                                        required>
                                </div>
                            </div>

                            <button type="submit" class="btn-login">
                                <i class="fas fa-sign-in-alt"></i> Se connecter
                            </button>
                        </form>

                        <div class="login-footer">
                            <p><i class="fas fa-shield-alt"></i> Plateforme sécurisée pour les clubs universitaires</p>
                        </div>
            </div>
        </div>
    </body>

    </html>