require 'oci8'
require 'pry'


dbconnect = OCI8.new($SPORTSDBUSER,$SPORTSDATADEV_PASS,$SPORTSDB_HOSTNAME)

binding.pry
