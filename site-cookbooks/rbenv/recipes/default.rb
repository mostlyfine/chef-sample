#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#

group "rbenv" do
  action :create
  members "vagrant"
  append true
end

git "/usr/local/rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
  user "#{node.rbenv.user}"
  group "rbenv"
end

directory "/usr/local/rbenv/plugins" do
  owner "#{node.rbenv.user}"
  group "rbenv"
  mode "0755"
  action :create
end

template "/etc/profile.d/rbenv.sh" do
  owner "#{node.rbenv.user}"
  group "#{node.rbenv.user}"
  mode 0644
end

git "/usr/local/rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
  user "#{node.rbenv.user}"
  group "rbenv"
end
