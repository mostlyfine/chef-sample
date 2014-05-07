#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

%w(zsh tmux wget vim git lv curl tig ctags).each do |pkg|
  package pkg do
    action :install
  end
end
