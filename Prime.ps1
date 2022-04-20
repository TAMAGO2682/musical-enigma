Function Get-Prime {
    param([bigint]$num)
    [bigint]$root = [Math]::Exp([BigInt]::Log($num) / 2)
    [bigint]$amount = 1
    $list = [Boolean[]]::new($num+1)
    $list[2] = $true
    for($count=3;$count -lt ($list.Longlength);$count+=1){
        if($count%2 -ne 0){
            $list[$count]=$true
            $amount+=1
        }
    }
    for($prime=3;$prime -le $list.Longlength;$prime+=1){
        if($prime -gt $root){break}
        if($list[$prime] -eq $true){
            for($mult=$prime; $prime*$mult -le $num; $mult+=2){
                $target = ($prime*$mult)
                if($list[$target] -eq $true){
                    $list[$target] = $false
                    $amount -= 1
                }
            } 
        }
    }
    [bigint]$next = 0
    $primes = [bigint[]]::new($amount)
    for([bigint]$store=0;$store -le $list.LongLength;$store+=1){
        if($list[$store] -eq $true){
            $primes[$next] = $store
            $next += 1
        }
    }
    return $amount,$primes
}

[bigint]$num = Read-Host "Input num`n(lt 2147483592)`t"
$amount,$primes = (Get-Prime -num $num)