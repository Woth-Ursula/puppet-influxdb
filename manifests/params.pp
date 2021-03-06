# @summary Parameter definiton
#
# @example
#   include influxdb::params
class influxdb::params (

  Boolean $manage_repo = true,
  String $package_name = 'influxdb',
  String $ensure = 'present',
  Stdlib::HTTPSUrl $repo_location = 'https://repos.influxdata.com/',
  String $repo_type = 'stable',

  String $group = 'influxdb',
  String $user = 'influxdb',

  Stdlib::Absolutepath $configuration_path = '/etc/influxdb',
  String $configuration_file = 'influxdb.conf',
  String $configuration_template= 'influxdb/influxdb.conf.erb',
  Stdlib::Absolutepath $service_defaults = '/etc/default/influxdb',
  String $service_default_template = 'influxdb/service-defaults.erb',
  Stdlib::Absolutepath $service_definition = '/lib/systemd/system/influxdb.service',
  String $service_definition_template = 'influxdb/systemd.service.erb',
  String $service_name = 'influxdb',
  String $service_provider = 'systemd',
  Stdlib::Ensure::Service $service_ensure = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,
  Boolean $manage_service = true,

# database, user, grant, retention
  String $admin = 'admin',
  String $admin_password = '',
  Hash $users = {},
  Hash $grants = {},
  Hash $databases = {},
  Hash $retentions = {},

# configuration template
#  header
  Boolean $reporting_disabled = false,
  String $rpc_bind_address = '127.0.0.1:8088',

#  meta
  String $metadata_raft = '/var/lib/influxdb/meta',
  Hash $meta_obligatory = {
    'dir' => $metadata_raft,
  },

#  data obligatory
  String $tsm_data = '/var/lib/influxdb/data',
  String $tsm_wal = '/var/lib/influxdb/wal',
  Integer $series_id_set_cache_size = 100,
  Hash $data_obligatory = {
    'dir' => $tsm_data,
    'wal-dir' => $tsm_wal,
    'series-id-set-cache-size' => $series_id_set_cache_size,
  },

# http obligatory
  Boolean $https_enabled = false,
  Boolean $auth_enabled = false,
  Hash $http_obligatory = {
    'https-enabled' => $https_enabled,
    'auth-enabled' => $auth_enabled,
  },

  Hash $meta = {},
  Hash $data = {},
  Hash $coordinator = {},
  Hash $retention = {},
  Hash $shard_precreation = {},
  Hash $monitor = {},
  Hash $http = {},
  Hash $logging = {},
  Hash $subscriber = {},
  Hash $graphite = {},
  Hash $collectd = {},
  Hash $opentsdb = {},
  Hash $udp = {},
  Hash $continuous_queries = {},
  Hash $tls = {},

  ){

}
