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
  repository "git://github.com/riywo/ndenv.git"
  reference "master"
  action :checkout
  user "#{node.ndenv.user}"
  group "ndenv"
end

directory "#{node.ndenv.ndenv_root}/plugins" do
  owner node.ndenv.user
  group "ndenv"
  mode "0755"
  action :create
end

template "#{node.ndenv.profile_path}/ndenv.sh" do
  owner "#{node.ndenv.user}"
  group "#{node.ndenv.user}"
  mode 0644
end

git "#{node.ndenv.ndenv_root}/plugins/ruby-build" do
  repository "git://github.com/riywo/node-build.git"
  reference "master"
  action :checkout
  user "#{node.ndenv.user}"
  group "ndenv"
end
