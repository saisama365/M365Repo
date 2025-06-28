#Removing Direct Licenses for Azure AD User Objects

Connect-Mggraph

#fetching data
$UsersList  = Get-Content C:\temp\LicensedUsers.txt

foreach($UserID in $UsersList){

    try{
            $user  =  Get-Mguser -Userid $UserID -Property AssignedLicenses
            $directLicensesID = $user.AssignedLicenses.Skuid

            if($directLicensesID.Count -gt 0){

                    Set-MguserLicense -Userid $UserID -AddLicenses @() -RemoveLicenses $directLicensesID
                    Write-Host "Removed direct licenses for $userID"
            } else{
                    Write-Host "no direct license removal performed or identified for $UserID"
            }
    }
    Catch{
            Write-Host "Error Processing the Identity $userid $_ "
    }
}

Disconnect-Mggraph
