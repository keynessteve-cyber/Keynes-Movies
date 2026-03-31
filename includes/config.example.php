<?php
session_start();

define('DB_HOST', 'localhost');     
define('DB_PORT', '3308');          
define('DB_NAME', 'Keynes_Movies'); 
define('DB_USER', 'root');          
define('DB_PASS', '');              

try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8",
        DB_USER,
        DB_PASS
    );

    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}

define('BASE_URL', 'http://localhost/Keynes_Movies/');
?>