Function Eratosthenes {
    [bigint]$num = Read-Host "Input num`t"
    [bigint]$root = [Math]::Exp([BigInt]::Log($num) / 2)
    [bigint[]]$list = [bigint[]]::new($num+1)
    for($i=0; $i -le $num; $i+=1){$list[$i] = $i}
    foreach($div2 in $list[3..($list.LongLength)]){
        if($div2%2 -eq 0){$list[$div2] = 0}
    }
    foreach($prim in $list[3..($list.LongLength)]){
        if($prim -gt $root){break}
        if($list[$prim] -ne 0){
            for($mult=$prim; $prim*$mult -le $num; $mult+=2){
                $list[($prim*$mult)] = 0
            }
        }
    }
    $primes = ($list | Where-Object {$_ -ne 0 -and $_ -ne 1})
    return $primes
}

$start = Get-date
$result = Eratosthenes
$time = (Get-Date) - $start
Write-Host "Total Primes`t:" $result.Count "`n" $result
$time.ToString()