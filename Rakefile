require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'

properties = AnsibleSpec.get_properties
# {"name"=>"Ansible-Sample-TDD", "hosts"=>["192.168.0.103","192.168.0.103"], "user"=>"root", "roles"=>["nginx", "mariadb"]}
# {"name"=>"Ansible-Sample-TDD", "hosts"=>[{"name" => "192.168.0.103:22","uri"=>"192.168.0.103","port"=>22, "private_key"=> "~/.ssh/id_rsa"}], "user"=>"root", "roles"=>["nginx", "mariadb"]}

desc "Run serverspec to all test"
task :all => "serverspec:all"

namespace :serverspec do
  task :all => properties.map {|v| 'serverspec:' + v["name"] }
  properties = properties.compact.reject{|e| e["hosts"].length == 0}
  properties.each_with_index.map do |property, index|
    property["hosts"].each do |host|
      desc "Run serverspec for #{property["name"]}"
      RSpec::Core::RakeTask.new(property["name"].to_sym) do |t|
        puts "Run serverspec for #{property["name"]} to #{host}"
        ENV['TARGET_HOST'] = host["uri"]
        t.pattern = 'spec/' +  property["name"] +'_spec.rb'
      end
    end
  end
end
