#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2014, mostlyfine
#
# All rights reserved - Do Not Redistribute
#
package "tzdata"

case node.platform_family
when 'debian', 'ubuntu'
  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "/usr/sbin/dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end

when 'rhel', 'centos', 'scientific', 'amazon'
  link "/etc/localtime" do
    to "/usr/share/zoneinfo/#{node.timezone}"
  end

  clock = Chef::Util::FileEdit.new("/etc/sysconfig/clock")
  clock.search_file_replace_line(/^ZONE=.*$/, "ZONE=\"#{node.timezone}\"")
  clock.write_file
end
