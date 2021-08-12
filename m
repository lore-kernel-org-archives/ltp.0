From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 12 Aug 2021 08:53:08 +0100
Subject: [LTP] [RESEND PATCH 1/4] controllers/memcg: account per-node
 kernel memory
In-Reply-To: <90ff7e98-eea9-fe31-15ea-6bb1f12b4eb8@canonical.com>
References: <20210811101058.36695-1-krzysztof.kozlowski@canonical.com>
 <20210811101058.36695-2-krzysztof.kozlowski@canonical.com>
 <87v94ckpow.fsf@suse.de>
 <90ff7e98-eea9-fe31-15ea-6bb1f12b4eb8@canonical.com>
Message-ID: <87czqjm74r.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> writes:

> On 11/08/2021 16:42, Richard Palethorpe wrote:
>> Hello Krzysztof,
>> 
>> Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> writes:
>> 
>>> Recent Linux kernels () charge groups also with kernel memory.  This is
>>> not limited only to process-allocated memory but also cgroup-handling
>>> code memory as well.
>>>
>>> For example since kernel v5.9 with commit 3e38e0aaca9e ("mm: memcg:
>>> charge memcg percpu memory to the parent cgroup") creating a subgroup
>>> causes several kernel allocations towards this group.
>>>
>>> These additional kernel memory allocations are proportional to number of
>>> CPUs and number of nodes.
>>>
>>> On c4.8xlarge AWS instance with 36 cores in two nodes with v5.11 Linux
>>> kernel the memcg_subgroup_charge and memcg_use_hierarchy_test tests were
>>> failing:
>>>
>>>     memcg_use_hierarchy_test 1 TINFO: timeout per run is 0h 5m 0s
>>>     memcg_use_hierarchy_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
>>>     memcg_use_hierarchy_test 1 TINFO: test if one of the ancestors goes over its limit, the proces will be killed
>>>     mkdir: cannot create directory ?subgroup?: Cannot allocate memory
>>>     /home/ubuntu/ltp-install/testcases/bin/memcg_use_hierarchy_test.sh: 26: cd: can't cd to subgroup
>>>     memcg_use_hierarchy_test 1 TINFO: Running memcg_process --mmap-lock1 -s 8192
>>>     memcg_use_hierarchy_test 1 TFAIL: process  is not killed
>>>     rmdir: failed to remove 'subgroup': No such file or directory
>>>
>>> The kernel was unable to create the subgroup (mkdir returned -ENOMEM)
>>> due to this additional per-node kernel memory allocations.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>  .../controllers/memcg/functional/memcg_lib.sh | 44 +++++++++++++++++++
>>>  .../memcg/functional/memcg_subgroup_charge.sh |  8 +---
>>>  .../functional/memcg_use_hierarchy_test.sh    |  8 +++-
>>>  3 files changed, 52 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>>> index dad66c798e19..700e9e367bff 100755
>>> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>>> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
>>> @@ -63,6 +63,50 @@ memcg_require_hierarchy_disabled()
>>>  	fi
>>>  }
>>>  
>>> +# Kernel memory allocated for the process is also charged.  It might depend on
>>> +# the number of CPUs and number of nodes. For example on kernel v5.11
>>> +# additionally total_cpus (plus 1 or 2) pages are charged to the group via
>>> +# kernel memory.  For a two-node machine, additional 108 pages kernel memory
>>> +# are charged to the group.
>>> +#
>>> +# Adjust the limit to account such per-CPU and per-node kernel memory.
>>> +# $1 - variable name with limit to adjust
>>> +memcg_adjust_limit_for_kmem()
>>> +{
>>> +	[ $# -ne 1 ] && tst_brk TBROK "memcg_adjust_limit_for_kmem expects 1 parameter"
>>> +	eval "local _limit=\$$1"
>> 
>> Could we do this a simpler way?
>> 
>> It would be much easier to read if we just returned the value which
>> needed to be added.
>
> Sure, I can change it. Just note that the caller/user will require
> slightly more code.

Thanks, yes. I think a very large code saving would be required to
justify using eval in this way.

-- 
Thank you,
Richard.
