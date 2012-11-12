Puppet::Type.type(:custom_package).provide(:yum) do
  confine :osfamily => :redhat
  defaultfor :osfamily => :redhat

  commands :yum => '/usr/bin/yum',
           :rpm => '/bin/rpm'

  def exists?
    begin
      rpm('-q', resource[:name])
      true
    rescue Puppet::ExecutionFailure => e
      false
    end
  end

  def create
    package= resource[:version] ? "#{resource[:name]}-#{resource[:version]}" : resource[:name]
    yum('install', '-y', package)
  end

  def destroy
    yum('erase', resource[:name])
  end

end
