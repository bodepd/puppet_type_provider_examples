Puppet::Type.type(:custom_package).provide(:rpm) do
  confine :osfamily => :redhat
end
