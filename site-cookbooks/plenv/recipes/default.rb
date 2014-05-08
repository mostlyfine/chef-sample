#
# Cookbook Name:: plenv
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#

group "plenv" do
  action :create
  members node.plenv.members
  append true
end

git node.plenv.plenv_root do
  repository "git://github.com/tokuhirom/plenv.git"
  reference "master"
  action :sync
  user node.plenv.user
  group "plenv"
end

directory "#{node.plenv.plenv_root}/plugins" do
  owner node.plenv.user
  group "plenv"
  mode 0755
  recursive true
  action :create
end

git "#{node.plenv.plenv_root}/plugins/perl-build" do
  repository "git://github.com/tokuhirom/perl-build.git"
  reference "master"
  action :sync
  user node.plenv.user
  group "plenv"
end

directory node.plenv.profile_path do
  owner node.plenv.user
  group "plenv"
  mode 0755
  recursive true
  action :create
end

template "#{node.plenv.profile_path}/plenv.sh" do
  owner node.plenv.user
  group "plenv"
  mode 0644
end
