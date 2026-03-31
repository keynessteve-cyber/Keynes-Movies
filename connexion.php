<?php

require_once 'includes/config.php';
require_once 'includes/fonctions.php';

if(estConnecte()) {
    rediriger('index.php');
}

$erreur = '';

if($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $mot_de_passe = $_POST['mot_de_passe'] ?? '';
    
    if(empty($email) || empty($mot_de_passe)) {
        $erreur = 'Veuillez remplir tous les champs.';
    } else {
        $sql = "SELECT id, nom, email, mot_de_passe FROM utilisateurs WHERE email = :email";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['email' => $email]);
        $user = $stmt->fetch();
        
        if($user && password_verify($mot_de_passe, $user['mot_de_passe'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_nom'] = $user['nom'];
            $_SESSION['user_email'] = $user['email'];
            
            rediriger('index.php');
        } else {
            $erreur = 'Email ou mot de passe incorrect.';
        }
    }
}

include 'includes/header.php';
?>

<div class="container">
    <div class="form-container">
        <h2> Connexion</h2>
        
        <?php if($erreur): ?>
            <div class="error"><?php echo $erreur; ?></div>
        <?php endif; ?>
        
        <form method="POST" action="">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>">
            </div>
            
            <div class="form-group">
                <label>Mot de passe</label>
                <input type="password" name="mot_de_passe" required>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%;">Se connecter</button>
        </form>
        
        <p style="text-align: center; margin-top: 20px;">
            Pas encore inscrit ? <a href="inscription.php">Créer un compte</a>
        </p>
        
        </p>
    </div>
</div>

<?php
include 'includes/footer.php';
?>