DROP TABLE IF EXISTS Dirige;
DROP TABLE IF EXISTS ParticipeClub;
DROP TABLE IF EXISTS ParticipeCompetiteur;
DROP TABLE IF EXISTS Evaluation;
DROP TABLE IF EXISTS MembreJury;
DROP TABLE IF EXISTS Dessin;
DROP TABLE IF EXISTS Concours;
DROP TABLE IF EXISTS Directeur;
DROP TABLE IF EXISTS Administrateur;
DROP TABLE IF EXISTS Competiteur;
DROP TABLE IF EXISTS Evaluateur;
DROP TABLE IF EXISTS President;
DROP TABLE IF EXISTS Utilisateur;
DROP TABLE IF EXISTS Club;

CREATE TABLE siteweb.Club (
    numClub INT AUTO_INCREMENT, 
    nomClub VARCHAR(50) NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    numTelephone VARCHAR(50) NOT NULL,
    nombreAdherent INT, 
    ville VARCHAR(50) NOT NULL,
    departement VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    PRIMARY KEY (numClub)
);

CREATE TABLE siteweb.Utilisateur (
    numUtilisateur INT AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    adresse VARCHAR(50) NOT NULL,
    login VARCHAR(50) NOT NULL,
    motDePasse VARCHAR(50) NOT NULL,
    numClub INT,
    PRIMARY KEY (numUtilisateur),
    FOREIGN KEY (numClub) REFERENCES Club(numClub)
);

CREATE TABLE siteweb.President (
    numPresident INT,
    prime VARCHAR(50) NOT NULL,
    PRIMARY KEY (numPresident),
    FOREIGN KEY (numPresident) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE siteweb.Evaluateur (
    numEvaluateur INT,
    specialite VARCHAR(50) NOT NULL,
    PRIMARY KEY (numEvaluateur),
    FOREIGN KEY (numEvaluateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE siteweb.Competiteur (
    numCompetiteur INT,
    datePremiereParticipation DATE,
    PRIMARY KEY (numCompetiteur),
    FOREIGN KEY (numCompetiteur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE siteweb.Administrateur (
    numAdministrateur INT,
    dateDebut DATE,
    PRIMARY KEY (numAdministrateur),
    FOREIGN KEY (numAdministrateur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE siteweb.Directeur (
    numDirecteur INT,
    dateDebut DATE,
    PRIMARY KEY (numDirecteur),
    FOREIGN KEY (numDirecteur) REFERENCES Utilisateur(numUtilisateur)
);

CREATE TABLE siteweb.Dirige (
    numClub INT,
    numDirecteur INT,
    PRIMARY KEY (numClub, numDirecteur),
    FOREIGN KEY (numClub) REFERENCES Club(numClub),
    FOREIGN KEY (numDirecteur) REFERENCES Directeur(numDirecteur)
);

CREATE TABLE siteweb.Concours (
    numConcours INT AUTO_INCREMENT,
    theme VARCHAR(50) NOT NULL,
    descriptif VARCHAR(300),
    dateDebut DATE,
    dateFin DATE,
    etat ENUM('pas commence', 'en cours', 'attente', 'resultat', 'evalue'),
    numPresident INT,
    PRIMARY KEY (numConcours),
    FOREIGN KEY (numPresident) REFERENCES President(numPresident)
);

CREATE TABLE siteweb.ParticipeClub (
    numClub INT,
    numConcours INT,
    PRIMARY KEY (numClub, numConcours),
    FOREIGN KEY (numClub) REFERENCES Club(numClub),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE siteweb.ParticipeCompetiteur (
    numCompetiteur INT,
    numConcours INT,
    PRIMARY KEY (numCompetiteur, numConcours),
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteur(numCompetiteur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE siteweb.Dessin (
    numDessin INT AUTO_INCREMENT,
    commentaire VARCHAR(200),
    classement INT,
    dateRemise DATE,
    leDessin VARCHAR(100),
    numCompetiteur INT,
    numConcours INT,
    PRIMARY KEY (numDessin),
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteur(numCompetiteur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE siteweb.Evaluation (
    numDessin INT,
    numEvaluateur INT,
    dateEvaluation DATE,
    note INT,
    commentaire VARCHAR(200),
    PRIMARY KEY (numDessin, numEvaluateur),
    FOREIGN KEY (numDessin) REFERENCES Dessin(numDessin),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur)
);

CREATE TABLE siteweb.MembreJury (
    numEvaluateur INT,
    numConcours INT,
    PRIMARY KEY (numEvaluateur, numConcours),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);