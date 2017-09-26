#
# Cookbook Name:: chef_rails_postgresql
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# for pg gem
package 'libpq-dev'

include_recipe 'postgresql::server'
