<?php
$host = "localhost";
$dbname = "user";
$username = "root";
$password = "";

try{
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8mb4",$username,$password);
    $db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}catch(PDOException $e){
    die("Database connection error: " . $e->getMessage());
}


if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = $_POST['name'];
    $email = $_POST['email'];
    $gender = $_POST['gender'];
    $raw_password = $_POST['password'];
    

    if(empty($name) || empty($email) || empty($gender) || empty($raw_password)){
        echo "Tüm alanları doldurun.";
        exit;
    }else{
        $checkEmail = $db->prepare("SELECT * FROM usertable WHERE email = :email");
        $checkEmail->execute([':email'=>$email]);
        if($checkEmail->rowCount()>0){
            echo "Bu email zaten kayıtlı.";
            exit;
        }
        $password=password_hash($raw_password,PASSWORD_BCRYPT);
        $query = $db->prepare("INSERT INTO usertable (name, email, password, gender) VALUES (:name, :email, :password, :gender)");

        $execute = $query->execute([
        ':name'   => $name,
        ':email'  => $email,
        ':password'   => $password,
        ':gender' => $gender
        ]);
    }

    if($execute){
        header("Location: login.html");
        exit;
    }else{
        echo "An error occured.";
    }
}
?>