<?php
session_start();
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

if ($_SERVER["REQUEST_METHOD"] == "POST"){    
    $email = $_POST['email']; 
    $raw_password = $_POST['password'];
    
    if(empty($email) || empty($raw_password)){
        echo "E-mail veya şifre boş bırakılamaz.";
        exit(1);
    }else{
        $checkEmail = $db->prepare("SELECT * FROM usertable WHERE email = :email");
        $checkEmail -> execute([':email'=>$email]);
        if($checkEmail->rowCount()==0){
            echo "E-mail veya şifre hatalı.";
            exit(1);
        }
        $user = $checkEmail->fetch(PDO::FETCH_ASSOC);
        $hashed_password = $user['password'];
        if(password_verify($raw_password,$hashed_password)){
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_name'] = $user['name'];
            $_SESSION['user_email'] = $user['email'];
            header("Location: profile.php");
            exit;
        }else{
            echo "E-mail veya şifre hatalı.";
        }  

        
    }

}


?>