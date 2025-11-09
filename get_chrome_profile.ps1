# This script defines the user data and profile directories for Chrome,
# then validates that the full profile path exists on the system.
# If the profile exists, it copies the entire profile folder to a new location.

# --- USER-DEFINED VARIABLES ---
# In order to run this script with a specific profile, you need to set the
# 'user_data_dir' and 'profile_dir' variables below.
# Make sure the Chrome profile actually exists at this path.

# Set the path to the Chrome User Data directory.
# Example: C:\Users\YourUser\AppData\Local\Google\Chrome\User Data
$user_data_dir = "C:\Users\Akasata\AppData\Local\Google\Chrome\User Data"

# Set the name of the profile directory.
# Example: "Profile 1", "Default", or "Guest Profile"
$profile_dir = "Profile 6"

# Set the destination directory where the profile folder will be copied.
# Example: "C:\Backups\ChromeProfiles"
$destination_dir = "D:\TFS\Github\gpt-scraper\gpt_scraper\chrome_profile"

# --- SCRIPT LOGIC ---
# Construct the full path to the Chrome profile.
$profile_path = Join-Path -Path $user_data_dir -ChildPath $profile_dir

Write-Host "Checking for Chrome profile at path: $profile_path" -ForegroundColor Cyan

# Test if the path exists.
if (Test-Path -Path $profile_path -PathType Container) {
    # If the path exists, display a success message.
    Write-Host "`nSuccess: The Chrome profile directory was found!" -ForegroundColor Green
    Write-Host "Path: $profile_path" -ForegroundColor Green

    # --- COPY COMMAND ---
    Write-Host "`nStarting the copy process..." -ForegroundColor Yellow
    try {
        # Create the destination directory if it doesn't exist
        if (-not (Test-Path $destination_dir)) {
            Write-Host "Creating destination directory: $destination_dir" -ForegroundColor Yellow
            New-Item -Path $destination_dir -ItemType Directory | Out-Null
        }

        # Copy the entire profile folder and its contents recursively
        Copy-Item -Path $profile_path -Destination $destination_dir -Recurse -Force
        Write-Host "`nSuccess: Chrome profile copied to $destination_dir" -ForegroundColor Green
    } catch {
        Write-Host "`nError during the copy process: $_" -ForegroundColor Red
        exit 1
    }

} else {
    # If the path does not exist, display an error message and exit.
    Write-Host "`nError: The Chrome profile directory was NOT found at the specified path." -ForegroundColor Red
    Write-Host "Please check the following:" -ForegroundColor Red
    Write-Host "  1. The value of `$user_data_dir is correct." -ForegroundColor Red
    Write-Host "  2. The value of `$profile_dir is the correct profile name." -ForegroundColor Red
    Write-Host "  3. The profile actually exists." -ForegroundColor Red
    
    # Exit with a non-zero code to indicate an error
    exit 1
}

