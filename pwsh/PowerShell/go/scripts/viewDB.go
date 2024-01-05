package main

import (
	"database/sql"
	"fmt"
	"os"
	"os/exec"

	_ "github.com/lib/pq"
)

func viewDB() {
	// From the environment
	username := os.Getenv("DB_USERNAME")
	password := os.Getenv("DB_PASSWORD")
	database := os.Getenv("DB_NAME")

	connStr := fmt.Sprintf("user=%s dbname=%s password=%s sslmode=disable", username, database, password)

	db, err := sql.Open("postgres", connStr)

	if err != nil {
		fmt.Println("Error connecting to the database:", err)
		os.Exit(1)
	}
	defer db.Close()

	os.Setenv("PGPASSWORD", password)

	// "psql -U adimail -d adimail -c 'SELECT * FROM main;'"
	cmd := exec.Command("psql", "-U", username, "-d", "adimail", "-c", fmt.Sprintf("SELECT * FROM %s;", database))
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	err = cmd.Run()
	if err != nil {
		fmt.Println("Error executing psql command:", err)
	}
}
