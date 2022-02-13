Function Get-Prime {
    param([Bigint]$num)
    [bigint]$root = [Math]::Exp([BigInt]::Log($num) / 2)
    $list = [bigint[]]::new($num+1)
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
    $prime = ($list | Where-Object {$_ -ne 0 -and $_ -ne 1})
    return $prime
}
function Get-PrimeFactor {
    param([bigint]$num,$array)
    $pf = [ordered]@{}
    [bigint]$count = 0
    [bigint]$prime = $array[$count]
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
        $count += 1
       if(([bigint]::Compare($array.LongLength,$count)) -eq 0){break} #key!!!!!!!!!!!!!!!!!!!!!!!!!!!
        $prime = $array[$count]
 
    }
    return $pf
}

[bigint]$num = Read-Host "Input num`t"
$start = Get-date
$primearray = (Get-Prime -num $num)
Get-PrimeFactor -num $num -array $primearray
$time = (Get-Date) - $start
$time.ToString()