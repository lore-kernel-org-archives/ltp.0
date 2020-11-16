From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 16 Nov 2020 14:09:15 +0100
Subject: [LTP] [PATCH] overcommit_memory: Remove unstable subtest
In-Reply-To: <20201116130915.18264-1-lkml@jv-coder.de>
References: <20201116130915.18264-1-lkml@jv-coder.de>
Message-ID: <20201116130915.18264-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The test sets overcommit policy to never overcommit and then tries
to allocate all possible memory. This should fail, since there is already
some memory allocated for running the test programm, but due to inaccurate
memory accounting in mm/util.c __vm_enough_memory(), the allocation can still
succeed.
The commited memory is stored in a percpu counter, that counts in 1 + ncpu
variables. For small allocations and deallocations, the memory is counted
in a counter per cpu, without locking. For larger (de-)allocations, it is
counted in a unified counter under lock. This can lead to this szenario:
The counters for each cpu account for all used memory, while the unified
counter might even be negative (because it only registered deallocations).
The function __vm_enough_memory() takes only the unified counter into
account and truncates negative values. This leads to the successfull
allocation of commit_limit sometimes.
This may be a design decision to prevent lock contention, since the more
accurate percpu_counter_sum (in contrast to percpu_counter_read_positive)
needs to lock the spinlock in order to get correct values.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/mem/tunable/overcommit_memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index f77939908..3ce0f05c8 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -154,7 +154,6 @@ static void overcommit_memory_test(void)
 
 	update_mem_commit();
 	alloc_and_check(commit_left * 2, EXPECT_FAIL);
-	alloc_and_check(commit_limit, EXPECT_FAIL);
 	update_mem_commit();
 	alloc_and_check(commit_left / 2, EXPECT_PASS);
 
-- 
2.25.1

