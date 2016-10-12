require 'spec_helper'

describe "database" do
  it "needs to have the ntp service installed and running" do
    expect(package('ntp')).to be_installed
    expect(service('ntp')).to be_running
  end
end
