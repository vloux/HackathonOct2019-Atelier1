# Atelier 1 : **Portabilité et mises en commun de workflows**

Mise en pratique des différentes solutions techniques présentées hier (NextFlow/ SnakeMake) sur des workflows sélectionnés par les participants (implémentation et exécution en local et sur les différentes plateformes des CATIs). Comment partager et décrire des workflows (en lien avec atelier 2)  ?

Animateurs : Cédric Midoux, Valentin Loux et Maxime Manno

**Mardi 15/10/2019**

* Matinée: 9h - 12h30
* Après-midi: 14h - 18h --> Synthèse Atelier 1 à 16h

## Planning :

* Formation de groupes de 3-4 personnes selon l’intérêt vis-à-vis d’un workflow ou domaine particulier.
  * Choix d’un pipeline
  * Choix de technologies (Nexflow/Snakemake – Singularity/Docker – Conda)
* Réalisation du pipeline par groupe et échanges inter-groupes
* Tests sur les Plateformes des CATIs
* Synthèse de l’atelier 1 vers 16h pour préparer la restitution


## Infos pratiques :

* Machine virtuelle Debian :
  * Nextflow version 19.07.0.5106
  * Snakemake version 5.7.0
  * Conda 4.7.12
  * singularity version 3.0.3-1

* Configuration :
  * [VM](Configuration.md)
  * [Conda](https://forgemia.inra.fr/mmanno/HackathonOct2019-Atelier1/blob/master/Configuration.md#install-conda-env-)

## Pipelines :

### Nextflow :

#### liens Nextflow :

* [Get started](https://www.nextflow.io/docs/latest/getstarted.html)
* [Pipeline NF-Core](https://nf-co.re/pipelines)

#### Template et exemples :

[Template de Pipeline (stats basiques) sous Slurm](nf-basic_stats)


