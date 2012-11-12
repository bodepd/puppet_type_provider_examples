Puppet::Type.type(:custom_package).provide(:gems) do
  confine :feature => :rubygems

  def self.instances
    []
  end

end
