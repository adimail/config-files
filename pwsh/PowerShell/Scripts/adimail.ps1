
function call-figlet-title {
    figlet "adimail  @  PostgreSQL"
}

$env:DB_NAME = "tasks"

function show-commands {
    Write-Host "Avaliable databases: tasks, main"
    Write-Host "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
    Write-Host "adimail init :                       Initiliase the database connection"
    Write-Host "view-main-database $ command :       Open the database contents"
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
    Write-Host "Hi Adi, server login successful"
}

function adimail ($command) {
    Clear-Host
    call-figlet-title
    # show-commands
    oh-my-posh init pwsh --config 'C:\Users\pradi\AppData\Local\Programs\oh-my-posh\themes\jblab_2021.omp.json' | Invoke-Expression

    if ($command -eq "init") {
        init-passwords
    }
}

function view-main-database ($command) {
    
    if ($command) {
        $env:DB_NAME = $command
        if ($env:DB_USERNAME) {
            . C:\Users\pradi\OneDrive\Documents\PowerShell\go\viewDatabase.exe
        }
        else {
            Write-Host "Error: Please enter a valid database username before viewing the main database."
            Write-Host "use command -- adimail init -- to initialise the database connection"
        }
    }
    else {
        Write-Host "Please specify the name of database you want to view: tasks, main"
    }
    
}

function insert-task ($command) {

    init

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