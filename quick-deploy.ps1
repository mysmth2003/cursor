# GitHub Auto Deploy Quick Script
# Usage: Run .\quick-deploy.ps1 in project directory
# Encoding: UTF-8 with BOM (for Windows PowerShell compatibility)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GitHub Auto Deploy Quick Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Git Installation
Write-Host "[1/6] Checking Git installation..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Git is installed: $gitVersion" -ForegroundColor Green
    } else {
        throw "Git not found"
    }
} catch {
    Write-Host "[ERROR] Git is not installed" -ForegroundColor Red
    Write-Host "Please visit https://git-scm.com/download/win to download and install Git" -ForegroundColor Yellow
    exit 1
}

# Step 2: Check Git Configuration
Write-Host ""
Write-Host "[2/6] Checking Git configuration..." -ForegroundColor Yellow
$userName = git config --global user.name 2>&1
$userEmail = git config --global user.email 2>&1

if ($userName -and $userName -notmatch "error" -and $LASTEXITCODE -eq 0) {
    Write-Host "[OK] Username: $userName" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Username not configured" -ForegroundColor Yellow
    $name = Read-Host "Please enter your Git username"
    if ($name) {
        git config --global user.name $name
        Write-Host "[OK] Username has been set" -ForegroundColor Green
    }
}

if ($userEmail -and $userEmail -notmatch "error" -and $LASTEXITCODE -eq 0) {
    Write-Host "[OK] Email: $userEmail" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Email not configured" -ForegroundColor Yellow
    $email = Read-Host "Please enter your Git email"
    if ($email) {
        git config --global user.email $email
        Write-Host "[OK] Email has been set" -ForegroundColor Green
    }
}

# Step 3: Check Git Repository
Write-Host ""
Write-Host "[3/6] Checking Git repository..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "[OK] Git repository is initialized" -ForegroundColor Green
} else {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Git repository has been initialized" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Failed to initialize Git repository" -ForegroundColor Red
        exit 1
    }
}

# Step 4: Check Remote Repository
Write-Host ""
Write-Host "[4/6] Checking remote repository..." -ForegroundColor Yellow
$remote = git remote get-url origin 2>&1
if ($remote -and $remote -notmatch "error" -and $LASTEXITCODE -eq 0) {
    Write-Host "[OK] Remote repository is configured: $remote" -ForegroundColor Green
} else {
    Write-Host "[WARNING] Remote repository not configured" -ForegroundColor Yellow
    $repoUrl = Read-Host "Please enter your GitHub repository URL (e.g., https://github.com/username/repo.git)"
    if ($repoUrl) {
        git remote add origin $repoUrl
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] Remote repository has been configured" -ForegroundColor Green
        } else {
            Write-Host "[ERROR] Failed to add remote repository" -ForegroundColor Red
        }
    }
}

# Step 5: Add and Commit Files
Write-Host ""
Write-Host "[5/6] Adding files to Git..." -ForegroundColor Yellow
git add .
$status = git status --porcelain 2>&1
if ($status -and $status -notmatch "error") {
    Write-Host "Detected uncommitted files, committing..." -ForegroundColor Yellow
    $commitMsg = Read-Host "Please enter commit message (press Enter for default)"
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        $dateStr = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $commitMsg = "Update: $dateStr"
    }
    git commit -m $commitMsg
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Files have been committed" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] Commit may have failed, check the output above" -ForegroundColor Yellow
    }
} else {
    Write-Host "[OK] No files to commit" -ForegroundColor Green
}

# Step 6: Push to GitHub
Write-Host ""
Write-Host "[6/6] Pushing to GitHub..." -ForegroundColor Yellow
$currentBranch = git branch --show-current 2>&1
if ($currentBranch -and $currentBranch -notmatch "error" -and $LASTEXITCODE -eq 0) {
    $currentBranch = $currentBranch.Trim()
    if ($currentBranch -notmatch "main" -and $currentBranch -notmatch "master") {
        Write-Host "Current branch: $currentBranch" -ForegroundColor Yellow
        $rename = Read-Host "Rename to main? (y/n)"
        if ($rename -eq "y" -or $rename -eq "Y") {
            git branch -M main
            if ($LASTEXITCODE -eq 0) {
                $currentBranch = "main"
            }
        }
    }
} else {
    $currentBranch = "main"
    Write-Host "Using default branch: main" -ForegroundColor Yellow
}

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
try {
    git push -u origin $currentBranch 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Code has been pushed to GitHub" -ForegroundColor Green
    } else {
        Write-Host "[WARNING] Push may require authentication" -ForegroundColor Yellow
        Write-Host "If prompted for password, use GitHub Personal Access Token" -ForegroundColor Yellow
        Write-Host "Generate Token: https://github.com/settings/tokens" -ForegroundColor Cyan
    }
} catch {
    Write-Host "[WARNING] Push may require authentication" -ForegroundColor Yellow
    Write-Host "If prompted for password, use GitHub Personal Access Token" -ForegroundColor Yellow
    Write-Host "Generate Token: https://github.com/settings/tokens" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Configure Secrets in GitHub repository page" -ForegroundColor White
Write-Host "2. Connect GitHub repository in AWS Amplify or Vercel" -ForegroundColor White
Write-Host "3. View detailed steps: Open DEPLOYMENT_GUIDE.md" -ForegroundColor White
Write-Host ""
