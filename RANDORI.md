# Challenge 1 : Vérifier que tous les serveurs répondent sur le port 80

2 de nos serveurs webs absorbent le traffic d'après notre firewall. Il semblerait que ``webserver_hermes`` ne répond pas sur le port 80.

Nous allons décrire une règle qui spécifie qu'un serveur web doit avoir le port 80 ouvert.

écrire le test serverspec dans ``spec/webserver_spec.rb``:

```ruby
describe "webserver" do
  it "needs to have the port 80 listening" do
    expect(port('80')).to be_listening
  end
end
```

**Indice Ansible** : Vous devez utiliser le module service pour vous assurer que le service apache2 est démarré sur toutes les machines

```yml
- name: "ensure the service is started"
  service: name="my_service" state="started"
```

Allez plus loin :

* L'importance du monitoring
* Utiliser Ansible pour du test d'infrastructure
* ...

# Challenge 2 : Synchroniser tous les serveurs avec un serveur ntp

Nous avons remarqué dans nos logs que le serveur artemis a du retard sur les 2 autres serveurs web. Lors d'une analyse d'incident, nous avons perdu du temps pour recomposer les logs de l'incident

Nous allons nous assurer d'installer un serveur ``Network Time Protocol`` (ntp) sur toutes les machines (database et webserver).

Pour cet exercice, nous ferons un test serveurspec pour chaque profil.

écrire le test serverspec dans ``spec/webserver_spec.rb``:

```ruby
describe "webserver" do
  # ...
  it "needs to have the ntp service installed and active" do
    expect(package('ntp')).to be_installed
    expect(service('ntp')).to be_running
  end
  # ...
end
```

écrire le test serverspec dans ``spec/database_spec.rb``:

```ruby
describe "database" do
  # ...
  it "needs to have the ntp service installed and active" do
    expect(package('ntp')).to be_installed
    expect(command('ntpq -pn')).to be_running
  end
  # ...
end
```

**Indice Ansible** : Vous devez utiliser le module apt pour vous assurer que le package ``ntp`` est démarré sur toutes les machines

```yml
- name: "ensure the package is present"
  apt: name="package" state="present"
```

Allez plus loin

* Gérer la mise à jour de package (present, latest, ...)
* La convergence ntp met du temps (ntpq -pn)
* Gestion du timezone ``timezone: name=Asia/Tokyo``
* ...

# Challenge 3 : Créer des accès nominatifs pour les développeurs

Un audit de sécurité est tombé. Les développeurs ne doivent plus avoir tout pouvoir sur les machines. Il faut créer des comptes nominatif (far, fxv, mhe).

```ruby
describe "webserver" do
  # ...
  it "needs developpers to use their own accounts" do
    users = ['far', 'fxv', 'mhe']
    users.each {|u|
      expect(user(u)).to exist
    }
  end

  it "needs developpers to have dev as primary group" do
    users = ['far', 'fxv', 'mhe']
    users.each {|u|
      expect(user(u)).to belong_to_primary_group 'dev'
    }
  end
  # ...
end
```

**Indice Ansible** : Vous devez utiliser le module user pour vous assurer que les utilisateurs existent sur toutes les machines

```yml
- name: "ensure user my_user is present"
  user: name=my_user group=my_group state="present"
```

Allez plus loin

* Gestion des clés d'accès ssh,
* Gérer les dossiers home
* Gérer les accès sudo
* Utiliser une base de donnée grace au lookup avec Ansible
* ...

# Challenge 4 : Faire ecouter apache sur le port 81 pour les fichiers statiques


```ruby
describe "webserver" do
  it "needs to have the port 81 listening to send static assets" do
    expect(port('81')).to be_listening
  end
end
```
