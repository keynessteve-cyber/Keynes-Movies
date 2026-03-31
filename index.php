<?php
require_once 'includes/config.php';
require_once 'includes/fonctions.php';

$sql = "SELECT * FROM films ORDER BY date_ajout DESC LIMIT 6";
$stmt = $pdo->query($sql);
$derniers_films = $stmt->fetchAll();

$sql = "SELECT * FROM films ORDER BY RAND() LIMIT 6";
$stmt = $pdo->query($sql);
$films_populaires = $stmt->fetchAll();

include 'includes/header.php';
?>

<div class="hero">
    <div class="container">
        <h1>🎬 Keynes Movies</h1>
        <p>Votre cinéma en ligne - Découvrez les meilleurs films</p>
        <p style="margin-top: 20px;">
            <a href="recherche.php" class="btn btn-primary">🔍 Rechercher un film</a>
        </p>
    </div>
</div>

<div class="container">
    <div class="search-bar" style="margin-bottom: 40px;">
        <form action="recherche.php" method="get" style="display: flex; gap: 10px;">
            <input type="text" name="q" placeholder="Rechercher par titre ou réalisateur..." 
                   style="flex: 1; padding: 12px; border: none; border-radius: 5px; font-size: 1rem;">
            <button type="submit" class="btn">Rechercher</button>
        </form>
    </div>
    
    <h2 class="section-title"> Derniers films ajoutés</h2>
    <div class="films-grid">
        <?php foreach($derniers_films as $film): ?>
            <?php afficherCarteFilm($film); ?>
        <?php endforeach; ?>
    </div>
    
    <h2 class="section-title"> Films populaires</h2>
    <div class="films-grid">
        <?php foreach($films_populaires as $film): ?>
            <?php afficherCarteFilm($film); ?>
        <?php endforeach; ?>
    </div>
    
    <h2 class="section-title">Par catégorie</h2>
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 15px; margin-bottom: 40px;">
        <a href="categorie.php?cat=action" class="btn" style="text-align: center;">⚡ Action</a>
        <a href="categorie.php?cat=drame" class="btn" style="text-align: center;">🎭 Drame</a>
        <a href="categorie.php?cat=comedie" class="btn" style="text-align: center;">😂 Comédie</a>
        <a href="categorie.php?cat=amour" class="btn" style="text-align: center;">💖 Amour</a>
        <a href="categorie.php?cat=aventure" class="btn" style="text-align: center;">🗺️ Aventure</a>
        <a href="categorie.php?cat=horreur" class="btn" style="text-align: center;">👻 Horreur</a>
    </div>
</div>

<?php
include 'includes/footer.php';
?>