<?php
session_start();
if(empty($_SESSION['user_id'])){
    header("Location: login.html");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body> 
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <span class="navbar-brand mb-3 h1">Hesap</span>
            <a href="logout.php" class="btn btn-danger btn-sm">Çıkış</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="card shadow-sm p-4" style="max-width: 500px";>
            <h2 class="card-title text-primary mb-4">Kullanıcı Bilgileri:</h2>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <?php echo "İsim: " . htmlspecialchars($_SESSION['user_name']) ?>
                </li>

                <li class="list-group-item">
                    <?php echo "E-mail: " . htmlspecialchars($_SESSION['user_email']) ?>
                </li>
            </ul>

        </div>
    </div>
</body>
</html>