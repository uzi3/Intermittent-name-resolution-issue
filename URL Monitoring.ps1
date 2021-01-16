#Enter the URL to Monitor#
$URL = "sales.contoso.com"

#Enter the duration to monitor. Select only one"
$Minutes = 1
$Hours
$Days



If ($Minutes -ne $null)
{
    $Stoptime=((Get-Date).AddMinutes($Minutes)).ToString("ddMMyyyhhmm")
}

elseif ($Hours -ne $null)
{
    $Stoptime=((Get-Date).AddHours($Hours)).ToString("ddMMyyyhhmm")
}

elseif ($Days -ne $null)
{
    $Stoptime=((Get-Date).Adddays($Days)).ToString("ddMMyyyhhmm")
}

$results = @()

Do 
{
    try 
        {
            if (Resolve-DnsName $URL -ErrorAction Stop) {Out-Null}
        }
   
    catch
        {

           $ErrorString = $Error[0].Exception | Out-String
           $ErrorString = ($ErrorString).Replace("`r`n","")
           $TimeOfError = (Get-Date).ToString()

           

           $Details = @{
                        Error = $ErrorString
                        Time = $TimeOfError
                      }
            $results += New-Object PSObject -Property $details
           
            $results | Export-Csv D:\Monitoring.csv -Append -NoTypeInformation

        }
}

until
((Get-Date).ToString("ddMMyyyhhmm") -eq $Stoptime)


