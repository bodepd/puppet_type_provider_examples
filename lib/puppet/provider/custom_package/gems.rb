Puppet::Type.type(:custom_package).provide(:gems) do
  confine :feature => :rubygems

end
