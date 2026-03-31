<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

if(estConnecte()) {
    rediriger('index.php');
}

$erreur = '';
$succes = '';

if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nom = trim($_POST['nom'] ?? '');
    $email = trim($_POST['email'] ?? '');
    $mot_de_passe = $_POST['mot_de_passe'] ?? '';
    $confirmer = $_POST['confirmer'] ?? '';
    
    if(empty($nom) || empty($email) || empty($mot_de_passe)) {
        $erreur = 'Tous les champs sont obligatoires.';
    } elseif(!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $erreur = 'Email invalide.';
    } elseif(strlen($mot_de_passe) < 4) {
        $erreur = 'Le mot de passe doit contenir au moins 4 caractères.';
    } elseif($mot_de_passe !== $confirmer) {
        $erreur = 'Les mots de passe ne correspondent pas.';
    } else {
        $sql = "SELECT id FROM utilisateurs WHERE email = :email";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['email' => $email]);
        
        if($stmt->fetch()) {
            $erreur = 'Cet email est déjà utilisé.';
        } else {
            $hash = password_hash($mot_de_passe, PASSWORD_DEFAULT);
            
            $sql = "INSERT INTO utilisateurs (nom, email, mot_de_passe) VALUES (:nom, :email, :mdp)";
            $stmt = $pdo->prepare($sql);
            
            if($stmt->execute(['nom' => $nom, 'email' => $email, 'mdp' => $hash])) {
                $succes = 'Inscription réussie ! Vous pouvez maintenant vous connecter.';
            } else {
                $erreur = 'Erreur lors de l\'inscription.';
            }
        }
    }
}

include 'includes/header.php';
?>

<div class="container">
    <div class="form-container">
        <h2> Inscription</h2>
        
        <?php if($erreur): ?>
            <div class="error"><?php echo $erreur; ?></div>
        <?php endif; ?>
        
        <?php if($succes): ?>
            <div class="success">
                <?php echo $succes; ?>
                <p style="margin-top: 10px;"><a href="connexion.php">Se connecter</a></p>
            </div>
        <?php else: ?>
            <form method="POST" action="">
                <div class="form-group">
                    <label>Nom complet *</label>
                    <input type="text" name="nom" required value="<?php echo htmlspecialchars($_POST['nom'] ?? ''); ?>">
                </div>
                
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" required value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>">
                </div>
                
                <div class="form-group">
                    <label>Mot de passe * (min 4 caractères)</label>
                    <input type="password" name="mot_de_passe" required>
                </div>
                
                <div class="form-group">
                    <label>Confirmer le mot de passe *</label>
                    <input type="password" name="confirmer" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%;">S'inscrire</button>
            </form>
            
            <p style="text-align: center; margin-top: 20px;">
                Déjà inscrit ? <a href="connexion.php">Se connecter</a>
            </p>
        <?php endif; ?>
    </div>
</div>

<?php
include 'includes/footer.php';
?>