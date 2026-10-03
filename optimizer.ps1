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
    Write-Host "Installing tweaks..." -ForegroundColor Green
    
    # כאן תכניס את כל הפקודות של הטיפולים שלך (ביטול Telemetry, ניקוי זמניים וכו')
    # דוגמה:
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    
    [System.Windows.Forms.MessageBox]::Show("Tweaks installed successfully!", "Done", 0, [System.Windows.Forms.MessageBoxIcon]::Information)
} else {
    Write-Host "Installation cancelled." -ForegroundColor Yellow
}