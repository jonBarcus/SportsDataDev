sqlInsert = "INSERT INTO states (id, name, capital)
			values (?, ?, ?)"

def add_states(connection)

sqlInsert = "INSERT INTO states (id, name, capital)
                        values (?, ?, ?)"

	connection.exec(sqlInsert, "AL", "Alabama", "Birmingham")
	connection.exec(sqlInsert, "AZ", "Arizona", "Phoenix")
	connection.exec(sqlInsert, "CO", "Colorado", "Denver")
	connection.exec(sqlInsert, "FL", "Florida", "Tallahassee")

end
