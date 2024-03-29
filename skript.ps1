$organizacniJednotky = "C:\skripty\OU.csv"
$skupiny = "C:\skripty\skupiny.csv"
$uzivatele = "C:\skripty\uzivatele.csv"

Import-Csv -Path $organizacniJednotky -Delimiter ";" | ForEach-Object {
	New-ADOrganizationalUnit -Name $_.OUJmeno -Path $_.cestaOU
}

Import-Csv -Path $skupiny -Delimiter ";" | ForEach-Object {
	New-ADGroup -Name $_.jmenoSkupiny -GroupCategory $_.typSkupiny -GroupScope $_.rozsah -Path $_.cestaSkupiny
}

Import-Csv -Path $uzivatele -Delimiter ";" | ForEach-Object {
	New-ADUser -Name "$($_.jmeno) $($_.prijmeni)" -GivenName $_.jmeno -Surname $_.prijmeni -UserPrincipalName "$($_.login)@domena.local" -SamAccountName $_.login -AccountPassword (ConvertTo-SecureString -String $_.heslo -AsPlainText -Force) -EmailAddress $_.email -Path $_.ou -Enabled 1 -ChangePasswordAtLogOn 1
	Add-ADGroupMember -Identity $_.skupina $_.login
}
