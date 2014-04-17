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
  members node.rbenv.members
  append true
end

git node.rbenv.rbenv_root do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
  user "#{node.rbenv.user}"
  group "rbenv"
end

directory "#{node.rbenv.rbenv_root}/plugins" do
  owner node.rbenv.user
  group "rbenv"
  mode "0755"
  action :create
end

template "#{node.rbenv.profile_path}/rbenv.sh" do
  owner "#{node.rbenv.user}"
  group "#{node.rbenv.user}"
  mode 0644
end

git "#{node.rbenv.rbenv_root}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
  user "#{node.rbenv.user}"
  group "rbenv"
end
