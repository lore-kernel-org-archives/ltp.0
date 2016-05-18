From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 May 2016 16:39:18 +0200
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <573B140B.8080500@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
Message-ID: <20160518143918.GB17880@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There is an idea. If we set memory.limit_in_bytes of a cgroup to a value 
> less than the amount of memory.usage_in_bytes, then activities of 
> processes of this cgroup will involve swapping.
> 
> So what do you think about this scheme:
> 
> mem = RAM * overcommit_ratio - Committed_AS
> overcommit_memory = 1

I do not understand why we choose exactly this number.

RAM * overcommit_ratio is something as half of RAM on usuall system,
right?  Then we substract Committed_AS, which is amount of memory system
would have needed to back up all allocations so we may easily end up
with a negative number if more than half of the RAM was requested by
running programs.

On my notebook I have 6.6Gb Commited_AS and RAM * overcommit_ratio = 2Gb
the CommitLimit is 10Gb since I have 4GB RAM and 8GB Swap.

I guess that when we decide to create the pressure inside of the memory
cgroup, instead of stressing the whole system, we may as well choose
small enough amount of memory, something as (RAM - 250Mb)/10 and be done
with it.

[CCing Michal Hocko]

Michal is there a way to figure out how much memory should be allocated
and faulted on a system in order to cause some amount of pages to be
swapped back and forth?

What this testcase does it to create a process(es) that allocate memory
and read/write it concurently to stress the system a bit but the
estimate on how much memory it should use is wrong and it causes OOM
when the amount of swap is much less than amount of RAM.

The original testcase[1] drops caches then runs child(s) to allocate
(in sum) MemFree + SwapFree/2 memory. Each child runs in its own memory
cgroup but the amount of memory was choosen so that the whole system
would be under memory pressure. Does such test even make sense to you?

[1]:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh

-- 
Cyril Hrubis
chrubis@suse.cz
