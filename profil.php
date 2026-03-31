<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

if(!estConnecte()) {
    $message = '<div class="error">🔑 Vous devez être connecté pour accéder à votre profil.</div>';
    include 'includes/header.php';
    echo '<div class="container">' . $message . '<p style="text-align: center;"><a href="connexion.php" class="btn">Se connecter</a></p></div>';
    include 'includes/footer.php';
    exit();
}

$userId = $_SESSION['user_id'];
$userNom = $_SESSION['user_nom'];
$userEmail = $_SESSION['user_email'];
$message = '';
$erreur = '';

$sql = "SELECT avatar FROM utilisateurs WHERE id = :id";
$stmt = $pdo->prepare($sql);
$stmt->execute(['id' => $userId]);
$user = $stmt->fetch();
$avatar = $user['avatar'] ?? null;

if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['upload_avatar'])) {
    if(isset($_FILES['avatar']) && $_FILES['avatar']['error'] !== UPLOAD_ERR_NO_FILE) {
        $resultat = uploadAvatar($_FILES['avatar'], $userId);
        
        if(strpos($resultat, 'uploads/') === 0) {
            $sql = "UPDATE utilisateurs SET avatar = :avatar WHERE id = :id";
            $stmt = $pdo->prepare($sql);
            if($stmt->execute(['avatar' => $resultat, 'id' => $userId])) {
                $avatar = $resultat;
                $message = '✅ Avatar modifié avec succès !';
                header("Refresh:0");
            } else {
                $erreur = 'Erreur lors de l\'enregistrement en base.';
            }
        } else {
            $erreur = $resultat;
        }
    } else {
        $erreur = 'Veuillez sélectionner une image.';
    }
}

if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['supprimer_avatar'])) {
    if($avatar && file_exists("C:/wamp64/www/Keynes_Movies/" . $avatar)) {
        unlink("C:/wamp64/www/Keynes_Movies/" . $avatar);
    }
    $sql = "UPDATE utilisateurs SET avatar = NULL WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    if($stmt->execute(['id' => $userId])) {
        $avatar = null;
        $message = '🗑️ Avatar supprimé avec succès.';
        header("Refresh:0");
    } else {
        $erreur = 'Erreur lors de la suppression.';
    }
}

if($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['changer_mdp'])) {
    $ancien = $_POST['ancien_mdp'] ?? '';
    $nouveau = $_POST['nouveau_mdp'] ?? '';
    $confirmer = $_POST['confirmer_mdp'] ?? '';
    
    $sql = "SELECT mot_de_passe FROM utilisateurs WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $userId]);
    $user = $stmt->fetch();
    
    if(!password_verify($ancien, $user['mot_de_passe'])) {
        $erreur = 'Ancien mot de passe incorrect.';
    } elseif(strlen($nouveau) < 4) {
        $erreur = 'Le nouveau mot de passe doit contenir au moins 4 caractères.';
    } elseif($nouveau !== $confirmer) {
        $erreur = 'Les nouveaux mots de passe ne correspondent pas.';
    } else {
        $hash = password_hash($nouveau, PASSWORD_DEFAULT);
        $sql = "UPDATE utilisateurs SET mot_de_passe = :mdp WHERE id = :id";
        $stmt = $pdo->prepare($sql);
        if($stmt->execute(['mdp' => $hash, 'id' => $userId])) {
            $message = '✅ Mot de passe modifié avec succès !';
        } else {
            $erreur = 'Erreur lors de la modification.';
        }
    }
}

$achats = getAchats($pdo, $userId);

include 'includes/header.php';
?>

