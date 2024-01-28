package main

import (
	"database/sql"
	"fmt"
	"os"
	"time"

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

	// Inserting a row into the table
	task := os.Getenv("TASK_NAME")
	created := time.Now().Format("2006-01-02")

	_, err = db.Exec("INSERT INTO tasks (\"Task\", \"Created\") VALUES ($1, $2)", task, created)

	if err != nil {
		fmt.Println("Error inserting row:", err)
		os.Exit(1)
	}

	fmt.Println("Task added successfully!")

	if err != nil {
		fmt.Println("Error executing psql command:", err)
	}
}
