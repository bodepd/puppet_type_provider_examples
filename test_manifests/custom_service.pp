notify { "trigger_service": }
custom_service { 'sshd':
  subscribe => Notify["trigger_service"],
}
