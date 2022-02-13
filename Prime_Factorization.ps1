[bigint]$num = Read-Host "Input num"
$start = Get-Date
$pf = [ordered]@{}
[bigint]$prime = 2
while(([bigint]::Compare($prime,$num)) -le 0){
    [bigint]$expon = 0
    [bigint]$reminder = 0
    [void]([bigint]::DivRem($num,$prime,[ref]$reminder))
    while($reminder -eq 0){
        $expon += 1
        $num /= $prime
        [void]([bigint]::DivRem($num,$prime,[ref]$reminder))
    }
    if($expon -ne 0){
        $pf[$prime] = $expon
    }
    $prime += 1
}
$time = (Get-Date) - $start
Write-Host $time
$pf