<?php

$category = "";
$sort = "ASC";

if (php_sapi_name() === "cli") {
    // Command line input
    echo "Enter product category (php version): ";
    $category = trim(fgets(STDIN));

    echo "Sort by price (ASC/DESC): ";
    $sort = trim(fgets(STDIN));
} else {
    // Browser input
    $category = $_GET['category'] ?? "";
    $sort = $_GET['sort'] ?? "ASC";
}

if ($sort !== "ASC" && $sort !== "DESC") {
    $sort = "ASC";
}

$dsn = "mysql:host=localhost;port=3306;dbname=HW11;charset=utf8";
$user = "root";
$pass = "hiding my password"; 

try {
    $pdo = new PDO($dsn, $user, $pass);

    $sql = "SELECT prod_id, name, category, unit_price
            FROM Products
            WHERE category = ?
            ORDER BY unit_price $sort";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$category]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo "===== Product Search Results =====\n";

    foreach ($rows as $row) {
        echo "ID: {$row['prod_id']} | {$row['name']} | \${$row['unit_price']}\n";
    }

    echo "==================================\n";

} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
