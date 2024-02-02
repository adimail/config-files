package main

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	// From the environment
	username := os.Getenv("DB_USERNAME")
	password := os.Getenv("DB_PASSWORD")
	database := "adimail"

	connStr := fmt.Sprintf("user=%s dbname=%s password=%s sslmode=disable", username, database, password)

	db, err := sql.Open("postgres", connStr)

	if err != nil {
		fmt.Println("Error connecting to the database:", err)
		os.Exit(1)
	}
	defer db.Close()

	os.Setenv("PGPASSWORD", password)

	_, err = db.Exec("UPDATE tasks SET \"Time elapsed\" = EXTRACT(EPOCH FROM AGE(NOW(), \"Created\"))")

	if err != nil {
		fmt.Println("Error updating rows:", err)
		os.Exit(1)
	}

}
