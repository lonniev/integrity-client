name             'integrity-client'
maintainer       'Lonnie VanZandt'
maintainer_email 'lonniev@gmail.com'
license          'Apache 2.0'
description      'Installs the PTC Integrity Client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'ssh'
depends          'chef-solo-search'
depends          'users'