#!/bin/bash

# Vérifie si Java est installé
if type -p java; then
    echo "Java trouvé dans le chemin"
else
    # Installe Java
    apt-get update
    apt-get install -y openjdk-11-jre
fi

# Ajoute le dépôt Jenkins à la liste des sources
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

#echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

# Met à jour la liste des paquets disponibles et installe Jenkins
apt-get update

# Démarre le service Jenkins et configure pour qu'il soit démarré automatiquement au démarrage du système
systemctl enable jenkins
systemctl start jenkins

# Affiche l'adresse de l'interface utilisateur Jenkins
clear
echo "Adresse de Jenkins : http://localhost:8080"
PASSWORD=$(cat /var/lib/jenkins/secrets/initialAdminPassword);
echo "Mot de passe : $PASSWORD"
