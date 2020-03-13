define influxdb::privilege (
  Enum['absent', 'present'] $ensure       = present,
  $db_user                                = undef,
  $db_name                                = undef,
  Enum['ALL', 'READ', 'WRITE'] $privilege = 'ALL',
  $https_enable                           = $influxdb::https_enable,
  $http_auth_enabled                      = $influxdb::http_auth_enabled,
  $admin_username                         = $influxdb::admin_username,
  $admin_password                         = $influxdb::admin_password
) {
  if $https_enable {
    $cmd = 'influx -ssl -unsafeSsl'
  } else {
    $cmd = 'influx'
  }
  $matches = "grep ${db_name} | grep ${privilege}"
  if ($ensure == 'absent') and ($http_auth_enabled == true) {
    exec { "revoke_${privilege}_on_${db_name}_to_${db_user}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
      command =>
        "${cmd} -username ${admin_username} -password '${admin_password}' \
         -execute 'REVOKE ${privilege} ON \"${db_name}\" TO \"${db_user}\"'",
      onlyif  =>
        "${cmd} -username ${admin_username} -password '${admin_password}'\
        -execute  'SHOW GRANTS FOR \"${db_user}\"' | ${matches}"
    }
  } elsif ($ensure == 'present') and ($http_auth_enabled == true) {
    exec { "grant_${privilege}_on_${db_name}_to_${db_user}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
      command =>
        "${cmd} -username ${admin_username} -password '${admin_password}' \
        -execute 'GRANT ${privilege} ON \"${db_name}\" TO \"${db_user}\"'",
      unless  =>
        "${cmd} -username ${admin_username} -password '${admin_password}' \
        -execute 'SHOW GRANTS FOR \"${db_user}\"' | ${matches}"
    }
  } elsif ($ensure == 'absent') and ($http_auth_enabled == false) {
    exec { "revoke_${privilege}_on_${db_name}_to_${db_user}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
      command =>
        "${cmd} -execute 'REVOKE ${privilege} ON \"${db_name}\" \
        TO \"${db_user}\"'",
      onlyif  =>
        "${cmd} -execute  'SHOW GRANTS FOR \"${db_user}\"' | ${matches}"
    }
  } elsif ($ensure == 'present') and ($http_auth_enabled == false) {
    exec { "grant_${privilege}_on_${db_name}_to_${db_user}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin',
      command =>
        "${cmd} -execute 'GRANT ${privilege} ON \"${db_name}\" \
        TO \"${db_user}\"'",
      unless  =>
        "${cmd} -execute 'SHOW GRANTS FOR \"${db_user}\"' | ${matches}"
    }
  }
}
