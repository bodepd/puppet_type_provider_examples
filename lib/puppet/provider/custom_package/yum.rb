Puppet::Type.type(:custom_package).provide(:yum) do
  confine :osfamily => :redhat
end
