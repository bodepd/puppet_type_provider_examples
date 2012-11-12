Puppet::Type.newtype(:custom_service) do
  # This sample service has not state just refresh ability.
  def refresh
    if (@parameters[:ensure] == :running)
      provider.restart
    else
      debug "Skipping restart; service is not running"
    end
  end
end
