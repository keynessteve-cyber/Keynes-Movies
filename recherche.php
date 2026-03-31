<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

$mot_recherche = $_GET['q'] ?? '';
$films = [];

if(!empty($mot_recherche)) {
    $films = rechercherFilms($pdo, $mot_recherche);
}

include 'includes/header.php';
?>

<div class="container">
    <h1 class="section-title">🔍 Recherche de films</h1>
    
    <div style="max-width: 600px; margin: 0 auto 40px auto;">
        <form action="recherche.php" method="get" style="display: flex; gap: 10px;">
            <input type="text" name="q" placeholder="Titre ou réalisateur..." 
                   value="<?php echo htmlspecialchars($mot_recherche); ?>"
                   style="flex: 1; padding: 12px; border: none; border-radius: 5px; font-size: 1rem;">
            <button type="submit" class="btn">Rechercher</button>
        </form>
    </div>
    
    <?php if(!empty($mot_recherche)): ?>
        <p style="text-align: center; color: white; margin-bottom: 30px;">
            🔎 Résultats pour <strong>"<?php echo htmlspecialchars($mot_recherche); ?>"</strong> : 
            <?php echo count($films); ?> film(s) trouvé(s)
        </p>
        
        <?php if(count($films) > 0): ?>
            <div class="films-grid">
                <?php foreach($films as $film): ?>
                    <?php afficherCarteFilm($film); ?>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <div class="error" style="text-align: center; background: #f8d7da; color: #721c24; padding: 20px; border-radius: 10px;">
                Aucun film trouvé pour "<?php echo htmlspecialchars($mot_recherche); ?>".
                <p style="margin-top: 10px;">Essayez avec un autre mot-clé.</p>
            </div>
        <?php endif; ?>
    <?php else: ?>
        <div style="text-align: center; color: white; padding: 40px;">
            <p>Entrez un titre ou un nom de réalisateur pour commencer votre recherche.</p>
            <p style="margin-top: 20px;">Exemples : Nolan, Spielberg, Inception, Titanic...</p>
        </div>
    <?php endif; ?>
</div>

<?php
include 'includes/footer.php';
?>