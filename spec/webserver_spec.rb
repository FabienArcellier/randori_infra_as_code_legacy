require 'spec_helper'

describe "webserver" do
  it "needs to have the port 80 listening" do
    expect(port('80')).not_to be_listening
  end
end
