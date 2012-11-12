Puppet::Type.type(:agent_config).provide(:parsed) do
  confine :exists => Puppet[:config]
  confine :true => begin
    if File.exists?(Puppet[:config])
      File.readlines(Puppet[:config]).find {|line|  line =~ /^\s*\[agent\]/ }
    end
  end
end
