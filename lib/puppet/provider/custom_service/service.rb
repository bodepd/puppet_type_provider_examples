Puppet::Type.type(:custom_service).provide('service') do
  commands :service => 'service'
  def restart
    service(resource[:name], 'restart')
  end
end
