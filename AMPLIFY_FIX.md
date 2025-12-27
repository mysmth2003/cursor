# AWS Amplify Configuration Fix

## Issue Fixed

**Error:** `CustomerError: Invalid build spec: Expected "commands" key to be an array in the frontend phase.`

**Root Cause:** The `commands` field in `amplify.yml` was not in proper YAML array format.

**Solution:** Fixed the configuration to use proper YAML array syntax with empty arrays `[]` for static websites.

## What Was Changed

### Before (Incorrect):
```yaml
preBuild:
  commands:
    echo "Pre-build phase completed"
```

### After (Correct):
```yaml
preBuild:
  commands: []
```

## Configuration Details

The fixed `amplify.yml` file:
- Uses proper YAML array syntax (`commands: []`)
- Uses 2-space indentation (no tabs)
- Minimal configuration for static websites
- No build commands needed (static files only)
- Deploys all files from root directory (`baseDirectory: /`)

## How to Apply the Fix

### Step 1: Verify the File

The `amplify.yml` file in your project directory has already been updated with the correct format.

### Step 2: Commit and Push

```powershell
# Navigate to project directory
cd "C:\Users\Louis Lu\cursor-website"

# Add the fixed file
git add amplify.yml

# Commit the fix
git commit -m "Fix amplify.yml: Use proper YAML array format for commands"

# Push to GitHub (this will trigger automatic deployment)
git push origin main
```

### Step 3: Verify Deployment

1. **Check GitHub Actions:**
   - Go to your GitHub repository
   - Click on "Actions" tab
   - Verify the workflow runs successfully

2. **Check AWS Amplify Console:**
   - Go to https://console.aws.amazon.com/amplify
   - Select your app
   - Check the latest deployment status
   - The deployment should now succeed without the format error

## Configuration Explanation

```yaml
version: 1                    # Amplify build spec version
frontend:                     # Frontend build configuration
  phases:                     # Build phases
    preBuild:                 # Pre-build phase
      commands: []            # Empty array (no commands needed for static sites)
    build:                    # Build phase
      commands: []            # Empty array (no build needed for static sites)
  artifacts:                  # Deployment artifacts
    baseDirectory: /         # Deploy from root directory
    files:                    # Files to deploy
      - '**/*'               # All files recursively
  cache:                     # Cache configuration
    paths: []                # No cache paths needed
```

## Why Empty Arrays?

For static websites (HTML, CSS, JS files only):
- No dependencies to install (`npm install` not needed)
- No build process required (`npm run build` not needed)
- Files are ready to deploy as-is
- Empty arrays `[]` tell Amplify to skip these phases

## Troubleshooting

### If deployment still fails:

1. **Check YAML syntax:**
   - Ensure 2-space indentation (no tabs)
   - Verify all arrays use proper `[]` or `- item` format
   - Check for trailing spaces

2. **Verify file encoding:**
   - File should be UTF-8 encoded
   - No BOM (Byte Order Mark) if possible

3. **Check Amplify logs:**
   - Go to Amplify console
   - Click on the failed deployment
   - Review build logs for specific errors

4. **Validate YAML online:**
   - Use https://www.yamllint.com/ to validate YAML syntax

## Success Indicators

After applying the fix, you should see:
- ✅ GitHub Actions workflow completes successfully
- ✅ Amplify deployment status shows "Deploy" (green)
- ✅ Your website is accessible at the Amplify URL
- ✅ No "Invalid build spec" errors in logs

## Next Steps

Once deployment succeeds:
1. Visit your Amplify app URL
2. Verify your website loads correctly
3. Test all functionality
4. Set up custom domain (optional)

## Support

If issues persist:
1. Check Amplify build logs for specific errors
2. Verify GitHub repository connection in Amplify
3. Ensure branch name matches (main/master)
4. Review AWS Amplify documentation: https://docs.aws.amazon.com/amplify/