<div class="container">
    <h1 class="section-title">👤 Mon profil</h1>
    
    <?php if($message): ?>
        <div class="success"><?php echo $message; ?></div>
    <?php endif; ?>
    
    <?php if($erreur): ?>
        <div class="error"><?php echo $erreur; ?></div>
    <?php endif; ?>
    
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 30px;">
        
        <div class="form-container" style="margin: 0;">
            <div style="text-align: center; margin-bottom: 20px;">
                <?php if($avatar && file_exists("C:/wamp64/www/Keynes_Movies/" . $avatar)): ?>
                    <img src="<?php echo BASE_URL . $avatar; ?>" alt="Avatar" 
                         style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; border: 3px solid #e50914;">
                <?php else: ?>
                    <div style="width: 150px; height: 150px; border-radius: 50%; background: #2a2a2a; margin: 0 auto; display: flex; align-items: center; justify-content: center; border: 3px solid #e50914;">
                        <span style="font-size: 3rem;">👤</span>
                    </div>
                <?php endif; ?>
                <h2 style="margin-top: 15px;"><?php echo nettoyer($userNom); ?></h2>
                <p><?php echo nettoyer($userEmail); ?></p>
            </div>
            
            <hr style="margin: 20px 0; border-color: #333;">
            
            <h3>📸 Changer d'avatar</h3>
            <form method="POST" action="" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Image de profil (JPG, PNG, GIF, WEBP - max 2MB)</label>
                    <input type="file" name="avatar" accept="image/jpeg,image/png,image/gif,image/webp" required>
                </div>
                <button type="submit" name="upload_avatar" class="btn btn-primary" style="width: 100%;"> Mettre à jour l'avatar</button>
            </form>
            
            <?php if($avatar): ?>
            <form method="POST" action="" style="margin-top: 10px;">
                <button type="submit" name="supprimer_avatar" class="btn btn-danger" style="width: 100%;" onclick="return confirm('Supprimer votre avatar ?')">Supprimer l'avatar</button>
            </form>
            <?php endif; ?>
            
            <hr style="margin: 20px 0; border-color: #333;">
            
            <div>
                <p><strong>📅 Membre depuis :</strong> <?php 
                    $sql = "SELECT date_inscription FROM utilisateurs WHERE id = :id";
                    $stmt = $pdo->prepare($sql);
                    $stmt->execute(['id' => $userId]);
                    $user = $stmt->fetch();
                    echo date('d/m/Y', strtotime($user['date_inscription']));
                ?></p>
            </div>
            
            <div style="margin-top: 20px;">
                <a href="deconnexion.php" class="btn btn-danger" style="width: 100%; text-align: center;">Se déconnecter</a>
            </div>
        </div>
        
        <div class="form-container" style="margin: 0;">
            <h2>🔒 Changer mon mot de passe</h2>
            
            <form method="POST" action="">
                <div class="form-group">
                    <label>Ancien mot de passe *</label>
                    <input type="password" name="ancien_mdp" required>
                </div>
                
                <div class="form-group">
                    <label>Nouveau mot de passe * (min 4 caractères)</label>
                    <input type="password" name="nouveau_mdp" required>
                </div>
                
                <div class="form-group">
                    <label>Confirmer le nouveau mot de passe *</label>
                    <input type="password" name="confirmer_mdp" required>
                </div>
                
                <button type="submit" name="changer_mdp" class="btn btn-primary" style="width: 100%;">Modifier</button>
            </form>
        </div>
    </div>
    
    <div style="margin-top: 40px;">
        <h2 class="section-title">Mes films achetés</h2>
        
        <?php if(count($achats) > 0): ?>
            <div class="films-grid">
                <?php foreach($achats as $achat): ?>
                    <div class="film-card">
                        <img src="<?php 
                            $imgUrl = $achat['image'];
                            if(strpos($imgUrl, 'http') === 0) {
                                echo $imgUrl;
                            } else {
                                echo BASE_URL . $imgUrl;
                            }
                        ?>" alt="<?php echo nettoyer($achat['titre']); ?>">
                        <div class="film-info">
                            <h3><?php echo nettoyer($achat['titre']); ?></h3>
                            <p class="realisateur">🎬 <?php echo nettoyer($achat['realisateur']); ?></p>
                            <p class="prix"><?php echo number_format($achat['prix'], 2); ?> €</p>
                            <p><small>Acheté le <?php echo date('d/m/Y', strtotime($achat['date_achat'])); ?></small></p>
                            <a href="details.php?id=<?php echo $achat['film_id']; ?>" class="btn">Voir détails</a>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php else: ?>
            <div style="text-align: center; background: #1f1f1f; padding: 40px; border-radius: 10px;">
                <p>📭 Vous n'avez pas encore acheté de films.</p>
                <p style="margin-top: 10px;"><a href="index.php" class="btn">Découvrir nos films</a></p>
            </div>
        <?php endif; ?>
    </div>
</div>

<?php
include 'includes/footer.php';
?>