$code = @"
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
"@
$userInput = Add-Type -MemberDefinition $code -Name UserInput -Namespace UserInput -PassThru

$userInput::BlockInput($true) | Out-Null

Write-Host ""
Write-Host "Hello!"
Start-Sleep -Seconds 1
Write-Host ""
Write-Host "Now i'm going to get back your language list"
Start-Sleep -Seconds 1
Write-Host ""
if (Test-Path -Path C:\WinUserLanguageList.json -PathType Leaf) {
    Get-WinUserLanguageList | Out-Null
    $importedFile = Get-Content C:\WinUserLanguageList.json | ConvertFrom-Json
    $langCollection = New-Object System.Collections.Generic.List[Microsoft.InternationalSettings.Commands.WinUserLanguage]
    foreach ($item in $importedFile) {
        $lang = [Microsoft.InternationalSettings.Commands.WinUserLanguage]::new($item.LanguageTag)
        $lang.InputMethodTips.Clear()
        foreach ($inputMethod in $item.InputMethodTips) {
            $lang.InputMethodTips.Add($inputMethod) }
        $lang.Handwriting = $item.Handwriting
        $lang.Spellchecking = $item.Spellchecking
        $langCollection += $lang }
    Set-WinUserLanguageList $langCollection -Force
    Remove-Item C:\WinUserLanguageList.json
    Write-Host "Your Language list was successfully changed."
    }
else { Write-Host "It looks like i don't have anything to change." }
Start-Sleep -Seconds 1
Write-Host ""
Write-Host "Great!"
Start-Sleep -Seconds 1
Write-Host ""
Write-Host "Realy, that's all i can do now.("
Start-Sleep -Seconds 1
Write-Host ""
Write-Host "Come back later for next updates!"
Start-Sleep -Seconds 1
Write-Host ""
Write-Host "Bye! :)"
Start-Sleep -Seconds 1
Write-Host ""
$userInput::BlockInput($false) | Out-Null
Read-Host -Prompt "Press Enter to continue"
Clear-Host
Write-Host ""
Write-Host " +-------------------------------------------------------------+"
Write-Host " | You can find program data in C:\Program Files (x86)\Makaksi |"
Write-Host " |                                                             |"
Write-Host " |            And also check my website: ma.kak.si!            |"
Write-Host " +-------------------------------------------------------------+"
Write-Host ""
Read-Host -Prompt "Press Enter to exit"
exit
