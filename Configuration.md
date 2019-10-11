# Configuration Atelier 1 :


## Configurer la vm :

Fichier > importer un appareil virtuel  
changer nom, proc et mémoire si besoin

Configuration > Interface utilisateur > cocher en haut à droite

## Ajouter un deuxième virtual disk SATA

Configuration > Stockage > controleur SATA  
créer un nouveau disk (exemple de nom data_drive)

Dans la VM > Accessoires > Disks > formater le nouveau disk et le monter

## Comment installer les additions client et partager un dossier

Voir [lien](https://www.commentcamarche.net/faq/7576-virtualbox-installer-les-additions-client-dans-ubuntu)

```bash
mkdir ~/pilots
cp -r /media/cdrom0/* ~/pilots

cd ~/pilots
sudo -s
chmod u+x VBoxLinuxAdditions.run
./VBoxLinuxAdditions.run
reboot
```

## Connecter un dossier partagé

Voir [lien](https://www.seeyar.fr/partage-dossier-virtualbox/)

Configuration > dossier partagé

```bash
mkdir ~/data/partage
sudo mount -t vboxsf partage_vm ~/data/partage
```

## Install conda env :

```bash
# Commandes déjà effectuées
mkdir /media/bioinfo/data_drive/conda
rm -rf ~/.conda # ou mv .conda /media/bioinfo/data_drive/conda puis le rm
ln -s /media/bioinfo/data_drive/conda .conda

# Créer un environnement Conda
/usr/local/miniconda3/bin/conda create -n env_bioinfo -c bioconda fastqc multiqc bwa
```
