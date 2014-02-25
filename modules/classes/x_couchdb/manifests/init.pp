class x_couchdb (
  $allow_jsonp    = true,
  $bind_address   = '0.0.0.0',
  $admin_password = '-hashed-0fbf898a7cbf8914e05125e082bc625ed237b272,a0582d353b0b52e386935885727d90d1', # admin
  $secret         = 'ef57deee6719bbb2ea2a163b1623b284',
) {
  class { 'couchdb':
    allow_jsonp    => $allow_jsonp,
    bind_address   => $bind_address,
    admin_password => $admin_password,
    secret         => $secret,
  }
}