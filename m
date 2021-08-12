From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 12 Aug 2021 08:45:23 +0200
Subject: [LTP] [RESEND PATCH 1/4] controllers/memcg: account per-node
 kernel memory
In-Reply-To: <87v94ckpow.fsf@suse.de>
References: <20210811101058.36695-1-krzysztof.kozlowski@canonical.com>
 <20210811101058.36695-2-krzysztof.kozlowski@canonical.com>
 <87v94ckpow.fsf@suse.de>
Message-ID: <90ff7e98-eea9-fe31-15ea-6bb1f12b4eb8@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/08/2021 16:42, Richard Palethorpe wrote:
> Hello Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> writes:
> 
>> Recent Linux kernels () charge groups also with kernel memory.  This is
>> not limited only to process-allocated memory but also cgroup-handling
>> code memory as well.
>>
>> For example since kernel v5.9 with commit 3e38e0aaca9e ("mm: memcg:
>> charge memcg percpu memory to the parent cgroup") creating a subgroup
>> causes several kernel allocations towards this group.
>>
>> These additional kernel memory allocations are proportional to number of
>> CPUs and number of nodes.
>>
>> On c4.8xlarge AWS instance with 36 cores in two nodes with v5.11 Linux
>> kernel the memcg_subgroup_charge and memcg_use_hierarchy_test tests were
>> failing:
>>
>>     memcg_use_hierarchy_test 1 TINFO: timeout per run is 0h 5m 0s
>>     memcg_use_hierarchy_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
>>     memcg_use_hierarchy_test 1 TINFO: test if one of the ancestors goes over its limit, the proces will be killed
>>     mkdir: cannot create directory ?subgroup?: Cannot allocate memory
>>     /home/ubuntu/ltp-install/testcases/bin/memcg_use_hierarchy_test.sh: 26: cd: can't cd to subgroup
>>     memcg_use_hierarchy_test 1 TINFO: Running memcg_process --mmap-lock1 -s 8192
>>     memcg_use_hierarchy_test 1 TFAIL: process  is not killed
>>     rmdir: failed to remove 'subgroup': No such file or directory
>>
>> The kernel was unable to create the subgroup (mkdir returned -ENOMEM)
>> due to this additional per-node kernel memory allocations.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  .../controllers/memcg/functional/memcg_lib.sh | 44 +++++++++++++++++++
>>  .../memcg/functional/memcg_subgroup_charge.sh |  8 +---
>>  .../functional/memcg_use_hierarchy_test.sh    |  8 +++-
>>  3 files changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>> index dad66c798e19..700e9e367bff 100755
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>> @@ -63,6 +63,50 @@ memcg_require_hierarchy_disabled()
>>  	fi
>>  }
>>  
>> +# Kernel memory allocated for the process is also charged.  It might depend on
>> +# the number of CPUs and number of nodes. For example on kernel v5.11
>> +# additionally total_cpus (plus 1 or 2) pages are charged to the group via
>> +# kernel memory.  For a two-node machine, additional 108 pages kernel memory
>> +# are charged to the group.
>> +#
>> +# Adjust the limit to account such per-CPU and per-node kernel memory.
>> +# $1 - variable name with limit to adjust
>> +memcg_adjust_limit_for_kmem()
>> +{
>> +	[ $# -ne 1 ] && tst_brk TBROK "memcg_adjust_limit_for_kmem expects 1 parameter"
>> +	eval "local _limit=\$$1"
> 
> Could we do this a simpler way?
> 
> It would be much easier to read if we just returned the value which
> needed to be added.

Sure, I can change it. Just note that the caller/user will require
slightly more code.

> 
>> +
>> +	# Total number of CPUs
>> +	local total_cpus=`tst_ncpus`
>> +
>> +	# Get the number of NODES
> 
> Is it acceptable or necessary to use /sys/devices/system/node/possible
> (or online) instead?

Makes sense, I took it from existing code but it looks unnecessarily
complicated.

> 
>> +	if [ -f "/sys/devices/system/node/has_high_memory" ]; then
>> +		local mem_string="`cat /sys/devices/system/node/has_high_memory`"
>> +	else
>> +		local mem_string="`cat /sys/devices/system/node/has_normal_memory`"
>> +	fi
>> +
>> +	local total_nodes="`echo $mem_string | tr ',' ' '`"
>> +	local count=0
>> +	for item in $total_nodes; do
>> +		local delta=1
>> +		if [ "${item#*-*}" != "$item" ]; then
>> +			delta=$((${item#*-*} - ${item%*-*} + 1))
>> +		fi
>> +		count=$((count + $delta))
>> +	done
> 
> Or perhaps we could count the number of 'node[0-9]+' directories? I
> think that would be easier to understand.

I just copied the existing code, but I can try to simplify it.

> 
>> +	total_nodes=$count
>> +	# Additional nodes impose charging the kmem, not having regular one node
>> +	local node_mem=0
>> +	if [ $total_nodes -gt 1 ]; then
>> +		node_mem=$((total_nodes - 1))
>> +		node_mem=$((node_mem * PAGESIZE * 128))
>> +	fi
>> +
>> +	eval "$1='$((_limit + 4 * PAGESIZE + total_cpus * PAGESIZE + node_mem))'"
>> +	return 0
>> +}
> 
> Otherwise looks good.

Thanks for review!


Best regards,
Krzysztof
