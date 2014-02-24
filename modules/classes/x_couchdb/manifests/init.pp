class x_couchdb (
  $allow_jsonp = true,
  $bind_address = '0.0.0.0',
) {
  class { 'couchdb': 
    allow_jsonp  => $allow_jsonp,
    bind_address => $bind_address,
  }
}