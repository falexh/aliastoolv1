<#
    Name: Alias Tool 1.2 
    Description: Tool for adding aliases to mailboxes 
    Date: 9/3/2020
    Author: FH 
#>

Write-Host "----------------" -BackgroundColor Blue
Write-Host "<ALIAS TOOL 1.2>" -BackgroundColor Blue
Write-Host "----------------" -BackgroundColor Blue

$switch = $true
while($switch){
    Write-Host "Lets check the mailboxes in your tenant..." -ForegroundColor Green

    Get-Mailbox

    $mailboxName = Read-Host "Enter the name of the mailbox that you want to check aliases for: "

    #Check the aliases associated with that mailbox you just entered: 
    Write-Host "Here are the aliases associated with that mailbox " -ForegroundColor Green
    Get-Mailbox $mailboxName | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp"

    $newAlias = Read-Host "Enter the name of the new alias that you want added to this mailbox "

    #Add this alias to that selected mailbox 
    Set-Mailbox $mailboxName -EmailAddresses @{Add="$newAlias"}

    Write-Host "-----------------------------------------------------------------------------------------------" -BackgroundColor Blue
    Write-Host "***************** <!> New aliases have been added to $mailboxName *****************************" -BackgroundColor Blue 
    Write-Host "Here is the updated aliases: "

    Get-Mailbox $mailboxName | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp"

    $answer = Read-Host "Would you like to run the alias tool again? (Y/N)"
    
    if($answer -eq "N" -or $answer -eq "n"){
        $switch = $false
    }
}
Write-Host "Program exiting..." -ForegroundColor Blue