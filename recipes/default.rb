#
# Cookbook Name:: chef_rails_postgresql
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

app = AppHelpers.new node['app']

# for pg gem
package 'libpq-dev'

# for hstore extension
# include_recipe 'postgresql::contrib'
include_recipe 'postgresql::server'

template "#{app.dir(:shared)}/config/database.yml" do
  source 'database.yml.erb'

  database = "#{app.name}_#{app.env}"
  user = node['postgresql']['users'].find { |v| v['username'] == database }

  variables(
    app_env: app.env,
    database: database,
    username: user['username'],
    password: user['password']
  )

  owner app.user
  group app.group
  mode '0660'
end
