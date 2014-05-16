#
# Cookbook Name:: rbenv
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

group "rbenv" do
  action :create
  members node.rbenv.members
  append true
end

git node.rbenv.rbenv_root do
  not_if { File.exist?(node.rbenv.rbenv_root) }
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
  user node.rbenv.user
  group "rbenv"
end

directory "#{node.rbenv.rbenv_root}/plugins" do
  not_if { File.exist?("#{node.rbenv.rbenv_root}/plugins") }
  owner node.rbenv.user
  group "rbenv"
  mode "0755"
  action :create
end

git "#{node.rbenv.rbenv_root}/plugins/ruby-build" do
  not_if { File.exist?("#{node.rbenv.rbenv_root}/plugins/ruby-build") }
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
  user node.rbenv.user
  group "rbenv"
end

directory node.rbenv.profile_path do
  not_if { File.exist?(node.rbenv.profile_path) }
  owner node.rbenv.user
  group "rbenv"
  mode "0755"
  recursive true
  action :create
end

template "#{node.rbenv.profile_path}/rbenv.sh" do
  not_if { File.exist?("#{node.rbenv.profile_path}/rbenv.sh" ) }
  owner node.rbenv.user
  group node.rbenv.user
  mode "0644"
end
