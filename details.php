<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

$id = $_GET['id'] ?? 0;

$film = getFilmById($pdo, $id);

if(!$film) {
    rediriger('index.php');
}

$imageUrl = $film['image'];
if(strpos($imageUrl, 'http') === 0) {
    $imageSrc = $imageUrl;
} else {
    $imageSrc = BASE_URL . $imageUrl;
}

$bandeAnnonce = !empty($film['bande_annonce']) ? $film['bande_annonce'] : null;

$autres_films = getFilmsParRealisateur($pdo, $film['realisateur']);

$message = '';
if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['ajouter_panier'])) {
    if(estConnecte()) {
        if(ajouterAuPanier($pdo, $_SESSION['user_id'], $film['id'])) {
            $message = '<div class="success">✅ Film ajouté au panier !</div>';
        } else {
            $message = '<div class="error">❌ Erreur lors de l\'ajout au panier.</div>';
        }
    } else {
        $message = '<div class="error">🔑 Veuillez vous connecter pour ajouter au panier.</div>';
    }
}

include 'includes/header.php';
?>

<div class="container">
    <div style="margin-bottom: 35px;">
        <a href="javascript:history.back()" class="btn" style="background: #666; padding: 10px 20px; border-radius: 6px;">← Retour</a>
    </div>
    
    <?php echo $message; ?>
    
    <div class="film-detail" style="display: grid; grid-template-columns: 320px 1fr; gap: 50px; background: #1f1f1f; border-radius: 16px; padding: 35px; margin-bottom: 50px;">
        <div class="film-image">
            <img src="<?php echo $imageSrc; ?>" alt="<?php echo nettoyer($film['titre']); ?>" style="width: 100%; border-radius: 12px; box-shadow: 0 8px 20px rgba(0,0,0,0.3);">
        </div>
        
        <div class="film-info-detail">
            <h1 style="font-size: 2rem; margin-bottom: 25px; color: #e50914;"><?php echo nettoyer($film['titre']); ?></h1>
            
            <div class="info" style="display: flex; flex-direction: column; gap: 18px; font-size: 1rem; line-height: 1.5;">
                <p style="margin: 0;"><strong style="color: #e50914;"> Réalisateur :</strong> 
                    <a href="recherche.php?q=<?php echo urlencode($film['realisateur']); ?>" style="color: #ff6b6b; text-decoration: none;">
                        <?php echo nettoyer($film['realisateur']); ?>
                    </a>
                </p>
                
                <p style="margin: 0;"><strong style="color: #e50914;">🎭 Catégorie :</strong> 
                    <a href="categorie.php?cat=<?php echo $film['categorie']; ?>" style="color: #ff6b6b; text-decoration: none;">
                        <?php 
                        $noms = ['action'=>'Action', 'drame'=>'Drame', 'comedie'=>'Comédie', 
                                 'amour'=>'Amour', 'aventure'=>'Aventure', 'horreur'=>'Horreur'];
                        echo $noms[$film['categorie']];
                        ?>
                    </a>
                </p>
                
                <p style="margin: 0;"><strong style="color: #e50914;">Date de sortie :</strong> 
                    <span style="color: #fff;"><?php echo !empty($film['date_sortie']) ? date('d/m/Y', strtotime($film['date_sortie'])) : 'Non disponible'; ?></span>
                </p>
                
                <p style="margin: 0;"><strong style="color: #e50914;"> Note :</strong> 
                    <span style="color: #fff;"><?php echo !empty($film['note']) ? $film['note'] . '/10' : 'Non disponible'; ?></span>
                </p>
                
                <p style="margin: 0;"><strong style="color: #e50914;">Durée :</strong> 
                    <span style="color: #fff;"><?php echo !empty($film['duree']) ? $film['duree'] . ' minutes' : 'Non disponible'; ?></span>
                </p>
                
                <p style="margin: 0;"><strong style="color: #e50914;">Acteurs :</strong> <span style="color: #fff;"><?php echo nettoyer($film['acteurs']); ?></span></p>
                
                <p style="margin: 0;"><strong style="color: #e50914;"> Prix :</strong> <span style="font-size: 1.8rem; font-weight: bold; color: #ff6b6b;"><?php echo number_format($film['prix'], 2); ?> €</span></p>
                
                <div style="margin-top: 10px;">
                    <p style="margin: 0 0 10px 0;"><strong style="color: #e50914;"> Description :</strong></p>
                    <p class="description-text" style="margin: 0; line-height: 1.6; color: #ccc;"><?php echo nl2br(nettoyer($film['description'])); ?></p>
                </div>
            </div>
            
            <?php if($bandeAnnonce): ?>
            <div style="margin: 35px 0 25px 0;">
                <h3 style="margin-bottom: 15px; font-size: 1.2rem; color: #e50914;"> Bande-annonce</h3>
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; max-width: 100%;">
                    <iframe 
                        src="<?php echo $bandeAnnonce; ?>" 
                        style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen>
                    </iframe>
                </div>
            </div>
            <?php endif; ?>
            
            <form method="POST" action="" style="margin-top: 35px;">
                <button type="submit" name="ajouter_panier" class="btn btn-primary" style="font-size: 1.1rem; padding: 14px 35px; border-radius: 8px; cursor: pointer; transition: all 0.3s;">
                    🛒 Ajouter au panier - <?php echo number_format($film['prix'], 2); ?> €
                </button>
            </form>
        </div>
    </div>
    
    <?php if(count($autres_films) > 1): ?>
        <div style="margin-top: 60px;">
            <h2 class="section-title" style="font-size: 1.6rem; margin-bottom: 30px; color: #e50914;"> Autres films de <?php echo nettoyer($film['realisateur']); ?></h2>
            <div class="films-grid">
                <?php foreach($autres_films as $autre): ?>
                    <?php if($autre['id'] != $film['id']): ?>
                        <?php afficherCarteFilm($autre); ?>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>
</div>

<style>
body.light-mode .film-detail {
    background: white !important;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

body.light-mode .film-info-detail .info p {
    color: #333;
}

body.light-mode .film-info-detail .info p strong {
    color: #e50914 !important;
}

body.light-mode .film-info-detail .info div p {
    color: #555;
}

body.light-mode .film-info-detail .info p span {
    color: #333 !important;
}

body.light-mode .film-info-detail .info p a {
    color: #e50914 !important;
}

body.light-mode .description-text {
    color: #333 !important;
}

body:not(.light-mode) .description-text {
    color: #ccc !important;
}

body:not(.light-mode) .film-detail {
    background: #1f1f1f;
}

@media (max-width: 768px) {
    .film-detail {
        grid-template-columns: 1fr !important;
        gap: 30px !important;
        padding: 25px !important;
    }
    
    .film-image {
        max-width: 280px;
        margin: 0 auto;
    }
    
    .film-info-detail h1 {
        font-size: 1.6rem !important;
        text-align: center;
    }
    
    .info {
        text-align: center;
    }
    
    .btn-primary {
        width: 100%;
    }
}
</style>

<?php
include 'includes/footer.php';
?>