#
# Cookbook Name:: exim
# Recipe:: default
#
# Copyright 2012, 2combinators OU
#
# All rights reserved - Do Not Redistribute
#

package 'exim4'

service 'exim4' do
  supports :status => true, :restart => true, :reload => true
  action :start
end

template "/etc/mailname" do
  variables(:mailname => node['fqdn'])
end

template "/etc/exim4/update-exim4.conf.conf" do
  source "update-exim4.conf.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "update-exim4.conf" do
  notifies :reload, resources(:service => "exim4")
end
