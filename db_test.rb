require 'oci8'
require 'pry'

# must execute this .rb with "SUDO -E" prepended to use oci8 and environmental variables

dbconnect = OCI8.new("#{ENV['SPORTSDBUSER']}/#{ENV['SPORTSDATADEV_PASS']}@//#{ENV['SPORTSDB_HOSTNAME']}:1512/xe")

dbconnect.exec("CREATE TABLE states (
		id CHAR(2) PRIMARY KEY,
		name VARCHAR2(15) NOT NULL,
		capital VARCHAR2(25) NOT NULL)")

sqlInsert = "INSERT INTO states (id, name, capital) values (:id, :name, :capital)"

dbconnect.exec(sqlInsert, "MA", "Massachusetts", "Boston")
dbconnect.commit

dbconnect.logoff

