From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 23 Feb 2021 15:54:07 +0800
Subject: [LTP] [PATCH] cpu_hotplug: Add executable file's path
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB403879BA9@dggeml511-mbs.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB403879BA9@dggeml511-mbs.china.huawei.com>
Message-ID: <6034B49F.9000209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi gongyi
> Hi Xu,
>
> In many cases, we set a default path for executable file would be more friendly for user?
I think it is friendly to user. LTP has friendly documentation to 
mention this?

In user-guide.txt
https://github.com/linux-test-project/ltp/blob/master/doc/user-guide.txt

| 'LTPROOT'             | Prefix for installed LTP, the default is 
'/opt/ltp'

| 'PATH'                | It's required to addjust path:
                           `PATH="$PATH:$LTPROOT/testcases/bin"`

In README.md
Each test case has its own executable or script, these can be executed 
directly
$ testcases/bin/abort01
Some have arguments
$ testcases/bin/fork13 -i 37
The vast majority of test cases accept the -h (help) switch
$ testcases/bin/ioctl01 -h
Many require certain environment variables to be set
$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
Most commonly, the path variable needs to be set and also LTPROOT, but 
there are a number of other variables, runltp usually sets these for you.
Note that all shell scripts need the PATH to be set. However this is not 
limited to shell scripts, many C based tests need environment variables 
as well.

Also for some special case, like prctl06.c, we can use resource_files to 
copy some other execute file to some place.

>
> And in these cases, it is better to judge return value behind running cpuhotplug_do_spin_loop since the error info has been redirected to /dev/null?
the cpuhotplug_do_spin_loop function only does a spin loop, IMO, it will 
not fail and here just make the output silent.


Best Regards
Yang Xu
>
>
>>
>> Hi Gongyi
>>> When env PATH is not include current path, run
>>> cpuhotplug_do_disk_write_loop/
>>> cpuhotplug_do_spin_loop/cpuhotplug_do_kcompile_loop/
>>> cpuhotplug_report_proc_interrupts will fail.
>>>
>> This patch is useless.
>>
>> For shell-script case, usually, runltp will set environment variables.
>> or, you need to set environment variables yourself if not want to use
>> runltp(more info see[1]).
>> For cpuhotplug02 case, we can run as below:
>> #export LTPROOT=/opt/ltp
>> #export PATH="$PATH:$LTPROOT/testcases/bin"
>> #cpuhotplug02.sh -c 1 -l 1
>>
>> [1]https://github.com/linux-test-project/ltp/blob/master/README.md
>>
>> Best Regards
>> Yang Xu
>>> For those:
>>> 	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> 	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
>>> 	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>> 	testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
>>>
>>> Signed-off-by: Zhao Gongyi<zhaogongyi@huawei.com>
>>> ---
>>>    .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh     | 4
>> ++--
>>>    .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh     | 2
>> +-
>>>    .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh     | 2
>> +-
>>>    .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh     | 2
>> +-
>>>    4 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git
>>> a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> index 1ba937cc7..b1c8a9b97 100755
>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> +++
>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
>>> @@ -137,7 +137,7 @@ cpu_states=$(get_all_cpu_states)
>>>    CPU_COUNT=0
>>>
>>>    # Start up a process that writes to disk; keep track of its PID
>>> -cpuhotplug_do_disk_write_loop>   /dev/null 2>&1&
>>> +./cpuhotplug_do_disk_write_loop>   /dev/null 2>&1&
>>>    WRL_ID=$!
>>>
>>>    until [ $LOOP_COUNT -gt $HOTPLUG01_LOOPS ] @@ -181,7 +181,7
>> @@ do
>>>    	# Print out a report showing the changes in IRQs
>>>    	echo
>>>    	echo
>>> -	cpuhotplug_report_proc_interrupts "$IRQ_START" "$IRQ_END"
>>> +	./cpuhotplug_report_proc_interrupts "$IRQ_START" "$IRQ_END"
>>>    	echo
>>>
>>>    	sleep $TM_DLY
>>> diff --git
>>> a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
>>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
>>> index 792f8cd73..f8a1395c1 100755
>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
>>> +++
>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
>>> @@ -77,7 +77,7 @@ fi
>>>    TST_CLEANUP=do_clean
>>>
>>>    # Start up a process that just uses CPU cycles
>>> -cpuhotplug_do_spin_loop>   /dev/null&
>>> +./cpuhotplug_do_spin_loop>   /dev/null&
>>>    SPIN_LOOP_PID=$!
>>>
>>>    sleep 5
>>> diff --git
>>> a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>> index 9ea49f0e1..75a05a3c9 100755
>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>> +++
>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
>>> @@ -102,7 +102,7 @@ until [ $LOOP_COUNT -gt
>> $HOTPLUG03_LOOPS ]; do
>>>    	# so we can kill them later.
>>>    	number_of_procs=$((cpus_num*2))
>>>    	until [ $number_of_procs -eq 0 ]; do
>>> -		cpuhotplug_do_spin_loop>   /dev/null 2>&1&
>>> +		./cpuhotplug_do_spin_loop>   /dev/null 2>&1&
>>>    		echo $!>>   /var/run/hotplug4_$$.pid
>>>    		number_of_procs=$((number_of_procs-1))
>>>    	done
>>> diff --git
>>> a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
>>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
>>> index 278304618..e8ab78e8c 100755
>>> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
>>> +++
>> b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
>>> @@ -81,7 +81,7 @@ fi
>>>
>>>    TST_CLEANUP=do_clean
>>>
>>> -cpuhotplug_do_kcompile_loop $KERNEL_DIR>   /dev/null 2>&1&
>>> +./cpuhotplug_do_kcompile_loop $KERNEL_DIR>   /dev/null 2>&1&
>>>    KCOMPILE_LOOP_PID=$!
>>>
>>>    tst_resm TINFO "initial CPU affinity for kernel compile is: \
>>> --
>>> 2.17.1
>>>
>>>
>>
>>
>
>
>
> .
>



