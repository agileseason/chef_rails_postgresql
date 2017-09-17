# file locations must be overriden as well when changing default version (9.4)
# see https://github.com/phlipper/chef-postgresql
override['postgresql']['version'] = '9.6'

override['postgresql']['data_directory'] = "/var/lib/postgresql/#{node['postgresql']['version']}/main"
override['postgresql']['hba_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_hba.conf"
override['postgresql']['ident_file'] = "/etc/postgresql/#{node['postgresql']['version']}/main/pg_ident.conf"
override['postgresql']['external_pid_file'] = "/var/run/postgresql/#{node['postgresql']['version']}-main.pid"
override['postgresql']['shared_preload_libraries'] = 'pg_stat_statements'
