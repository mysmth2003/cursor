# Apply Amplify Configuration Fix
# This script commits and pushes the fixed amplify.yml file

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Applying Amplify Configuration Fix" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if in correct directory
if (-not (Test-Path "amplify.yml")) {
    Write-Host "[ERROR] amplify.yml not found in current directory" -ForegroundColor Red
    Write-Host "Please run this script from the project root directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "[1/3] Checking Git status..." -ForegroundColor Yellow
$status = git status --porcelain amplify.yml 2>&1
if ($status -and $status -notmatch "error") {
    Write-Host "[OK] amplify.yml has changes" -ForegroundColor Green
} else {
    Write-Host "[INFO] No changes detected in amplify.yml" -ForegroundColor Yellow
    Write-Host "The file may already be committed or unchanged" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[2/3] Adding and committing fix..." -ForegroundColor Yellow
git add amplify.yml
if ($LASTEXITCODE -eq 0) {
    git commit -m "Fix amplify.yml: Use proper YAML array format for commands"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Changes committed successfully" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] Commit may have failed (file may be unchanged)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[ERROR] Failed to add file to Git" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[3/3] Pushing to GitHub..." -ForegroundColor Yellow
$currentBranch = git branch --show-current 2>&1
if ($currentBranch -and $currentBranch -notmatch "error") {
    $currentBranch = $currentBranch.Trim()
    git push origin $currentBranch
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Code pushed to GitHub successfully" -ForegroundColor Green
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "Fix Applied Successfully!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor Yellow
        Write-Host "1. Check GitHub Actions for deployment status" -ForegroundColor White
        Write-Host "2. Check AWS Amplify console for build status" -ForegroundColor White
        Write-Host "3. Verify deployment succeeds without format errors" -ForegroundColor White
    } else {
        Write-Host "[WARNING] Push may require authentication" -ForegroundColor Yellow
        Write-Host "Please push manually: git push origin $currentBranch" -ForegroundColor Yellow
    }
} else {
    Write-Host "[ERROR] Could not determine current branch" -ForegroundColor Red
    Write-Host "Please push manually: git push origin main" -ForegroundColor Yellow
}

Write-Host ""

