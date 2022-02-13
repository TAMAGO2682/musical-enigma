#Prime_Factorization.ps1
#Func:Get-Prime,Get-PrimeFactor
#Get-Prime:Get Primes by seive of Eratosthenes
#Get-PrimeFactor:Get PrimeFactor using list of primes
#Approx 8 min to Get PF of 8 digit max number (99999999)
#Approx 2h30min to get PF of 10 digit munber (1234567890)
#Max boolean array element is "2147483591". Why?...
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
       if(([bigint]::Compare($array.LongLength,$count)) -eq 0){break}
        $prime = $array[$count]
 
    }
    return $pf
}

#main
[bigint]$num = Read-Host "Input num`n(lt 2147483592)`t"
$start = Get-date
$amount,$primes = (Get-Prime -num $num)
$pfs = (Get-PrimeFactor -num $num -array $primes)
$time = (Get-Date) - $start
Write-Host "Turnaround time`t:"$time.ToString()
$pfs