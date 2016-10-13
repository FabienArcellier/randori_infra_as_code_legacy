require 'spec_helper'

describe "webserver" do
  it "needs to have the port 80 listening" do
    expect(port('80')).to be_listening
  end

  it "needs to have the ntp service installed and running" do
    expect(package('ntp')).to be_installed
    expect(service('ntp')).to be_running
  end

  it "needs developpers to use their own accounts" do
    users = ['far', 'fxv', 'mhe']
    users.each {|u|
      expect(user(u)).to exist
    }
  end

  it "needs developpers account to have dev as primary group" do
    users = ['far', 'fxv', 'mhe']
    users.each {|u|
      expect(user(u)).to belong_to_primary_group 'dev'
    }
  end
end
