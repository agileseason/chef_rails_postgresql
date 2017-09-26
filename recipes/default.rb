#
# Cookbook Name:: chef_rails_postgresql
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

fail "database is not set" if node['chef_rails_postgresql']['database'].nil?
fail "username is not set" if node['chef_rails_postgresql']['username'].nil?
fail "password is not set" if node['chef_rails_postgresql']['password'].nil?

app = AppHelpers.new node['app']

# file locations must be overriden as well when changing default version (9.4)
# see https://github.com/phlipper/chef-postgresql
node.override['postgresql']['version'] = node['chef_rails_postgresql']['version']
node.override['postgresql']['data_directory'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
node.override['postgresql']['hba_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_hba.conf"
node.override['postgresql']['ident_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_ident.conf"
node.override['postgresql']['external_pid_file'] = "/var/run/postgresql/#{node['postgresql']['version']}-main.pid"

# for pg gem
package 'libpq-dev'

# allow chef-postgres to install postgres dependencies
include_recipe 'postgresql'

node.override['postgresql']['pg_hba'] = [
  {
    'type' => 'local',
    'db' => node['chef_rails_postgresql']['username'],
    'user' => node['chef_rails_postgresql']['password'],
    'addr' => '',
    'method' => 'md5'
  }
]

postgresql_database node['chef_rails_postgresql']['database'] do
  owner node['chef_rails_postgresql']['database']
  encoding 'UTF-8'
  template 'template0'
  locale 'en_US.UTF-8'
end

node['chef_rails_postgresql']['extensions'].each do |extension|
  postgresql_extension extension do
    database node['chef_rails_postgresql']['database']
  end
end

postgresql_user app.user do
  superuser true
  createdb true
  login true
  replication false
end

postgresql_user node['chef_rails_postgresql']['username'] do
  superuser false
  createdb true
  login true
  replication false
  password node['chef_rails_postgresql']['password']
end
