From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 17 Nov 2020 11:06:54 +0100
Subject: [LTP] [PATCH 0/1] overcommit_memory: Remove unstable subtest
In-Reply-To: <875z64pc1r.fsf@suse.de>
References: <20201116130915.18264-1-lkml@jv-coder.de> <875z64pc1r.fsf@suse.de>
Message-ID: <648d7b53-2451-718b-6736-e6dffd4c72e8@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,
> Possibly /proc/sys/vm/stat_refresh can be used to flush these counters
> after changing the overcommit policy?
This sounds interesting. From the code I cannot see that it works with 
vm_committed_as.
If this is not done with some "invisible" magic, I do not think it will 
help.
> I guess that if these counters turning negative is considered a bug then
> a warning will be printed otherwise the test needs to be smarter.
No I do not think so. For correct memory accounting, used for e.g. 
Commited_AS in /proc /meminfo, the memory is summed up correctly using 
global_counter + sum(cpu_counters). If global_counter is negative, than 
the cpu_counters are positive by at least the same amount and the 
overall memory is reported correctly again.

The problem here is, that __vm_enough_memory in mm/util.c uses only the 
global_counter truncated at 0, through percpu_counter_read_positive. I 
guess this is intentional, because it prevents locking for memory 
allocations. The summation function used above requires locking.

The test cannot know what value the 1+ncpu counters have, so it cannot 
print a warning or anything.

While writing this an checking the kernel code I realized that this 
issue shouldn't exist anymore with linux 5.9.
Commit 56f3547bfa4d361148aa748ccb86073bc57f5e6c syncs the counters (i.e. 
summing up the total value in the gobal_counter), when the overcommit 
policy is changed to NEVER.
Yet this subtest cannot be considered a test f or this change, because 
for that allocations and deallocations have to be carefully constructed, 
to trigger the behavior I described.

I am not sure what ltp's policy is for supporting older kernel versions. 
Probably not supporting them, then this patch should be rejected, but 
maybe the commit id should be mentioned there.

J?rg


