Puppet::Type.newtype(:custom_user) do

  ensurable

  newparam(:name) do

  end

  newparam(:uid) do
    munge do |value|
      Integer(value)
    end
  end

  newproperty(:groups, :array_matching => :all) do
  end

end
