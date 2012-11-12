Puppet::Type.type(:custom_package).provide(:rpm) do
  confine :osfamily => :redhat

  commands :rpm => '/bin/rpm'

  mk_resource_methods

  def self.prefetch(resources)
    packages = instances
    resources.keys.each do |name|
      if provider = packages.find{ |pkg| pkg.name == name }
        resources[name].provider = provider
      end
    end
  end

  def self.instances
    packages = rpm('-qa','--qf','%{NAME} %{VERSION}-%{RELEASE}\n')
    packages.split("\n").collect do |line|
      name, version = line.split(' ', 2)
      new( :name   => name,
        :ensure => :present,
        :version => version
      )
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  #def version
  #  @property_hash[:version]
  #end

end
