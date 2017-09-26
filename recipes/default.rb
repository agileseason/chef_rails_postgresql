#
# Cookbook Name:: chef_rails_postgresql
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# for pg gem
package 'libpq-dev'

# file locations must be overriden as well when changing default version (9.4)
# see https://github.com/phlipper/chef-postgresql
node.override['postgresql']['version'] = default['chef_rails_postgresql']['version']
node.override['postgresql']['data_directory'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
node.override['postgresql']['hba_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_hba.conf"
node.override['postgresql']['ident_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_ident.conf"
node.override['postgresql']['external_pid_file'] = "/var/run/postgresql/#{node['postgresql']['version']}-main.pid"

include_recipe 'postgresql::server'
