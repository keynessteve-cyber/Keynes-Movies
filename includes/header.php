<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Keynes Movies - Votre cinéma en ligne</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="includes/theme.js" defer></script>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo-cinema">
                <img src="Logo Keynes Movies.jpeg" alt="Keynes Movies" class="logo-image">
                <span class="logo-text">Keynes Movies</span>
            </div>
            
            <nav>
                <ul>
                    <li><a href="index.php">Accueil</a></li>
                    <li class="dropdown">
                        <a href="#">Catégories ▼</a>
                        <ul class="dropdown-menu" >
                            <li><a href="categorie.php?cat=action">⚡ Action</a></li>
                            <li><a href="categorie.php?cat=drame">🎭 Drame</a></li>
                            <li><a href="categorie.php?cat=comedie">😂 Comédie</a></li>
                            <li><a href="categorie.php?cat=amour">💖 Amour</a></li>
                            <li><a href="categorie.php?cat=aventure">🗺️ Aventure</a></li>
                            <li><a href="categorie.php?cat=horreur">👻 Horreur</a></li>
                        </ul>
                    </li>
                    <li><a href="recherche.php">🔍 Recherche</a></li>
                    <?php if(isset($_SESSION['user_id'])): 
                        $sql_avatar = "SELECT avatar FROM utilisateurs WHERE id = :id";
                        $stmt_avatar = $pdo->prepare($sql_avatar);
                        $stmt_avatar->execute(['id' => $_SESSION['user_id']]);
                        $user_avatar = $stmt_avatar->fetch();
                        $avatar_img = $user_avatar['avatar'] ?? null;
                    ?>
                        <li><a href="panier.php">🛒 Panier</a></li>
                        <li class="user-menu">
                            <a href="profil.php" class="user-profile">
                                <?php if($avatar_img && file_exists($avatar_img)): ?>
                                    <img src="<?php echo BASE_URL . $avatar_img; ?>" alt="Avatar" class="nav-avatar">
                                <?php else: ?>
                                    <span class="nav-avatar-placeholder">👤</span>
                                <?php endif; ?>
                                <?php echo htmlspecialchars($_SESSION['user_nom']); ?>
                            </a>
                        </li>
                        <li><a href="deconnexion.php"> Déconnexion</a></li>
                    <?php else: ?>
                        <li><a href="connexion.php"> Connexion</a></li>
                        <li><a href="inscription.php">Inscription</a></li>
                    <?php endif; ?>
                    <li><button id="theme-toggle" class="theme-btn" onclick="changerTheme()">☀️ Mode clair</button></li>
                </ul>
            </nav>
        </div>
    </header>
    
    <main>