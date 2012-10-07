Puppet::Type.newtype(:custom_package) do

  desc 'custom_package is an example of how to write a Puppet type.'

  feature :versionable, "Package manager interrogate and return software version.", :methods => [:version]

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the software package.'
  end

  newproperty(:version, :required_features => :versionable) do
    desc 'version of a package that should be installed'
    validate do |value|
      fail("Invalid version #{value}") unless value =~ /^[0-9A-Za-z\.-]+$/
    end
  end

  newparam(:source) do
    desc 'Software installation http/https source.'
    newvalues(/https?:\/\//, /\//)
    #validate do |value|
    #  unless Pathname.new(value).absolute? ||
    #          URI.parse(value).is_a?(URI::HTTP)
    #    fail("Invalid source #{value}")
    #  end
    #end
  end

  newparam(:replace_config) do
    desc 'Whether config files should be overridden by package operations'
    defaultto :no
    newvalues(:yes, :no)
  end

  autorequire(:file) do
    self[:source] if self[:source] and Pathname.new(self[:source]).absolute?
  end

  #validate do
  #  fail('source is required when ensure is present') if self[:ensure] == :present and self[:source].nil?
  #end
end
