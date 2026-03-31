<?php

require_once 'includes/config.php';

$apiKey = '2648720e';

$sql = "SELECT id, titre FROM films ORDER BY id";
$stmt = $pdo->query($sql);
$films = $stmt->fetchAll();

echo "<h1>🎬 Mise à jour des posters des films</h1>";
echo "<div style='max-width:800px; margin:0 auto; font-family:Arial;'>";
echo "<ul style='list-style:none; padding:0;'>";

$compteur = 0;
$succes = 0;
$erreur = 0;

foreach($films as $film) {
    $titre = urlencode($film['titre']);
    $url = "https://www.omdbapi.com/?t={$titre}&apikey={$apiKey}";
    
    $response = @file_get_contents($url);
    
    if($response === false) {
        echo "<li style='color:orange; padding:5px; margin:2px 0; background:#fff3cd;'>⚠️ {$film['titre']} - Erreur de connexion</li>";
        $erreur++;
        continue;
    }
    
    $data = json_decode($response, true);
    
    if($data && $data['Response'] === 'True') {
        $poster = $data['Poster'];
        
        if($poster && $poster !== 'N/A') {
            $sqlUpdate = "UPDATE films SET image = :poster WHERE id = :id";
            $stmtUpdate = $pdo->prepare($sqlUpdate);
            $stmtUpdate->execute(['poster' => $poster, 'id' => $film['id']]);
            
            echo "<li style='color:green; padding:5px; margin:2px 0; background:#d4edda;'>✅ {$film['titre']} - Poster trouvé</li>";
            $succes++;
        } else {
            echo "<li style='color:orange; padding:5px; margin:2px 0; background:#fff3cd;'>⚠️ {$film['titre']} - Pas de poster disponible</li>";
            $erreur++;
        }
    } else {
        $erreurMessage = $data['Error'] ?? 'Film non trouvé';
        echo "<li style='color:red; padding:5px; margin:2px 0; background:#f8d7da;'>❌ {$film['titre']} - {$erreurMessage}</li>";
        $erreur++;
    }
    
    usleep(500000); 
    $compteur++;
    
    echo "<li style='color:gray; padding:5px;'>📊 Progression : {$compteur}/" . count($films) . "</li>";
}

echo "</ul>";
echo "<hr>";
echo "<h2>📊 Résultat :</h2>";
echo "<p style='color:green;'>✅ Succès : {$succes} films</p>";
echo "<p style='color:orange;'>⚠️ Sans poster : {$erreur} films</p>";
echo "<p style='color:blue;'>📊 Total : {$compteur} films traités</p>";
echo "<p><a href='index.php' style='display:inline-block; padding:10px 20px; background:#e50914; color:white; text-decoration:none; border-radius:5px;'>Retour à l'accueil</a></p>";
echo "</div>";
?>