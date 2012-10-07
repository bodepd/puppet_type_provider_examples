Puppet::Type.newtype(:custom_service) do

  newparam(:name, :namevar => true) do
  end

  # This sample service has no state just refresh ability.
  def refresh
    if (@parameters[:ensure] == :running)
      provider.restart
    else
      debug "Skipping restart; service is not running"
    end
  end
end
