[puppet-limelight](https://github.com/alphagov/puppet-limelight)

Puppet module for setting up a machine for the [limelight](https://github.com/alphagov/limelight) application.

It does:
- Create the required directories
- Create an nginx vhost
- Install rbenv and dependencies (build-essential etc)
- Create an upstart job

It does not: (and therefore must be done manually for the moment)
- Copy the application code into `/opt/limelight`
- Copy correct configuration files into place
- Run bundle install
