<?php
function estConnecte() {
    return isset($_SESSION['user_id']);
}

function rediriger($page) {
    header("Location: " . BASE_URL . $page);
    exit();
}

function nettoyer($donnee) {
    return htmlspecialchars($donnee, ENT_QUOTES, 'UTF-8');
}

function getFilmsParCategorie($pdo, $categorie) {
    $sql = "SELECT * FROM films WHERE categorie = :categorie ORDER BY titre";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['categorie' => $categorie]);
    return $stmt->fetchAll();
}

function getFilmById($pdo, $id) {
    $sql = "SELECT * FROM films WHERE id = :id";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['id' => $id]);
    return $stmt->fetch();
}

function getFilmsParRealisateur($pdo, $realisateur) {
    $sql = "SELECT * FROM films WHERE realisateur = :realisateur ORDER BY titre";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['realisateur' => $realisateur]);
    return $stmt->fetchAll();
}

function rechercherFilms($pdo, $mot) {
    $mot = "%$mot%";
    $sql = "SELECT * FROM films WHERE titre LIKE :mot OR realisateur LIKE :mot ORDER BY titre";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['mot' => $mot]);
    return $stmt->fetchAll();
}

function getPanier($pdo, $userId) {
    $sql = "SELECT p.*, f.titre, f.prix, f.image 
            FROM panier p 
            JOIN films f ON p.film_id = f.id 
            WHERE p.utilisateur_id = :userId";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId]);
    return $stmt->fetchAll();
}

function getTotalPanier($pdo, $userId) {
    $sql = "SELECT SUM(f.prix * p.quantite) as total 
            FROM panier p 
            JOIN films f ON p.film_id = f.id 
            WHERE p.utilisateur_id = :userId";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId]);
    $result = $stmt->fetch();
    return $result['total'] ?? 0;
}

function ajouterAuPanier($pdo, $userId, $filmId) {
    $sql = "SELECT id FROM panier WHERE utilisateur_id = :userId AND film_id = :filmId";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId, 'filmId' => $filmId]);
    
    if($stmt->fetch()) {
        $sql = "UPDATE panier SET quantite = quantite + 1 
                WHERE utilisateur_id = :userId AND film_id = :filmId";
    } else {
        $sql = "INSERT INTO panier (utilisateur_id, film_id) VALUES (:userId, :filmId)";
    }
    
    $stmt = $pdo->prepare($sql);
    return $stmt->execute(['userId' => $userId, 'filmId' => $filmId]);
}

function supprimerDuPanier($pdo, $userId, $panierId) {
    $sql = "DELETE FROM panier WHERE id = :panierId AND utilisateur_id = :userId";
    $stmt = $pdo->prepare($sql);
    return $stmt->execute(['panierId' => $panierId, 'userId' => $userId]);
}

function viderPanier($pdo, $userId) {
    $sql = "DELETE FROM panier WHERE utilisateur_id = :userId";
    $stmt = $pdo->prepare($sql);
    return $stmt->execute(['userId' => $userId]);
}

function finaliserAchat($pdo, $userId) {
    $panier = getPanier($pdo, $userId);
    
    if(empty($panier)) {
        return false;
    }
    
    $sql = "INSERT INTO achats (utilisateur_id, film_id) VALUES (:userId, :filmId)";
    $stmt = $pdo->prepare($sql);
    
    foreach($panier as $item) {
        $stmt->execute(['userId' => $userId, 'filmId' => $item['film_id']]);
    }
    
    viderPanier($pdo, $userId);
    
    return true;
}

function getAchats($pdo, $userId) {
    $sql = "SELECT a.*, f.titre, f.image, f.prix, f.realisateur 
            FROM achats a 
            JOIN films f ON a.film_id = f.id 
            WHERE a.utilisateur_id = :userId 
            ORDER BY a.date_achat DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute(['userId' => $userId]);
    return $stmt->fetchAll();
}

function afficherCarteFilm($film) {
    $imageUrl = $film['image'];
    
    if(strpos($imageUrl, 'http') === 0) {
        $imageSrc = $imageUrl;
    } else {
        $imageSrc = BASE_URL . $imageUrl;
    }
    ?>
    <div class="film-card">
        <img src="<?php echo $imageSrc; ?>" alt="<?php echo nettoyer($film['titre']); ?>">
        <div class="film-info">
            <h3><?php echo nettoyer($film['titre']); ?></h3>
            <p class="realisateur">🎬 <?php echo nettoyer($film['realisateur']); ?></p>
            <p class="prix"> <?php echo number_format($film['prix'], 2); ?> €</p>
            <a href="details.php?id=<?php echo $film['id']; ?>" class="btn">Voir détails</a>
        </div>
    </div>
    <?php
}

function uploadAvatar($file, $userId) {
    $targetDir = "C:/wamp64/www/Keynes_Movies/uploads/avatars/";
    
    if(!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }
    
    $allowed = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    
    if($file['error'] !== UPLOAD_ERR_OK) {
        return "Erreur lors du téléchargement du fichier.";
    }
    
    $extension = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if(!in_array($extension, $allowed)) {
        return "Format non autorisé. Utilisez JPG, PNG, GIF ou WEBP.";
    }
    
    if($file['size'] > 2 * 1024 * 1024) {
        return "Le fichier est trop volumineux (max 2MB).";
    }
    
    $newName = "user_" . $userId . "_" . time() . "." . $extension;
    $targetPath = $targetDir . $newName;
    
    $relativePath = "uploads/avatars/" . $newName;
    
    if(move_uploaded_file($file['tmp_name'], $targetPath)) {
        return $relativePath;
    } else {
        return "Erreur lors de l'enregistrement du fichier.";
    }
}
?>