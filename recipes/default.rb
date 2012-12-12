#
# Cookbook Name:: sysctl
# Recipe:: default
#
# Copyright 2011, Fewbytes Technologies LTD
#

sysctl_path = if(node[:sysctl][:conf_dir])
                File.join(node[:sysctl][:conf_dir], '99-chef-attributes.conf')
              else
                node[:sysctl][:allow_sysctl_conf] ? '/etc/sysctl.conf' : nil
              end

if(sysctl_path)
  template sysctl_path do
    source 'sysctl.conf.erb'
    mode '0644'
    notifies :start, "service[procps]", :immediately
    only_if do
      node[:sysctl][:attributes] && !node[:sysctl][:attributes].empty?
    end
  end


cookbook_file "/etc/sysctl.d/69-chef-static.conf" do
  ignore_failure true
  mode "0644"
  notifies :start, "service[procps]", :immediately
end

service "procps"
