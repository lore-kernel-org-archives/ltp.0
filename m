From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 14 Jan 2021 09:40:50 +0800
Subject: [LTP] [PATCH v2] cpuset: skip test when cpu or nodes are not
 numbered continously from 0
In-Reply-To: <X/8ehCeZbWs6TIA4@yuki.lan>
References: <X/29dySZb8kL5Nms@rei.lan>
 <1610539423-4315-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <X/8ehCeZbWs6TIA4@yuki.lan>
Message-ID: <5FFFA122.3060702@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril

I will send a v3 for these comments.

Best Regards
Yang Xu
> Hi!
>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> index f4365af2c..5b1bde114 100755
>> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> @@ -26,23 +26,34 @@
>>
>>   . test.sh
>>
>> +cpu_string="`cat /sys/devices/system/cpu/online`"
>>   NR_CPUS=`tst_ncpus`
>> +
>>   if [ -f "/sys/devices/system/node/has_high_memory" ]; then
>> -	N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' ' '`"
>> +	mem_string="`cat /sys/devices/system/node/has_high_memory`"
>>   else
>> -	N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' ' '`"
>> +	mem_string="`cat /sys/devices/system/node/has_normal_memory`"
>>   fi
>> +N_NODES="`echo $mem_string | tr ',' ' '`"
>>   count=0
>> +final_node=0
>>   for item in $N_NODES; do
>>   	delta=1
>>   	if [ "${item#*-*}" != "$item" ]; then
>>   		delta=$((${item#*-*} - ${item%*-*} + 1))
>>   	fi
>> +	final_node=${item#*-*}
>>   	count=$((count + $delta))
>>   done
>> +final_node=`expr $final_node + 1`
>
> Why don't we use $(()) as in the rest of the code?
>
>>   N_NODES=$count
>>
>> -mem_string="$N_NODES"
>> +final_cpu=0
>> +N_CPUS="`echo $cpu_string | tr ',' ' '`"
>> +for item in $N_CPUS; do
>> +	final_cpu=${item#*-*}
>> +done
>> +final_cpu=`expr $final_cpu + 1`
>
> Here as well.
>
>>   CPUSET="/dev/cpuset"
>>   CPUSET_TMP="/tmp/cpuset_tmp"
>> @@ -78,6 +89,12 @@ ncpus_check()
>>   	if [ $NR_CPUS -lt $1 ]; then
>>   		tst_brkm TCONF "The total of CPUs is less than $1"
>>   	fi
>> +	# check online cpu whether match 0-num
>> +	if [ $final_cpu -eq $NR_CPUS ]; then
>> +		tst_resm TINFO "cpus enable continuously from 0($cpu_string)"
>                                       ^
> 				     This does not make much sense.
>
> This should probably be:
> 	"CPUs numbered continuously starting at 0 ($cpu_string)"
>
>
>> +	else
>> +		tst_brkm TCONF "cpus don't enable continuously from 0($cpu_string)"
>
> Here it should be:
> 	"CPUs are not numbered continuously starting at 0 ($cpu_string)"
>
>> +	fi
>>   }
>>
>>   nnodes_check()
>> @@ -85,6 +102,12 @@ nnodes_check()
>>   	if [ $N_NODES -lt $1 ]; then
>>   		tst_brkm TCONF "The total of nodes is less than $1"
>>   	fi
>> +	# check online whether match 0-num
>> +	if [ $final_node -eq $count ]; then
>                                 ^
> 			I guess that N_NODES would be better here.
>
>> +		tst_resm TINFO "nodes enable continuously from 0($mem_string)"
>> +	else
>> +		tst_brkm TCONF "nodes don't enable continuously from 0($mem_string)"
>
> These two messages should be adjusted as well.
>
>> +	fi
>>   }
>>
>>   user_check()
>> --
>> 2.23.0
>>
>>
>>
>



