From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Dec 2020 15:29:03 +0100
Subject: [LTP] [PATCH v3] overcommit_memory: Fix unstable subtest
In-Reply-To: <f17f7936-5fd2-b217-e945-1409d9d40eeb@jv-coder.de>
References: <20201127071419.20370-1-lkml@jv-coder.de>
 <20201203153030.GE5809@yuki.lan>
 <f17f7936-5fd2-b217-e945-1409d9d40eeb@jv-coder.de>
Message-ID: <X9OCL/ZFVhKtkySv@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do wonder, are the counters flushed if task is migrated between CPUs?
> > If so we wouldn't need the multiplication by bcpus.
> IIRC, no they are not flushed and there wouldn't be any reason for that. 
> These counters are not supposed to account per cpu statistics, they are 
> just used to prevent lock contention. If a task is migrated to another 
> cpu and it's memory is freed there, the counter may become negative, 
> which is perfectly fine.
> Additionally this total batch size is the maximum amount, the global 
> counter can deviate from the real value. This takes into account all 
> processes running on all cpus, because the overcommit limit is a global 
> limit, not a per task one.

Sounds reasonable.

Btw I wonder if we can get into a situation where
commit_left < total_batch_size, but I guess that it's unlikely.

> > Can we please call the get_total_back_size_bytes() in the test setup and
> > store the value.
> I think I left this in the test function, because there is a slight 
> chance, that the value changes over time due to hotplug. If cpus are 
> added (really plugged into the system, not only enabled) or if there is 
> memory added, the value changes. In vms with memory ballooning, I think 
> this is more likely to happen. The cost is not very high, so why add the 
> possiblity to break this?

Well this does not fix the race, in a fact it does not even shrink the
race window that much. If the hotplug happens anwhere after the call to
the tst_ncpus_conf() it will still fail since the change will not be
reflected in the test anyways.

So I would prefer simply stating that the test results are undefined if
hotplug happens while the test is running and put the call to the test
setup. There are couple of NUMA tests in LTP that are not CPU hotplug
safe anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
