$env:DB_NAME = "tasks"

function set-theme {
    oh-my-posh init pwsh --config 'C:\Users\pradi\AppData\Local\Programs\oh-my-posh\themes\jblab_2021.omp.json' | Invoke-Expression
}

function show-commands {
    Write-Host "Available databases: tasks, main"
    Write-Host "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    Write-Host "adimail init :                       Initialize the database connection"
    Write-Host "view-main-database <database> :      Open the specified database contents"
    Write-Host "insert-task <task_name> :            Insert a task into the current database"
    Write-Host "remove-task <task_id> :              Remove a task from the 'tasks' database"
    Write-Host "init :                               Remove a task from the 'tasks' database"
    Write-Host "`nAliases:"
    Write-Host "  - addtask <task_name> :            Alias for 'insert-task'"
    Write-Host "  - at <task_name> :                 Alias for 'insert-task'"
    Write-Host "  - rt <task_name> :                 Alias for 'remove-task'"
    Write-Host "  - tasks :                          Alias for 'view-main-database tasks'"
    Write-Host "`n`n"
}

function init-passwords {
    $env:DB_USERNAME = Read-Host "Enter the database username"
    $env:DB_PASSWORD = Read-Host "Enter the database password"
    $env:DB_NAME = "tasks"
    Clear-Host
}

function init {
    $env:DB_USERNAME = "adimail"
    $env:DB_PASSWORD = "adimail"
    Write-Host "adimail private server login successful `n`n"
}

function adimail ($command) {
    Clear-Host
    figlet -f ogre "adimail  @   postgreSQL"

    Write-Host "`n"

    show-commands
    
    set-theme

    if ($command -eq "init") {
        init-passwords
    }
}

function tasks {
    . C:\Users\pradi\OneDrive\Documents\PowerShell\go\updateDB.exe
    view-main-database tasks
}

function view-main-database ($command) {
    if ($command) {
        $env:DB_NAME = $command
        if ($env:DB_USERNAME) {
            . C:\Users\pradi\OneDrive\Documents\PowerShell\go\viewDatabase.exe
        }
        else {
            Write-Host "Error: Please enter a valid database username before viewing the main database."
        }
    }
    else {
        Write-Host "Please specify the name of database you want to view: tasks, main"
    }
    
}

function insert-task ($command) {
    if ($command) {
        $env:TASK_NAME = $command
        if ($env:DB_USERNAME) {
            . C:\Users\pradi\OneDrive\Documents\PowerShell\go\insertTask.exe
        }
        else {
            Write-Host "Error: Please enter a valid database username before viewing the main database."
            Write-Host "use command -- adimail init -- to initialise the database connection"
        }
    }
    else {
        Write-Host "Please specify the task name"
    }
    
}

function remove-task ($command) {
    $env:DB_NAME = "tasks"

    if ($command) {
        $env:TASK_ID_TO_REMOVE = $command
        if ($env:DB_USERNAME) {
            . C:\Users\pradi\OneDrive\Documents\PowerShell\go\removeTask.exe
        }
        else {
            Write-Host "Error: Please enter a valid database username before viewing the main database."
            Write-Host "use command -- adimail init -- to initialise the database connection"
        }
    }
    else {
        view-main-database tasks
        Write-Host "Please specify the task id"
    }
    
}

