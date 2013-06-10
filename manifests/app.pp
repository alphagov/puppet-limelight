define limelight::app(
  $port,
  $user,
  $group,
  $domain_name,
) {
  $app_path = "/opt/${title}"
  $log_path = "/var/log/${title}"
  $config_path = "/etc/opt/${title}"

  file { [$app_path, $log_path, $config_path]:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  include nginx::server
  nginx::vhost::proxy { 'limelight-vhost':
    port          => 80,
    servername    => join([$title, $domain_name], '.'),
    ssl           => false,
    upstream_port => $port,
  }


  include upstart
  upstart::job { $title:
    description   => $title,
    respawn       => true,
    respawn_limit => '5 10',
    user          => $user,
    group         => $group,
    chdir         => $app_path,
    environment   => {
      'GOVUK_ENV' => 'production',
      'RAILS_ENV' => 'production',
      'GOVUK_APP_DOMAIN' => 'production.alphagov.co.uk',
      'BACKDROP_URL' => 'read.backdrop',
    },
    exec          => "bundle exec unicorn_rails -p $port",
  }

}
