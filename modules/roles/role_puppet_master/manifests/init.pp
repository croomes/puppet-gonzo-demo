class role_puppet_master {
  include gonzo
  include profile_puppet_master
  include profile_enc
  include profile_bamboo
}