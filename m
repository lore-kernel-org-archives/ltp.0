From: Tudor Florea <tudor.florea@enea.com>
Date: Wed, 27 Jul 2016 18:21:57 +0300
Subject: [LTP] [PATCH V3 15/23] Add periodic output for long time test.
In-Reply-To: <20160727143744.GD11986@rei.lan>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-15-raj.khem@gmail.com> <20160727143744.GD11986@rei.lan>
Message-ID: <f0c697a5-af36-f468-1a09-376928156fd4@enea.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
This patch was needed to avoid the timeout of the script used to parse
the redirected output of the test. That being said don't have any strong
arguments (pro or cons) of cleaning up or improving the patch.
To be pedantic, I think that a newline for every 10 minutes is a little
too seldom; maybe just adding a new line every 5 minute is acceptable.
I hope that helps,
  Tudor.

On 27/07/2016 17:37, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> index dc610f1..769da72 100755
>> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> @@ -37,7 +37,8 @@ if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
>>          exit 0
>>  fi
>>  
>> -RUN_TIME=$(( 60 * 60 ))
>> +ONE_MINUTE=60
>> +RUN_TIME=60
>>  
>>  cleanup()
>>  {
>> @@ -62,7 +63,7 @@ do_mount()
>>  # $1 - Number of cgroups
>>  # $2 - Allocated how much memory in one process? in MB
>>  # $3 - The interval to touch memory in a process
>> -# $4 - How long does this test run ? in second
>> +# $4 - How long does this test run ? in minutes
>>  run_stress()
>>  {
>>  	do_mount;
>> @@ -81,7 +82,11 @@ run_stress()
>>  		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
>>  	done
>>  
>> -	sleep $4
>> +	for i in $(seq 0 $(($4-1)))
>                    ^
> 	for i in $(seq 1 $4); do
>> +		eval echo "Started $i min ago. Still alive... " 
> 
>                 Why is this eval here?
> 
> 		Also can we be a bit less verbose?
> 
> 		What about just printing one dot (.) each minute and
> 		print a newline each ten minutes as well?
> 
>> +		sleep $ONE_MINUTE
> 
>                 There is no need for the ONE_MINUTE abstraction, just do
> 		sleep 60 here.
> 
>> +	done
>>  
>>  	for i in $(seq 0 $(($1-1)))
>>  	do
>> -- 
>> 2.9.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
