Puppet::Type.type(:custom_user).provide(:useradd) do

  commands :useradd => "useradd", :userdel => "userdel", :usermod => "usermod"

  mk_resource_methods

  def self.prefetch(resources)
    users = instances
    resources.keys.each do |name|
      if provider = users.find{ |usr| usr.name == name }
        resources[name].provider = provider
      end
    end
  end

  def self.instances
    users = []
    Etc.setpwent
    begin
      while ent = Etc.getpwent
        users << new(
                   :name   => ent.name,
                   :uid    => ent.uid,
                   :gid    => ent.gid,
                   :shell  => ent.shell,
                   :ensure => :present
                 )
      end
    ensure
      Etc.endpwent
    end
    users
  end

  def create
    options = []
    (options << '-u' << resource[:uid])   if resource[:uid]
    (options << '-g' << resource[:gid])   if resource[:gid]
    (options << '-s' << resource[:shell]) if resource[:shell]
    useradd(resource[:name], options)
    @property_hash[:ensure] = :present
  end

  def destroy
    userdel(resource[:name])
    @property_hash[:ensure] = :absent
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def flush
    if @property_hash[:ensure] == :present
      usermod('-u', @property_hash[:uid], '-g', @property_hash[:gid], '-s', @property_hash[:shell], resource[:name])
    end
  end

end
