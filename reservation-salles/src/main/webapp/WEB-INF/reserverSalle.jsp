<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List, beans.Salle, beans.Utilisateur" %>
        <% Utilisateur user=(Utilisateur) session.getAttribute("user"); if (user==null) {
            response.sendRedirect("login"); return; } @SuppressWarnings("unchecked") List<Salle> sallesDisponibles =
            (List<Salle>) request.getAttribute("sallesDisponibles");
                String date = (String) request.getAttribute("date");
                String heureDebut = (String) request.getAttribute("heureDebut");
                String heureFin = (String) request.getAttribute("heureFin");
                %>
                <!DOCTYPE html>
                <html lang="fr">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Planifier un Événement - Club Universitaire</title>
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
                            min-height: 100vh;
                            color: var(--text);
                        }

                        .container {
                            max-width: 650px;
                            margin: 60px auto;
                            background: var(--surface);
                            padding: 50px;
                            border-radius: 24px;
                            box-shadow: var(--shadow);
                            border: 1px solid rgba(255, 255, 255, 0.1);
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

                        h1 {
                            font-size: 28px;
                            font-weight: 800;
                            background: linear-gradient(135deg, #3857ae 0%, #1d2e57 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                        }

                        .step-indicator {
                            display: flex;
                            justify-content: center;
                            gap: 15px;
                            margin-bottom: 30px;
                        }

                        .step {
                            width: 40px;
                            height: 8px;
                            border-radius: 4px;
                            background: #e2e8f0;
                        }

                        .step.active {
                            background: var(--primary);
                        }

                        .form-group {
                            margin-bottom: 25px;
                        }

                        label {
                            display: block;
                            margin-bottom: 10px;
                            color: var(--text);
                            font-weight: 700;
                            font-size: 15px;
                        }

                        .input-wrapper {
                            position: relative;
                        }

                        .input-wrapper i {
                            position: absolute;
                            left: 18px;
                            top: 50%;
                            transform: translateY(-50%);
                            color: #94a3b8;
                            font-size: 16px;
                        }

                        input,
                        select {
                            width: 100%;
                            padding: 16px 16px 16px 52px;
                            border: 2px solid #f1f5f9;
                            border-radius: 12px;
                            font-size: 15px;
                            font-family: inherit;
                            background: #f8fafc;
                            transition: all 0.3s ease;
                        }

                        input:focus,
                        select:focus {
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
                            margin-top: 10px;
                            box-shadow: 0 10px 25px rgba(56, 87, 174, 0.4);
                        }

                        .btn-submit:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 15px 35px rgba(56, 87, 174, 0.5);
                        }

                        .btn-back {
                            display: inline-flex;
                            align-items: center;
                            gap: 8px;
                            color: var(--text-light);
                            text-decoration: none;
                            font-weight: 600;
                            margin-bottom: 30px;
                            transition: color 0.3s;
                        }

                        .btn-back:hover {
                            color: var(--primary);
                        }

                        .error {
                            background: #fee2e2;
                            color: #b91c1c;
                            padding: 16px;
                            border-radius: 12px;
                            margin-bottom: 30px;
                            border-left: 4px solid #ef4444;
                            display: flex;
                            align-items: center;
                            gap: 12px;
                            font-weight: 600;
                        }

                        .selection-summary {
                            background: #f1f5f9;
                            padding: 20px;
                            border-radius: 12px;
                            margin-bottom: 30px;
                            border: 1px dashed #cbd5e1;
                        }

                        .selection-summary p {
                            color: #475569;
                            font-size: 14px;
                            margin-bottom: 5px;
                        }

                        .selection-summary strong {
                            color: var(--text);
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="navbar.jsp" />

                    <div class="container">
                        <a href="reservations" class="btn-back"><i class="fas fa-arrow-left"></i> Retour à mes
                            événements</a>

                        <div class="header">
                            <div class="header-icon"><i class="fas fa-calendar-plus"></i></div>
                            <h1>Organiser un Nouvel Événement</h1>
                        </div>

                        <div class="step-indicator">
                            <div class="step active"></div>
                            <div class="step <%= (sallesDisponibles != null) ? " active" : "" %>"></div>
                        </div>

                        <% if (request.getAttribute("erreur") !=null) { %>
                            <div class="error">
                                <i class="fas fa-exclamation-triangle"></i>
                                <%= request.getAttribute("erreur") %>
                            </div>
                            <% } %>

                                <% if (sallesDisponibles==null) { %>
                                    <!-- Formulaire de sélection de créneau -->
                                    <form method="GET" action="reservations">
                                        <input type="hidden" name="action" value="check">

                                        <div class="form-group">
                                            <label for="date">Date de l'événement</label>
                                            <div class="input-wrapper">
                                                <i class="fas fa-calendar"></i>
                                                <input type="date" id="date" name="date" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="heureDebut">Heure de début</label>
                                            <div class="input-wrapper">
                                                <i class="fas fa-clock"></i>
                                                <input type="time" id="heureDebut" name="heureDebut" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="heureFin">Heure de fin</label>
                                            <div class="input-wrapper">
                                                <i class="fas fa-hourglass-end"></i>
                                                <input type="time" id="heureFin" name="heureFin" required>
                                            </div>
                                        </div>

                                        <button type="submit" class="btn-submit">
                                            Chercher un Espace Disponible <i class="fas fa-search"></i>
                                        </button>
                                    </form>
                                    <% } else { %>
                                        <!-- Affichage des salles disponibles -->
                                        <div class="selection-summary">
                                            <p><i class="fas fa-info-circle"></i> Créneau souhaité :</p>
                                            <strong>Le <%= date %> de <%= heureDebut %> à <%= heureFin %></strong>
                                        </div>

                                        <% if (sallesDisponibles.isEmpty()) { %>
                                            <div class="error" style="background: #fff1f2;">
                                                <i class="fas fa-times-circle"></i> Malheureusement, aucun espace n'est
                                                disponible pour ce créneau.
                                            </div>
                                            <a href="reservations?action=add" class="btn-submit"
                                                style="text-align: center; text-decoration: none; background: #94a3b8;">
                                                Changer d'horaire
                                            </a>
                                            <% } else { %>
                                                <form method="POST" action="reservations">
                                                    <div class="form-group">
                                                        <label for="salleId">Espace de l'Institut</label>
                                                        <div class="input-wrapper">
                                                            <i class="fas fa-door-open"></i>
                                                            <select id="salleId" name="salleId" required>
                                                                <option value="">-- Choisir une salle ou amphi --
                                                                </option>
                                                                <% for (Salle s : sallesDisponibles) { %>
                                                                    <option value="<%= s.getId() %>">
                                                                        <%= s.getNom() %> (<%= s.getCapacite() %>
                                                                                places)
                                                                    </option>
                                                                    <% } %>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <input type="hidden" name="date" value="<%= date %>">
                                                    <input type="hidden" name="heureDebut" value="<%= heureDebut %>">
                                                    <input type="hidden" name="heureFin" value="<%= heureFin %>">

                                                    <button type="submit" class="btn-submit">
                                                        Confirmer la demande <i class="fas fa-check-circle"></i>
                                                    </button>
                                                </form>
                                                <% } %>
                                                    <% } %>
                    </div>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var dateInput = document.getElementById('date');

                            if (dateInput) {
                                var today = new Date();
                                var dd = String(today.getDate()).padStart(2, '0');
                                var mm = String(today.getMonth() + 1).padStart(2, '0');
                                var yyyy = today.getFullYear();
                                var todayString = yyyy + '-' + mm + '-' + dd;

                                dateInput.setAttribute('min', todayString);

                                dateInput.addEventListener('change', function () {
                                    if (this.value < todayString) {
                                        this.value = '';
                                    }
                                });
                            }
                        });
                    </script>
                </body>

                </html>