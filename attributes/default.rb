default[:sysctl][:conf_dir] = case node.platform_family
  when 'debian'
    '/etc/sysctl.d'
  else
    nil
  end
default[:sysctl][:attributes] = {}
default[:sysctl][:allow_sysctl_conf] = false
