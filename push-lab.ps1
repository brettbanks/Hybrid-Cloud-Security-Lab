# push-lab.ps1 — Automate README + docs push to GitHub
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "----------------------------------------"
Write-Host "Hybrid Cloud Security Lab Auto-Push Tool"
Write-Host "----------------------------------------`n"

Write-Host "[1/4] Adding all changes..." -ForegroundColor Cyan
git add -A

Write-Host "[2/4] Committing changes..." -ForegroundColor Cyan
git commit -m "Automated push: Hybrid Cloud Security Lab update ($timestamp)"

Write-Host "[3/4] Pulling latest from remote..." -ForegroundColor Cyan
git pull origin main --rebase

Write-Host "[4/4] Pushing to GitHub..." -ForegroundColor Cyan
git push origin main

Write-Host "`n----------------------------------------"
Write-Host "Sync complete! ($timestamp)" -ForegroundColor Green
Write-Host "----------------------------------------"
