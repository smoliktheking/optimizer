Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "FPS Optimizer"
$form.Size = New-Object System.Drawing.Size(350,200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(30,30)
$label.Size = New-Object System.Drawing.Size(280,40)
$label.Text = "Do you want to install the tweaks?"
$label.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
$form.Controls.Add($label)

$yesButton = New-Object System.Windows.Forms.Button
$yesButton.Location = New-Object System.Drawing.Point(50,100)
$yesButton.Size = New-Object System.Drawing.Size(100,30)
$yesButton.Text = "Yes"
$yesButton.DialogResult = [System.Windows.Forms.DialogResult]::Yes
$form.AcceptButton = $yesButton
$form.Controls.Add($yesButton)

$noButton = New-Object System.Windows.Forms.Button
$noButton.Location = New-Object System.Drawing.Point(180,100)
$noButton.Size = New-Object System.Drawing.Size(100,30)
$noButton.Text = "No"
$noButton.DialogResult = [System.Windows.Forms.DialogResult]::No
$form.CancelButton = $noButton
$form.Controls.Add($noButton)

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
    Write-Host "Installing essential tweaks..." -ForegroundColor Green

    # 1. Activity History - Disable
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -ErrorAction SilentlyContinue

    # 2. ConsumerFeatures - Disable
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -ErrorAction SilentlyContinue

    # 3. Delivery Optimization - Disable
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" -Name "DODownloadMode" -Value 0 -ErrorAction SilentlyContinue

    # 4. End Task With Right Click - Enable
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDeveloperSettings" -Value 1 -ErrorAction SilentlyContinue

    # 5. File Explorer Automatic Folder Discovery - Disable
    Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" -Recurse -Force -ErrorAction SilentlyContinue

    # 6. Location Tracking - Disable
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -ErrorAction SilentlyContinue

    # 7. Restore Point - Create
    Checkpoint-Computer -Description "FPS Optimizer Restore Point" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue

    # 8. Telemetry - Disable
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -ErrorAction SilentlyContinue

    # 9. Temporary Files - Remove
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

    [System.Windows.Forms.MessageBox]::Show("Essential tweaks installed successfully!", "Done", 0, [System.Windows.Forms.MessageBoxIcon]::Information)
} else {
    Write-Host "Installation cancelled." -ForegroundColor Yellow
}
