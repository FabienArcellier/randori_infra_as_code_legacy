## Motivation

Dans une DSI historique, la gestion du parc des machines est effectuée semi-manuellement.
Chaque Sysadmin met le maximum d'effort pour garder un parc homogène et cohérent.

Pourtant, avec les meilleurs efforts du monde, ce type d'effort conduit à des serveurs tous pareils mais différents, un peu comme des flocons de neige.
Martin Fowler décrit ce pattern d'infrastructure comme des [Snowflake Server](http://martinfowler.com/bliki/SnowflakeServer.html).

Nous ne pouvons pas tous repartir d'une infrastructure flambant neuve bati avec un orchestrateur docker, du monitoring efficace de l'infrastructure et des différents
containers. Nous devons vivre avec ce legacy. Ca ne signifie pas forcément le subir.

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

    git clone ...

## Code Example

Pour monter les machines virtuelles sous virtualbox :

```bash
vagrant up
vagrant ssh-config > ssh.config
```

Pour jouer les tests serverspec

```bash
rake all
```

Pour lister les suites de test serverspec

```bash
rake --tasks
```

## Installation

Pour bootstraper ce projet, nous avons utilisé ``ansible_spec`` ([lien](https://github.com/volanja/ansible_spec))

```
vagrant init
gem install ansible_spec
```

Nous avons modifié le rakefile pour qu'il prenne en compte le groupe, plutôt que les rôles dans le groupe.

```ruby
- roles = property["roles"]
- for role in property["roles"]
-   deps = AnsibleSpec.load_dependencies(role)
-   roles += deps
- end
- t.pattern = 'roles/{' + roles.join(',') + '}/spec/*_spec.rb'
+ t.pattern = 'spec/' +  property["name"] +'_spec.rb'
```

**Pourquoi construire un fichier ssh.config ?**

Si le fichier ssh.config est absent, nous devrions configurer soit le fichier host de la machine, soit compter sur un DNS.
Le fichier ssh.config est utilisé par ansible et serverspec pour se connecter en ssh sur la machine distante.
Il y récupère l'adresse IP et le nom d'utilisateur.

A partir du Vagrantfile, nous avons généré le fichier ssh.config qui correspond à l'infrastructure.

```bash
vagrant ssh-config > ssh.config
```

## Tests

Pour vérifier la syntaxe de votre code ansible

```bash
ansible-playbook --syntax-check -i "localhost," site.yml

# pour le faire de manière continue
watch -n 5 ansible-playbook --syntax-check -i "localhost," site.yml
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
