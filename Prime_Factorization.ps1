[bigint]$n = Read-Host "Input num"
$start = Get-Date
$pf = @()
while(([bigint]::Divide($n,2)) -eq 0){
    $pf += 2
    $n/=2
}
[bigint]$f = 3
while([Bigint]::Compare($f*$f,$n) -le 0){
    if($n%$f -eq 0){
        $pf += $f
        $n/=$f
    }else{
        $f += 2
    }
}
if($n -ne 1){
    $pf += $n
}
$time = (Get-Date) - $start
Write-Host $time
Write-Host $pf