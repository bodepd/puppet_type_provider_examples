Puppet::Type.type(:custom_package).provide(:apt) do
  commands :apt_get => "apt-get"
  def force_install_package(package_name = resource[:name])
    apt_get('install', '-f', package_name)
  end
end
