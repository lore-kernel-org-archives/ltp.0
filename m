From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Fri, 11 Jun 2021 11:22:48 +0200
Subject: [LTP] [PATCH 1/2] controllers/cpuacct: skip cpuacct_100_100 on
 small memory systems
In-Reply-To: <YMIa/eXUzx8ygk9g@yuki>
References: <20210610100927.32015-1-krzysztof.kozlowski@canonical.com>
 <YMIa/eXUzx8ygk9g@yuki>
Message-ID: <c4f3198b-62b5-51ab-6dc6-0c6dc8e1cbb8@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/06/2021 16:00, Cyril Hrubis wrote:
> Hi!
>> Running cpuacct_100_100 on a system with less than ~4 GB of RAM fails:
>>
>>     cpuacct 1 TINFO: timeout per run is 0h 5m 0s
>>     cpuacct 1 TINFO: cpuacct: /sys/fs/cgroup/cpu,cpuacct
>>     cpuacct 1 TINFO: Creating 100 subgroups each with 100 processes
>>     testcases/bin/cpuacct.sh: 0: Cannot fork
>>
>> In dmesg:
>>
>>     LTP: starting cpuacct_100_100 (cpuacct.sh 100 100)
>>     cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-1.scope
>>
>> It seems system might not handle or not allow that amount of processes,
>> so simply skip the test.  The threshold of ~4 GB was found during
>> experimenting, so it is not accurate.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  testcases/kernel/controllers/cpuacct/cpuacct.sh | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
>> index 323aa7513bf4..2646018d295e 100755
>> --- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
>> +++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
>> @@ -44,6 +44,20 @@ setup()
>>  		tst_brk TCONF "cpuacct not supported on this system"
>>  	fi
>>  
>> +	if [ $max -ge 100 ] && [ $nbprocess -ge 100 ]; then
>> +		local memtotal=`awk '/MemTotal/ {print $2}' /proc/meminfo`
>> +		if [ $? -eq 0 ]; then
>> +			# cpuacct.sh 100 100 will fail if memory is less
>> +			# than 4 GB with:
>> +			#   testcases/bin/cpuacct.sh: 0: Cannot fork
>> +			# Choose some limit of total memory, determined
>> +			# with experiments: 3*1024+768 MB = 3932160 kB
>> +			if [ $memtotal -lt 3932160 ]; then
>> +				tst_brk TCONF "not enough of memory on this system (less than 3840 MB)"
>> +			fi
>> +		fi
>> +	fi
>> +
> 
> This looks quite hacky and ad-hoc.
> 
> First of all MemTotal is not a good estimate of usable system memory, if
> nothing else this should use better estimate. We have something that is
> more or less usable in swapping01.c tests in init_meminfo() function.
> 
> Secondly we should create a rough estimage how the memory grows based on
> number of processes and on number of subgroups.
> 
> The we can have a generic check if there is enough memory for a given
> test. The problem is that all these estimates are rough and rest of the
> system may eat memory as well, so we will have to make sure there is big
> enough margin. If we want to count on the test success it has to be
> large and consists "offset" (N * pagesize) and percentage of available
> memory 10% or so.
> 
> And yes, this is a complex problem that is not easy to fix. If it was
> easy it would have been fixed a long time ago...

I understand, thanks for the hints. I'll try to come up with some more
generic solution based on available memory (like mentioned init_meminfo).


Best regards,
Krzysztof
