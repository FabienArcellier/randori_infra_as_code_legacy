# Challenge 1 : Vérifier que tous les serveurs répondent sur le port 80

2 de nos serveurs webs absorbent le traffic.
Il semblerait que ``webserver_hermes`` ne répond pas sur le port 80.

Nous allons décrire une règle qui spécifie qu'un serveur web doit avoir le port 80 ouvert.

écrire le test serverspec dans ``spec/webserver_spec.rb``:

```ruby
require 'spec_helper'

describe "webserver" do
  it "needs to have the port 80 listening" do
    expect(port('80')).to be_listening
  end
end
```

Indice Ansible : Vous devez utiliser le module service pour vous assurer que le service apache2 est démarré sur toutes les machines

```yml
- name: "ensure the service is started"
  service: name="my_service" state="started"
```

# Challenge 2 : Synchroniser tous les serveurs avec un serveur ntp

Nous avons remarqué dans nos logs que le serveur artemis a 17 minutes de retard sur les 2 autres serveurs web.
Lors d'une analyse d'incident, nous avons perdu du temps pour recomposer les logs de l'incident

Nous allons nous assurer d'installer un serveur ntp sur toutes les machines (database et webserver).

Pour cet exercice, nous ferons un test serveurspec pour chaque profil.

écrire le test serverspec dans ``spec/webserver_spec.rb``:

```ruby
it "needs to have the ntp service installed and active" do
  expect(package('ntp')).to be_installed
  expect(command('ntpq -pn')).to be_running
end
```



Indice Ansible : Vous devez utiliser le module apt pour vous assurer que le service apache2 est démarré sur toutes les machines

```yml
- name: "ensure the service is present"
  apt: name="my_service" state="present"
```

Disclaimer: La convergence ntp met du temps (ntpq -pn)

# Challenge 3 : Créer des accès nominatifs

Un audit de sécurité est tombé. Les développeurs ne doivent plus avoir tout pouvoir sur les machines.
Il faut créer des comptes nominatifs.

```ruby
describe group('dev') do
  it { should exist }
end
```

Disclaimer : Droit d'acces ssh, repertoire home, sudo et consort

# Challenge 4 : Faire ecouter apache sur le port 81 pour les fichiers statiques
