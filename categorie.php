<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

$categorie = $_GET['cat'] ?? '';

$categories_valides = ['action', 'drame', 'comedie', 'amour', 'aventure', 'horreur'];

if(!in_array($categorie, $categories_valides)) {
    rediriger('index.php');
}

$noms_categories = [
    'action' => '⚡ Action',
    'drame' => '🎭 Drame',
    'comedie' => '😂 Comédie',
    'amour' => '💖 Amour',
    'aventure' => '🗺️ Aventure',
    'horreur' => '👻 Horreur'
];

$films = getFilmsParCategorie($pdo, $categorie);

include 'includes/header.php';
?>

<div class="container">
    <div style="margin-bottom: 30px;">
        <a href="index.php" class="btn" style="background: #666;">← Retour à l'accueil</a>
    </div>
    
    <h1 class="section-title" style="font-size: 2.5rem;">
        <?php echo $noms_categories[$categorie]; ?>
    </h1>
    
    <p style="text-align: center; color: white; margin-bottom: 40px;">
        <?php echo count($films); ?> films disponibles
    </p>
    
    <?php if(count($films) > 0): ?>
        <div class="films-grid">
            <?php foreach($films as $film): ?>
                <?php afficherCarteFilm($film); ?>
            <?php endforeach; ?>
        </div>
    <?php else: ?>
        <div class="error" style="text-align: center; background: #f8d7da; color: #721c24; padding: 20px; border-radius: 10px;">
            Aucun film trouvé dans cette catégorie.
        </div>
    <?php endif; ?>
</div>

<?php
include 'includes/footer.php';
?>