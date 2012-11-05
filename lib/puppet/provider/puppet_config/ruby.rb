Puppet::Type.type(:puppet_config).provide(:ruby) do
  # Puppet[:config] varies depending on the account running puppet.
  # ~/.puppet/puppet.conf or /etc/puppet/puppet.conf
  confine :exists => Puppet[:config]
end
