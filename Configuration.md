# Configuration Atelier 1 :


## Configurer la vm :

[Download](https://www.virtualbox.org/wiki/Downloads)

Fichier > importer un appareil virtuel > [hackathon_atelier1_V2.ova](https://filesender.renater.fr/?s=download&token=65908ef2-5c6b-0e57-a538-7e786fe2296a)  
changer nom, proc et mémoire si besoin

Configuration > Interface utilisateur > cocher la case en haut à droite (_Déjà configuré_ :+1:)

## Ajouter un deuxième virtual disk SATA

Configuration > Stockage > controleur SATA  
créer un nouveau disk (exemple de nom data_drive) (_Déjà configuré_ :+1:)

Dans la VM > Accessoires > Disks > formater le nouveau disk et le monter (_Déjà configuré_ :+1:)

## Comment installer les additions client et partager un dossier

Voir [lien](https://www.commentcamarche.net/faq/7576-virtualbox-installer-les-additions-client-dans-ubuntu) (_Déjà configuré_ :+1:)

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

Configuration > dossier partagé (_Si besoin_ :stuck_out_tongue_winking_eye:)

```bash
mkdir ~/data/partage
sudo mount -t vboxsf partage_vm ~/data/partage
```

## Install conda env :

### Configuration : (_Déjà configuré_ :+1:)

```bash
mkdir /media/bioinfo/data_drive/conda
rm -rf ~/.conda # ou mv .conda /media/bioinfo/data_drive/conda puis le rm
ln -s /media/bioinfo/data_drive/conda .conda
```

### Créer un environnement Conda
```bash
/usr/local/miniconda3/bin/conda create -n env_bioinfo -c bioconda fastqc multiqc bwa
```
