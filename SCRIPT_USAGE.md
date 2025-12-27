# Quick Deploy Script Usage Guide

## Script Fixed Issues

The `quick-deploy.ps1` script has been completely rewritten to fix:
- Removed all emoji characters (causing encoding issues)
- Removed all Chinese characters (causing parsing errors)
- Fixed all syntax errors (missing brackets, quotes)
- Fixed string termination issues
- Ensured all code blocks are properly closed
- Used English-only text for compatibility

## How to Run the Script

### Method 1: Direct Execution (Recommended)

1. **Open PowerShell** (as Administrator if needed)
2. **Navigate to project directory:**
   ```powershell
   cd "C:\Users\Louis Lu\cursor-website"
   ```

3. **Set execution policy (if needed, one-time only):**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **Run the script:**
   ```powershell
   .\quick-deploy.ps1
   ```

### Method 2: Run with Explicit PowerShell

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\Louis Lu\cursor-website\quick-deploy.ps1"
```

## What the Script Does

The script automates the following steps:

1. **Checks Git Installation**
   - Verifies Git is installed
   - Shows version if available

2. **Checks Git Configuration**
   - Verifies username and email are set
   - Prompts to configure if missing

3. **Initializes Git Repository**
   - Checks if `.git` folder exists
   - Initializes if needed

4. **Configures Remote Repository**
   - Checks if remote origin is set
   - Prompts for GitHub repository URL if missing

5. **Commits Files**
   - Adds all files to Git
   - Commits with custom or default message

6. **Pushes to GitHub**
   - Pushes to main/master branch
   - Handles authentication prompts

## Expected Output

```
========================================
GitHub Auto Deploy Quick Script
========================================

[1/6] Checking Git installation...
[OK] Git is installed: git version 2.x.x

[2/6] Checking Git configuration...
[OK] Username: YourName
[OK] Email: your.email@example.com

[3/6] Checking Git repository...
[OK] Git repository is initialized

[4/6] Checking remote repository...
[WARNING] Remote repository not configured
Please enter your GitHub repository URL: https://github.com/username/repo.git
[OK] Remote repository has been configured

[5/6] Adding files to Git...
Detected uncommitted files, committing...
Please enter commit message (press Enter for default): 
[OK] Files have been committed

[6/6] Pushing to GitHub...
Pushing to GitHub...
[OK] Code has been pushed to GitHub

========================================
Complete!
========================================
```

## Troubleshooting

### Issue 1: "Execution Policy" Error

**Error:**
```
cannot be loaded because running scripts is disabled on this system
```

**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Issue 2: "Git not found" Error

**Error:**
```
[ERROR] Git is not installed
```

**Solution:**
1. Download Git from: https://git-scm.com/download/win
2. Install with default options
3. Restart PowerShell
4. Run script again

### Issue 3: Authentication Failed

**Error:**
```
remote: Support for password authentication was removed
```

**Solution:**
1. Generate Personal Access Token:
   - Go to: https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Select `repo` scope
   - Copy the token
2. When prompted for password, paste the token instead

### Issue 4: "Remote repository already exists"

**Error:**
```
fatal: remote origin already exists
```

**Solution:**
```powershell
# Remove existing remote
git remote remove origin

# Run script again or add manually
git remote add origin https://github.com/username/repo.git
```

## Manual Steps (If Script Fails)

If the script fails at any step, you can execute commands manually:

```powershell
# 1. Initialize Git
git init

# 2. Configure Git (if needed)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 3. Add remote repository
git remote add origin https://github.com/username/repo.git

# 4. Add and commit files
git add .
git commit -m "Initial commit"

# 5. Push to GitHub
git branch -M main
git push -u origin main
```

## Script Features

- **Error Handling**: Checks each step before proceeding
- **User-Friendly**: Clear prompts and status messages
- **Safe**: Does not overwrite existing configurations
- **Compatible**: Works with Windows PowerShell 5.1 and later

## Next Steps After Running Script

1. **Configure GitHub Secrets:**
   - Go to your GitHub repository
   - Settings → Secrets and variables → Actions
   - Add required secrets (AWS/Vercel keys)

2. **Connect to Deployment Platform:**
   - AWS Amplify: https://console.aws.amazon.com/amplify
   - Vercel: https://vercel.com
   - Connect your GitHub repository

3. **Verify Deployment:**
   - Check GitHub Actions tab for deployment status
   - View deployment logs if needed

## Support

If you encounter any issues:
1. Check the error message carefully
2. Review the troubleshooting section above
3. Check DEPLOYMENT_GUIDE.md for detailed steps
4. Verify all prerequisites are met

