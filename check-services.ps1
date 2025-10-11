Write-Host "=== Checking NotesApp Services ===" -ForegroundColor Green

# Проверка сервисов Swarm
Write-Host "`nStack services:" -ForegroundColor Yellow
docker stack services notesapp

Write-Host "`nService details:" -ForegroundColor Yellow
docker service ls

Write-Host "`nContainer status:" -ForegroundColor Yellow
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

Write-Host "`n=== Health Checks ===" -ForegroundColor Green

# Проверка NGINX
Write-Host "`n1. NGINX health:" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost/nginx-health" -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✅ NGINX is healthy: $($response.Content)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ NGINX not available: $($_.Exception.Message)" -ForegroundColor Red
}

# Проверка Auth Service
Write-Host "`n2. Auth Service health:" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost/api/auth/health" -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✅ Auth Service: $($response.status)" -ForegroundColor Green
    Write-Host "      Version: $($response.version)" -ForegroundColor Gray
    Write-Host "      Uptime: $([math]::Round($response.uptime, 2))s" -ForegroundColor Gray
} catch {
    Write-Host "   ❌ Auth Service not available: $($_.Exception.Message)" -ForegroundColor Red
    
    # Попробуем прямой доступ к сервису
    Write-Host "   Trying direct access to auth-service..." -ForegroundColor Gray
    try {
        $directResponse = Invoke-RestMethod -Uri "http://localhost:3001/health" -TimeoutSec 3 -ErrorAction Stop
        Write-Host "   ✅ Auth Service direct access: $($directResponse.status)" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ Auth Service direct access also failed" -ForegroundColor Red
    }
}

# Проверка Notes Service
Write-Host "`n3. Notes Service health:" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost/api/notes/health" -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✅ Notes Service: $($response.status)" -ForegroundColor Green
    Write-Host "      Version: $($response.version)" -ForegroundColor Gray
    Write-Host "      Uptime: $([math]::Round($response.uptime, 2))s" -ForegroundColor Gray
} catch {
    Write-Host "   ❌ Notes Service not available: $($_.Exception.Message)" -ForegroundColor Red
    
    # Попробуем прямой доступ к сервису
    Write-Host "   Trying direct access to notes-service..." -ForegroundColor Gray
    try {
        $directResponse = Invoke-RestMethod -Uri "http://localhost:3002/health" -TimeoutSec 3 -ErrorAction Stop
        Write-Host "   ✅ Notes Service direct access: $($directResponse.status)" -ForegroundColor Green
    } catch {
        Write-Host "   ❌ Notes Service direct access also failed" -ForegroundColor Red
    }
}

# Проверка API endpoints
Write-Host "`n=== API Endpoints Check ===" -ForegroundColor Green

Write-Host "`n4. Auth Service endpoints:" -ForegroundColor Yellow
try {
    $authResponse = Invoke-RestMethod -Uri "http://localhost/api/auth/login" -Method Post -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✅ POST /api/auth/login: $($authResponse.message)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ POST /api/auth/login failed" -ForegroundColor Red
}

Write-Host "`n5. Notes Service endpoints:" -ForegroundColor Yellow
try {
    $notesResponse = Invoke-RestMethod -Uri "http://localhost/api/notes/" -Method Get -TimeoutSec 5 -ErrorAction Stop
    Write-Host "   ✅ GET /api/notes: $($notesResponse.message)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ GET /api/notes failed" -ForegroundColor Red
}

Write-Host "`n=== Check completed ===" -ForegroundColor Green