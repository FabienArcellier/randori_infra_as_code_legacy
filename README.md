[![asciicast](https://asciinema.org/a/dnate3nnkpkoevrfipqnmb1qo.png)](https://asciinema.org/a/dnate3nnkpkoevrfipqnmb1qo)

## Motivation

Dans une DSI historique, la gestion du parc des machines est effectuée semi-manuellement.
Chaque Sysadmin met le maximum d'effort pour garder un parc homogène et cohérent.

Pourtant, avec les meilleurs efforts du monde, ce type d'effort conduit à des serveurs tous pareils mais différents, un peu comme des flocons de neige.
Martin Fowler décrit ce pattern d'infrastructure comme des [Snowflake Server](http://martinfowler.com/bliki/SnowflakeServer.html).

Nous ne pouvons pas tous repartir d'une infrastructure flambant neuve bati avec un orchestrateur docker, du monitoring efficace de l'infrastructure et des différents
containers. Nous devons vivre avec ce legacy. Ca ne signifie pas forcément le subir.

**Principe du randori**

Un randori est un dojo participatif avec un seul clavier. Vous aurez besoin d'un animateur pour le story telling.
Ce randori se joue avec 7 à 8 participants.

Chaque participant aura accès au clavier 5 minutes avec comme but de faire avancer le dojo. Soit il va :

* spécifier un test ServerSpec pour rendre le problème visible (Test rouge)
* faire passer le test ServerSpec avec du code Ansible (Test vert)
* refactorer le code pour limiter la dette technique (Test toujours vert)

Vous pouvez profiter des différents challenges pour introduire des discussions plus poussés (section Allez plus loin).
Les challenges sont dans le fichier ``RANDORI.md``.

## Synopsis

Dans ce randori, vous êtes membre d'une équipe d'un site de ecommerce "cartagen".

Au cours des 2 derniers mois, votre équipe a monté un nouveau service qui permet aux utilisateurs de publier des annonces.

Ce système a été mis douloureusement en production. Vous venez de faire une refonte.
Lors du postmortem qui suivait la mise en production, vous avez décidé d'un commun accord entre vos équpes d'appliquer une démarche DevOps et de travailler
main dans la main pour la correction de l'infrastructure.

Votre budget est limité et un de vos collaborateurs a proposé d'amorcer une démarche itérative pour faire évoluer l'infra.

L'objectif de ce randori est de démontrer par des pratiques d'infra as code comment faire évoluer pas à pas une infrastructure et reprendre le contrôle de son legacy :

* Appliquer de la gestion de configuration avec Ansible
* Appliquer les principes de Test Driven Developpment avec ServerSpec
* Comprendre le pattern "Pets vs Cattle"
* ...

## The latest version

You can find the latest version to ...

    git clone https://github.com/FabienArcellier/randori_infra_as_code_legacy.git

## Code Example

**Jouer les tests serverspec**

```bash
rake all
```

**Pour configurer votre infrastructure**

```bash
ansible-playbook -i hosts playbooks/site.yml
```

**Lister les suites de test serverspec**

```bash
rake --tasks
```

## Tips

**Vérifier votre code ansible pendant que vous développez**

```bash
watch -n 5 ansible-playbook --syntax-check -i "localhost," site.yml
```

## Installation

### Avec vagrant

Pour monter l'environnement, la première fois :

```bash
cd bootstrap
vagrant up
vagrant ssh-config > ../ssh.config

cd ..
ansible-playbook -i hosts bootstrap/playbooks/site.yml
```

Dans le fichier `ansible.cfg`, ajoutez les lignes

```
[ssh_connection]
ssh_args = -o ControlPersist=15m -F ssh.config -q
```

### Sur AWS

Vous devez configurer votre VPC et votre subnet dans le fichier `bootstrap/main.tf`.

```bash
cd bootstrap
terraform plan
terraform apply
```

la commande terraform output permet de recuperer le fichier `host`

## Tests

Pour vérifier la syntaxe de votre code ansible

```bash
ansible-playbook --syntax-check -i "localhost," site.yml
```

## Contributors

* Fabien Arcellier

## License

```
Copyright (c) 1998, Regents of the University of California
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
* Neither the name of the University of California, Berkeley nor the
  names of its contributors may be used to endorse or promote products
  derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
