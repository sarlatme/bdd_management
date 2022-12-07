<?php
    session_start();

    if (isset($_POST['username']) && isset($_POST['password'])) {
        
        $db_username = 'root';
        $db_password = 'password';
        $db_name = 'nom_db';
        $db_host = 'localhost';
    
        function secure($data) {
            $data = trim($data);
            $data = stripcslashes($data);
            $data = htmlspecialchars($data);
            return $data;
        }
    
        if (!isset($_SESSION['connect'])){
            $user_mail = secure($_POST["user_mail"]);
            $user_password = secure($POST["user_password"]);
        } else {
            $user_mail = secure($_SESSION["id"]);
            $user_password = secure($_SESSION["pass"]);
        }

        $bdd = new PDO("mysql:host=$db_host; dbname=$db_name", $db_username, $db_password);

        $req = $bdd->prepare("SELECT user_num, username, usermail, user_password FROM user WHERE user_mail = :user_mail");
        req-> execute(array("user_mail" => $user_mail));
        $resultat = $req->fetch();

        $verification = password_verify($user_password, $resultat["user_password"]);
        if ($verification) {
            $_SESSION['id'] = $user_mail;
            $_SESSION['pass'] = $user_password;
            $_SESSION['num'] = $resultat['user_num'];
            $_SESSION['prenom'] = $resultat['username'];
            $_SESSION['connect']= 'true';
            $req->closeCursor();
            header('Location: ../content/menu.php');
            exit();
        } else {
            header('Location: ../include/connexion_lost.php'); //renvoie a la page d'erreur de login
            $req->closeCursor();
        }
    }
    ?>

