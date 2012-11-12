Puppet::Type.type(:custom_package).provide(:yum) do

  confine :osfamily => :redhat
  defaultfor :osfamily => :redhat

  commands :yum => '/usr/bin/yum',
           :rpm => '/bin/rpm'

  mk_resource_methods

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

  def create
    if resource[:version]
     yum('install', '-y', "#{resource[:name]}-#{resource[:version]}") 
    else
      yum('install', '-y', resoure[:name])
    end
    @property_hash[:ensure] = :present
  end

  def destroy
    yum('erase', resource[:name])
    @property_hash[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def version=(value)
    yum('install', "#{resource[:name]}-#{resource[:version]}")
    @property_hash[:version] = value
  end

end
