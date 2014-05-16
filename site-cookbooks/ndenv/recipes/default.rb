#
# Cookbook Name:: ndenv
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#

group "ndenv" do
  action :create
  members node.ndenv.members
  append true
end

git node.ndenv.ndenv_root do
  not_if { File.exist?(node.ndenv.ndenv_root) }
  repository "git://github.com/riywo/ndenv.git"
  reference "master"
  action :checkout
  user node.ndenv.user
  group "ndenv"
end

directory "#{node.ndenv.ndenv_root}/plugins" do
  not_if { File.exist?("#{node.ndenv.ndenv_root}/plugins") }
  owner node.ndenv.user
  group "ndenv"
  mode "0755"
  action :create
end

git "#{node.ndenv.ndenv_root}/plugins/ruby-build" do
  not_if { File.exist?("#{node.ndenv.ndenv_root}/plugins/perl-build") }
  repository "git://github.com/riywo/node-build.git"
  reference "master"
  action :checkout
  user node.ndenv.user
  group "ndenv"
end


directory node.ndenv.profile_path do
  not_if { File.exist?(node.ndenv.profile_path) }
  owner node.ndenv.user
  group "ndenv"
  mode "0755"
  recursive true
  action :create
end

template "#{node.ndenv.profile_path}/ndenv.sh" do
  owner node.ndenv.user
  group node.ndenv.user
  mode "0644"
end
