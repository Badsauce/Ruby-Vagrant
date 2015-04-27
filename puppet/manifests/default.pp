include rvm

class { 'nodejs':
  version => 'stable',
  make_install => false,
}

rvm_system_ruby {
  'ruby-2.2.2':
    ensure      => 'present',
    default_use => true,
}

rvm_gem {
  'bundler':
    name         => 'bundler',
    ruby_version => 'ruby-2.2.2',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.2.2'];
}

exec { 'fix_rvm_permissions':
  command => '/bin/chmod -R 775 /usr/local/rvm ; /bin/chown -R :rvm /usr/local/rvm',
  require => Rvm_gem["bundler"]
}
