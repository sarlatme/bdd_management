<!DOCTYPE html>
<html lang="fr">
    <?php
    	session_start(); //Ouverture de la session

        require_once('../../functions/mypdo.class.php');
        $vpdo = new mypdo (); //initialise la classe
        $db = $vpdo->connexion; //ouvrir la connexion
        $result = $vpdo->getNomClub();
        $row = $result->fetch(PDO::FETCH_OBJ);
        $_SESSION['nomClub'] = $row->nomClub;
	?>
	<head>
    	<meta charset="utf-8"/>
    	<link rel="stylesheet" type="text/css" href="../../style/style.css"/> 	<!-- Reference fichier .css -->
        <?php
                if(isset($_SESSION['connect'])){
                    echo '
                        <title>Page de '.$_SESSION['prenom'].'</title>
                    ';
                }else{
                    echo '<p>Erreur</p>';
                }
            ?> 
	</head>
	<body>
        <nav class="navbar">
            <?php
                if(isset($_SESSION['isAdmin'])){
                    echo '
                    <a href="#" class="logo">Profil de '.$_SESSION['prenom'].' / Administrateur</a>
                    ';
                } elseif(isset($_SESSION['isDirector'])) {
                    echo '
                    <a href="#" class="logo">Profil de '.$_SESSION['prenom'].' / Directeur</a>
                    ';                     
                } else {
                    echo '
                    <a href="#" class="logo">Profil de '.$_SESSION['prenom'].'</a>
                    ';   
                }
            ?>
            <div class="nav-links">
                <?php
                    if(isset($_SESSION['isAdmin'])){
                        echo '
                        <ul>
                            <li><a href="../user/admin_concours.php">Concours</a></li>
                            <li><a href="../user/admin_clubs.php">Clubs</a></li>
                            <li><a href="../../functions/deconnexion.php">Deconnexion</a></li>
                        </ul>
                        ';
                    } elseif(isset($_SESSION['isDirector'])) {
                        echo '
                        <ul>
                            <li><a href="../user/directeur_concours.php">Concours</a></li>
                            <li><a href="../user/directeur_club.php">Mon club</a></li>
                            <li><a href="../../functions/deconnexion.php">Deconnexion</a></li>
                        </ul>
                        ';                     
                    } elseif(isset($_SESSION['isPresident'])) {
                        echo '
                            <ul>
                                <li><a href="#">Concours</a></li>
                                <li><a href="../user/concours_competiteur.php">Mes Concours/a></li>
                                <li><a href="../../functions/deconnexion.php">Deconnexion</a></li>
                            </ul>
                        ';       
                    } else {
                        echo '
                        <ul>
                            <li><a href="../user/concours_competiteur.php">Mes Concours</a></li>
                            <li><a href="../../functions/deconnexion.php">Deconnexion</a></li>
                        </ul>
                        ';   
                    }
                ?>
            </div>
        </nav>

        <header></header>
        <section class="profil">
                    <section class="col1">
                    <form action="">
                        <?php
                            if(isset($_SESSION['connect'])){
                                echo '
                                    <p>Mon profil</p><br>
                                    <p>Mail : '.$_SESSION['mail'].'</p><br>
                                    <p>Nom : '.$_SESSION['nom'].'</p><br>
                                    <p>Prénom : '.$_SESSION['prenom'].'</p><br>
                                    <p>Adresse : '.$_SESSION['adresse'].'</p><br>
                                    <p>Date de license : '.$_SESSION['dateLicense'].'</p><br>
                                    <p>Club : '.$_SESSION['nomClub'].'</p><br>
                                ';
                            }else{
                                echo '<p>Erreur</p>';
                            }
                        ?> 
                    </form>
                    </section>
        </section>
        <footer>
            <p>Copyright &copy; Bury Hugo & Sarlat Meven</p>
            <p>2020 - 2022 | All Right Reserved.</p>
        </footer>
	</body>

</html>