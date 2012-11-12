Puppet::Type.newtype(:custom_user) do

  ensurable

  newparam(:name, :namevar => true) do
  end

  newproperty(:uid) do
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:gid) do
  end

  newproperty(:shell) do
  end

  newproperty(:groups, :array_matching => :all) do
  end


end
