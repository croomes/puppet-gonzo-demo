class role_puppet_master {
  include profile_gonzo::server
  include profile_puppet_master
  include profile_enc
  include profile_bamboo
}