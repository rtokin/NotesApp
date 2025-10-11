Write-Host "=== Deploying NotesApp with Docker Swarm ===" -ForegroundColor Green

# Сборка образов
Write-Host "Building Docker images..." -ForegroundColor Yellow
docker build -t notesapp-auth-service ./auth-service
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Failed to build auth-service" -ForegroundColor Red
    exit 1
}

docker build -t notesapp-notes-service ./notes-service
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Failed to build notes-service" -ForegroundColor Red
    exit 1
}

docker build -t notesapp-nginx ./nginx
if ($LASTEXITCODE -ne 0) { 
    Write-Host "Failed to build nginx" -ForegroundColor Red
    exit 1
}

# Инициализация Swarm (если еще не инициализирован)
$swarmInfo = docker info --format "{{.Swarm.LocalNodeState}}" 2>$null
if ($LASTEXITCODE -ne 0 -or $swarmInfo -eq "inactive" -or $swarmInfo -eq $null) {
    Write-Host "Initializing Docker Swarm..." -ForegroundColor Yellow
    docker swarm init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to initialize Swarm" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Docker Swarm already initialized: $swarmInfo" -ForegroundColor Green
}

# Развертывание стека
Write-Host "Deploying stack..." -ForegroundColor Yellow
docker stack deploy -c docker-stack.yml notesapp
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to deploy stack" -ForegroundColor Red
    exit 1
}

Write-Host "Waiting for services to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Проверка статуса
Write-Host "=== Stack Status ===" -ForegroundColor Green
docker stack services notesapp

Write-Host "`n=== Service Details ===" -ForegroundColor Green
docker service ls

Write-Host "`n=== Deployment completed ===" -ForegroundColor Green
Write-Host "NGINX is available on: http://localhost" -ForegroundColor Cyan
Write-Host "Auth Service: http://localhost/api/auth" -ForegroundColor Cyan
Write-Host "Notes Service: http://localhost/api/notes" -ForegroundColor Cyan
Write-Host "`nUse .\check-services.ps1 to verify services" -ForegroundColor Yellow