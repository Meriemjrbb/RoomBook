# 📋 Rapport des Fonctionnalités - Application de Gestion de Réservations de Salles

## 🏗️ Architecture du Projet

### Structure des Beans (Modèle de données)

#### 1. **Utilisateur** (`beans.Utilisateur`)
- **Champs principaux** :
  - `id` : Identifiant unique
  - `nom`, `prenom` : Informations personnelles
  - `email`, `password` : Authentification
  - `role` : "user" ou "admin"
  - `nomClub`, `descriptionClub`, `logoClub` : Informations du club (pour les présidents de clubs)

#### 2. **Salle** (`beans.Salle`)
- **Champs** :
  - `id` : Identifiant unique
  - `nom` : Nom de la salle
  - `capacite` : Capacité de la salle

#### 3. **Reservation** (`beans.Reservation`)
- **Champs** :
  - `id` : Identifiant unique
  - `dateReservation` : Date de la réservation
  - `heureDebut`, `heureFin` : Horaires de la réservation
  - `status` : "en attente" | "validée" | "annulée"
  - `utilisateurId` : Clé étrangère vers l'utilisateur
  - `salleId` : Clé étrangère vers la salle

---

## 🌐 Servlets et Routes

### 1. **Authentification**

#### `/login` - LoginServlet
- **GET** : Affiche la page de connexion
- **POST** : Traite la connexion utilisateur
  - Validation de l'email et du mot de passe
  - Création de session utilisateur
  - Redirection selon le rôle :
    - Admin → `/adminDashboard`
    - User → `/accueil`

#### `/logout` - LogoutServlet
- Déconnexion et destruction de la session

---

### 2. **Pages Utilisateur (User)**

#### `/accueil` - AccueilServlet
- Page d'accueil pour les utilisateurs authentifiés
- Affichage du profil club si disponible
- Menu d'accès aux fonctionnalités

#### `/reservations` - ReservationServlet
- **GET** : Liste des réservations de l'utilisateur
- **Actions** :
  - `action=add` : Formulaire de nouvelle réservation
  - `action=cancel` : Annulation d'une réservation

#### `/reservation-salle` - ReservationSalleServlet
- Affichage des salles disponibles
- Formulaire de réservation de salle

#### `/profil-club` - profilClubServlet
- Gestion du profil du club universitaire
- Modification des informations du club
- Upload du logo

---

### 3. **Administration (Admin)**

#### `/adminDashboard` - AdminDashboardServlet
- Tableau de bord administrateur
- Vue d'ensemble des fonctionnalités d'administration

#### `/users` - UtilisateurServlet
- **GET** : Liste de tous les utilisateurs
- **Actions CRUD** :
  - `action=add` : Ajouter un utilisateur
  - `action=edit` : Modifier un utilisateur
  - `action=delete` : Supprimer un utilisateur

#### `/salles` - SalleServlet
- **GET** : Liste de toutes les salles
- **Actions CRUD** :
  - `action=add` : Ajouter une salle
  - `action=edit` : Modifier une salle
  - `action=delete` : Supprimer une salle

#### `/adminReservations` - AdminReservationServlet
- Gestion de toutes les réservations
- **Actions** :
  - Visualiser toutes les réservations
  - Valider une réservation
  - Annuler une réservation

---

## 📄 Pages JSP

### Pages Utilisateur
1. **accueil.jsp** - Page d'accueil avec profil club
2. **mesReservations.jsp** - Mes réservations
3. **reserverSalle.jsp** - Réservation de salle
4. **listeSalles.jsp** - Liste des salles disponibles
5. **profilClub.jsp** - Gestion du profil club

### Pages Admin
1. **dashboard.jsp** - Tableau de bord admin
2. **gestionUtilisateurs.jsp** - Gestion des utilisateurs
3. **gestionSalles.jsp** - Gestion des salles
4. **gestionReservations.jsp** - Gestion des réservations
5. **ajouterUtilisateur.jsp** - Formulaire d'ajout d'utilisateur
6. **ajouterSalle.jsp** - Formulaire d'ajout de salle

### Pages Communes
1. **login.jsp** - Page de connexion
2. **navbar.jsp** - Barre de navigation (incluse dans toutes les pages)

---

## 🔐 Gestion des Rôles

### Utilisateur Normal (role="user")
✅ **Accès autorisé** :
- Page d'accueil
- Réserver une salle
- Consulter mes réservations
- Annuler mes réservations
- Gérer mon profil club

❌ **Accès refusé** :
- Tableau de bord admin
- Gestion des utilisateurs
- Gestion des salles
- Validation des réservations

### Administrateur (role="admin")
✅ **Accès complet** :
- Tableau de bord admin
- CRUD utilisateurs
- CRUD salles
- Gestion de toutes les réservations
- Validation/Annulation des réservations

---

## 🎨 Design et Interface

### Palette de couleurs
- **Gradient principal** : Linear-gradient(135deg, #667eea 0%, #764ba2 100%)
- **Fond** : #f5f5f5
- **Cartes** : White avec shadow 0 2px 10px rgba(0, 0, 0, 0.1)

### Composants communs
- **Navbar** : Incluse via `navbar.jsp`
- **Cartes interactives** : Effet hover avec translateY
- **Boutons** : Gradient avec transitions

---

## 📊 Base de Données (DAO)

### UtilisateurDAO
- `login(email, password)` : Authentification
- `getAllUtilisateurs()` : Liste de tous les utilisateurs
- `addUtilisateur(utilisateur)` : Ajouter un utilisateur
- `updateUtilisateur(utilisateur)` : Modifier un utilisateur
- `deleteUtilisateur(id)` : Supprimer un utilisateur

### SalleDAO
- `getAllSalles()` : Liste de toutes les salles
- `addSalle(salle)` : Ajouter une salle
- `updateSalle(salle)` : Modifier une salle
- `deleteSalle(id)` : Supprimer une salle

### ReservationDAO
- `getReservationsByUser(userId)` : Réservations d'un utilisateur
- `getAllReservations()` : Toutes les réservations
- `addReservation(reservation)` : Nouvelle réservation
- `updateReservation(reservation)` : Modifier une réservation
- `deleteReservation(id)` : Supprimer une réservation

---

## 🔧 Utilitaires

### ValidationUtil
- `isValidEmail(email)` : Validation de format email

### DBConnection
- Gestion de la connexion à la base de données

---

## 📝 Fonctionnalités Principales

### Pour les Utilisateurs
1. ✅ Authentification sécurisée
2. ✅ Réservation de salles
3. ✅ Consultation de mes réservations
4. ✅ Annulation de réservations
5. ✅ Gestion du profil club (nom, description, logo)
6. ✅ Consultation des salles disponibles

### Pour les Administrateurs
1. ✅ Gestion complète des utilisateurs (CRUD)
2. ✅ Gestion complète des salles (CRUD)
3. ✅ Validation des réservations
4. ✅ Annulation des réservations
5. ✅ Vue d'ensemble de toutes les réservations
6. ✅ Tableau de bord avec statistiques

---

## 🚀 Points Forts du Projet
- Architecture MVC propre et organisée
- Séparation claire des rôles (User/Admin)
- Interface moderne avec design premium
- Validation des données côté serveur
- Gestion de session sécurisée
- Support complet CRUD pour toutes les entités
