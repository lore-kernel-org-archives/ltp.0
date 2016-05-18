From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 18 May 2016 20:29:19 +0300
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <20160518143918.GB17880@rei.lan>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
 <20160518143918.GB17880@rei.lan>
Message-ID: <573CA66F.9000900@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/18/2016 05:39 PM, Cyril Hrubis wrote:
> Hi!
>> There is an idea. If we set memory.limit_in_bytes of a cgroup to a value
>> less than the amount of memory.usage_in_bytes, then activities of
>> processes of this cgroup will involve swapping.
>>
>> So what do you think about this scheme:
>>
>> mem = RAM * overcommit_ratio - Committed_AS
>> overcommit_memory = 1
>
> I do not understand why we choose exactly this number.
>
> RAM * overcommit_ratio is something as half of RAM on usuall system,
> right?  Then we substract Committed_AS, which is amount of memory system
> would have needed to back up all allocations so we may easily end up
> with a negative number if more than half of the RAM was requested by
> running programs.
>
> On my notebook I have 6.6Gb Commited_AS and RAM * overcommit_ratio = 2Gb
> the CommitLimit is 10Gb since I have 4GB RAM and 8GB Swap.
>

I run LTP mostly on systems with no load, and somehow missed this 
obvious fact, that Committed_AS could be large. Sorry if I misguided you.

> I guess that when we decide to create the pressure inside of the memory
> cgroup, instead of stressing the whole system, we may as well choose
> small enough amount of memory, something as (RAM - 250Mb)/10 and be done
> with it.

Yes, this should work as well.

I don't know how we could stress the whole system without the risk of 
hitting an OOM. One idea which comes to my mind is about using a 
top-level control group with a significant amount of memory assigned to 
it (like mem_free / 2).

Could you, please, have a look at the attachment? I was playing with 
this patch today and was able to stress my system without OOM.

However, this scheme may result in a very intensive swapping if mem_free 
is large (given that there is enough swap).



>
> [CCing Michal Hocko]
>
> Michal is there a way to figure out how much memory should be allocated
> and faulted on a system in order to cause some amount of pages to be
> swapped back and forth?
>
> What this testcase does it to create a process(es) that allocate memory
> and read/write it concurently to stress the system a bit but the
> estimate on how much memory it should use is wrong and it causes OOM
> when the amount of swap is much less than amount of RAM.
>
> The original testcase[1] drops caches then runs child(s) to allocate
> (in sum) MemFree + SwapFree/2 memory. Each child runs in its own memory
> cgroup but the amount of memory was choosen so that the whole system
> would be under memory pressure. Does such test even make sense to you?
>
> [1]:
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-draft.patch
Type: text/x-patch
Size: 3646 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160518/8bcafce2/attachment-0001.bin>
