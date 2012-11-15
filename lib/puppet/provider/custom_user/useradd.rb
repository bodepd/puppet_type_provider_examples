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

  def initialize(value={})
    super(value)
    @property_flush = {}
  end

  def create
    options = []
    (options << '-u' << resource[:uid])   if resource[:uid]
    (options << '-g' << resource[:gid])   if resource[:gid]
    (options << '-s' << resource[:shell]) if resource[:shell]
    useradd(resource[:name], options)
  end

  def destroy
    userdel(resource[:name])
    @property_hash.clear
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def uid=(value)
    @property_flush[:uid] = value
  end

  def gid=(value)
    @property_flush[:gid] = value
  end

  def shell=(value)
    @property_flush[:shell] = value
  end

  def flush
    options = []
      if @property_flush
      (options << '-u' << resource[:uid])   if @property_flush[:uid]
      (options << '-g' << resource[:gid])   if @property_flush[:gid]
      (options << '-s' << resource[:shell]) if @property_flush[:shell]
      unless options.empty?
        usermod(options, resource[:name]) unless options.empty?
      end
    end
    @property_hash = resource.to_hash
  end

end
