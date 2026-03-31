<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

if(!estConnecte()) {
    $message = '<div class="error">🔑 Vous devez être connecté pour accéder à votre panier.</div>';
    include 'includes/header.php';
    echo '<div class="container">' . $message . '<p style="text-align: center;"><a href="connexion.php" class="btn">Se connecter</a></p></div>';
    include 'includes/footer.php';
    exit();
}

$userId = $_SESSION['user_id'];
$message = '';

if(isset($_POST['supprimer'])) {
    $panierId = $_POST['panier_id'];
    if(supprimerDuPanier($pdo, $userId, $panierId)) {
        $message = '<div class="success">✅ Film retiré du panier.</div>';
    }
}

if(isset($_POST['vider'])) {
    if(viderPanier($pdo, $userId)) {
        $message = '<div class="success">✅ Panier vidé.</div>';
    }
}

if(isset($_POST['acheter'])) {
    if(finaliserAchat($pdo, $userId)) {
        $message = '<div class="success">🎉 Achat effectué avec succès ! Merci pour votre commande.</div>';
    } else {
        $message = '<div class="error">❌ Votre panier est vide.</div>';
    }
}

$panier = getPanier($pdo, $userId);
$total = getTotalPanier($pdo, $userId);

include 'includes/header.php';
?>

<div class="container">
    <h1 class="section-title">🛒 Mon panier</h1>
    
    <?php echo $message; ?>
    
    <div class="panier-container">
        <?php if(count($panier) > 0): ?>
            <?php foreach($panier as $item): ?>
                <div class="panier-item">
                    <div style="display: flex; align-items: center; gap: 15px; flex: 2;">
                        <img src="<?php 
                            $imgUrl = $item['image'];
                            if(strpos($imgUrl, 'http') === 0) {
                                echo $imgUrl;
                            } else {
                                echo BASE_URL . $imgUrl;
                            }
                        ?>" alt="<?php echo nettoyer($item['titre']); ?>" style="width: 60px; height: 90px; object-fit: cover; border-radius: 5px;">
                        <div>
                            <strong><?php echo nettoyer($item['titre']); ?></strong>
                            <br>
                            <small style="color: #666;">Quantité: <?php echo $item['quantite']; ?></small>
                        </div>
                    </div>
                    <div style="flex: 1; text-align: right;">
                        <strong><?php echo number_format($item['prix'] * $item['quantite'], 2); ?> €</strong>
                    </div>
                    <div>
                        <form method="POST" action="" style="display: inline;">
                            <input type="hidden" name="panier_id" value="<?php echo $item['id']; ?>">
                            <button type="submit" name="supprimer" class="btn btn-danger" style="padding: 5px 10px; font-size: 0.8rem;">Supprimer</button>
                        </form>
                    </div>
                </div>
            <?php endforeach; ?>
            
            <div class="panier-total">
                <strong>Total : <?php echo number_format($total, 2); ?> €</strong>
            </div>
            
            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 20px;">
                <form method="POST" action="">
                    <button type="submit" name="vider" class="btn btn-danger">Vider le panier</button>
                </form>
                <form method="POST" action="">
                    <button type="submit" name="acheter" class="btn btn-success">Acheter maintenant</button>
                </form>
            </div>
        <?php else: ?>
            <div style="text-align: center; padding: 60px;">
                <p style="font-size: 1.2rem; color: #666;">🛍️ Votre panier est vide.</p>
                <p style="margin-top: 20px;"><a href="index.php" class="btn">Découvrir nos films</a></p>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php
include 'includes/footer.php';
?>