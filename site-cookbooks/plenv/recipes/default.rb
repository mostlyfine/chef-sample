#
# Cookbook Name:: plenv
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#
%w{build-essential curl}.each do |rcp|
  include_recipe rcp
end

%w{patch zlib-devel openssl-devel readline-devel ncurses-devel gdbm-devel db4-devel libffi-devel tk-devel libyaml-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

group "plenv" do
  action :create
  members node.plenv.members
  append true
end

git node.plenv.plenv_root do
  not_if { File.exist?(node.plenv.plenv_root) }
  repository "git://github.com/tokuhirom/plenv.git"
  reference "master"
  action :sync
  user node.plenv.user
  group "plenv"
end

directory "#{node.plenv.plenv_root}/plugins" do
  not_if { File.exist?("#{node.plenv.plenv_root}/plugins") }
  owner node.plenv.user
  group "plenv"
  mode 0755
  recursive true
  action :create
end

git "#{node.plenv.plenv_root}/plugins/perl-build" do
  not_if { File.exist?("#{node.plenv.plenv_root}/plugins/perl-build") }
  repository "git://github.com/tokuhirom/perl-build.git"
  reference "master"
  action :sync
  user node.plenv.user
  group "plenv"
end

directory node.plenv.profile_path do
  not_if { File.exist?(node.plenv.profile_path) }
  owner node.plenv.user
  group "plenv"
  mode 0755
  recursive true
  action :create
end

template "#{node.plenv.profile_path}/plenv.sh" do
  not_if { File.exist?("#{node.plenv.profile_path}/plenv.sh" ) }
  owner node.plenv.user
  group "plenv"
  mode 0644
end
