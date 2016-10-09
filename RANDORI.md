# Challenge 1 : Nous devons vérifier que sur tous les serveurs webs répondent sur le port 80

Nous avons un comportement étrange. 2 de nos serveurs webs absorbent le traffic.
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
