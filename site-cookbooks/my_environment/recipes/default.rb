#
# Cookbook Name:: my_environment
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#
username = node[:my_environment][:user]

user username do
  home "/home/#{username}"
  shell "/bin/zsh"
  password "$1$E7l6oltO$7Iz2YDdWQwIZSwP0MgbZd0"
  supports :manage_home => true
  action [:create, :manage]
end

group "wheel" do
  action :modify
  members [username]
  append true
end

directory "/home/#{username}/.ssh" do
  owner username
  group username
  mode 0700
  not_if {"test -d /home/#{username}/.ssh"}
end

cookbook_file "/home/#{username}/.ssh/authorized_keys" do
  owner username
  group username
  mode 0600
  source "authorized_keys"
  not_if {"test -f /home/#{username}/.ssh/authorized_keys"}
end

git "/home/#{username}/dotfiles" do
  repository "https://github.com/mostlyfine/dotfiles.git"
  revision "master"
  user username
  group username
  action :checkout
end

directory "/home/#{username}/dotfiles/.vim/bundle" do
  owner username
  group username
end

git "/home/#{username}/dotfiles/.vim/bundle/vundle" do
  repository "https://github.com/gmarik/vundle.git"
  revision "master"
  user username
  group username
  action :checkout
end

%w(.zshrc .zshenv .vim .vimrc .tmux.conf .screenrc .pryrc .irbrc .inputrc .gitconfig .gemrc).each do |file|
  link "/home/#{username}/#{file}" do
    to "/home/#{username}/dotfiles/#{file}"
    link_type :symbolic
  end
end
