From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 17 May 2016 15:52:27 +0300
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <20160512134217.GB32457@rei.lan>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan>
Message-ID: <573B140B.8080500@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 05/12/2016 04:42 PM, Cyril Hrubis wrote:
> Hi!
>> Given that, (CommitLimit - Committed_AS) with overcommit_memory == 1,
>> looks to be a suitable formula, since the kernel lets allocate this
>> amount of memory and there will be some memory for other tasks.
>
> I wonder what the original purpose of the test is, it looks to me like
> the whole point is to attach processes to number of memory cgroups and
> then stress it by allocating memory while forcing heavy swapping. Hence
> the $mem_free + $swap_free/2 which is wrong obviously.
>
> So for the new formula the CommitLimit seems to be calculated as
> SWAP + RAM * overcommit_ratio which will default to SWAP + RAM/2 in most
> of the cases. Wouldn't that cause too much swap trashing in case that you
> have SWAP == 2 * RAM? Shouldn't be something simple as 0.8 * RAM better
> for the purpose of the test? Or something as 0.9 * mem_free - 50MB after
> caches has been dropped?

I'm afraid that const * mem_free couldn't be the best formula, since if 
swap is small we may get an OOM here. At least this is what I get in a 
ldom with 128g memory, and < 1gb swap.

There is an idea. If we set memory.limit_in_bytes of a cgroup to a value 
less than the amount of memory.usage_in_bytes, then activities of 
processes of this cgroup will involve swapping.

So what do you think about this scheme:

mem = RAM * overcommit_ratio - CommitLimit
overcommit_memory = 1

plus this run_test():

# $1 - Number of cgroups
# $2 - Allocated how much memory in one process? in MB
# $3 - The interval to touch memory in a process
# $4 - How long does this test run ? in second
run_stress()
{
         nr_children=0
         children=""

         do_mount

         for i in $(seq 0 $(( $1 - 1 ))); do
                 ROD mkdir "$memcg_path/$i"
                 memcg_process_stress $2 $3 &
                 child=$!

                 nr_children=$(( $nr_children + 1 ))
                 children="$children $child"

                 ROD echo $child \> "$memcg_path/$i/tasks"
                 ROD echo $(( $2 * 1024 * 1024 )) \> 
"$memcg_path/$i/memory.limit_in_bytes"
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         done
<cut>

?

Since the total amount of memory consumed by memcg_process_stress is 
always greater than the amount of memory it tries to mmap(), we are 
guaranteed that swapping will be happening for each of the control groups.


>
> Also I wonder if it makes sense to run the test if machine has no swap
> configured. Maybe we should TCONF right away in that case.

With the above scheme we just need to make sure that there is enough 
swap space to hold text (and some others) segments of all 
memcg_process_stress processes. I think something like 2 mb per process 
should be enough.

>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>>   .../controllers/memcg/stress/memcg_stress_test.sh  |   28 ++++++++++++++++---
>>   1 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> index 0d541e5..75baab4 100755
>> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>> @@ -39,6 +39,8 @@ children=""
>>   nr_children=0
>>   memcg_path=/dev/memcg
>>   memcg_created=0
>> +overcommit_path=/proc/sys/vm/overcommit_memory
>> +overcommit=""
>>
>>   cleanup()
>>   {
>> @@ -54,6 +56,10 @@ cleanup()
>>   		umount "$memcg_path"
>>   		rmdir "$memcg_path"
>>   	fi
>> +
>> +	if is_int "$overcommit"; then
>> +		echo "$overcommit" > "$overcommit_path"
>> +	fi
>>   }
>>   TST_CLEANUP=cleanup
>>
>> @@ -139,20 +145,32 @@ testcase_2()
>>   ROD echo 3 \> /proc/sys/vm/drop_caches
>>   sleep 2
>>
>> -mem_free=`cat /proc/meminfo | grep MemFree | awk '{ print $2 }'`
>> -is_int "$mem_free" || tst_brkm TBROK "Unable to determine mem_free"
>> +# We enable the "always overcommit" memory policy and allocate
>> +# less than CommitLimit bytes. Given that no other memory-consuming
>> +# process should be running, this gives us a more-or-less strong
>> +# guarantee that our allocations will result in an OOM situation.
>                                          ^
> 					missing not?
>
> I've just looked into newer patch that has not in the sentence...


You are correct, there was a missing 'not'. I fixed it in the newer 
patch, but didn't note it in the v1-v2 changes.


>
>> +overcommit=$(cat "$overcommit_path")
>> +is_int "$overcommit" || tst_brkm TBROK "Unable to determine overcommit"
>>
>> -swap_free=`cat /proc/meminfo | grep SwapFree | awk '{ print $2 }'`
>> -is_int "$swap_free" || tst_brkm TBROK "Unable to determine swap_free"
>> +commit_limit=$(cat /proc/meminfo | grep CommitLimit | awk '{ print $2 }')
>> +is_int "$commit_limit" || tst_brkm TBROK "Unable to determine commit_limit"
>>
>> -mem=$(( $mem_free + $swap_free / 2 ))
>> +committed_as=$(cat /proc/meminfo | grep Committed_AS | awk '{ print $2 }')
>> +is_int "$committed_as" || tst_brkm TBROK "Unable to determine committed_as"
>> +
>> +mem=$(( $commit_limit - $committed_as ))
>>   mem=$(( $mem / 1024 ))
>>   [ "$mem" -gt 0 ] || tst_brkm TBROK "mem is negative: $mem"
>>
>> +ROD echo 1 \> "$overcommit_path"
>> +
>>   date
>>   testcase_1
>>   date
>>   testcase_2
>>   date
>>
>> +ROD echo "$overcommit" \> "$overcommit_path"
>
> Shouldn't this be done in the cleanup so that it's restored if the test
> is aborted somewhere in the middle?

Right. It's already in cleanup(), so this call here seems redundant.


>
> Something as:
>
> cleanup()
> {
> ...
> 	if [ -n "$overcommit" ]; then
> 		echo "$overcommit" \> "$overcommit_path"
> 	fi
> ...
>
>
