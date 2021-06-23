From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Jun 2021 14:24:54 +0800
Subject: [LTP] [PATCH v3 1/3] mem: child alloc memory should larger than
 memory.max + memory.swap.max if lite==1
Message-ID: <20210623062456.430406-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

oom03 often gets fail while setting 'memory.swap.max = TESTMEM' in CGroup V2,
as in that scenario (lite == 1), child_alloc only start a single process to
dirty 'TESTMEM + MB' anonymous memory for testing:

testoom(, lite == 1, ,)
? oom(, lite == 1, ,)
? ? child_alloc(, lite == 1,)
? ? ? ? alloc_mem(TESTMEM + MB, )

  mem.c:224: TINFO: start normal OOM testing.
  mem.c:146: TINFO: expected victim is 80466.
  mem.c:38: TINFO: thread (7f411c69d740), allocating 1074790400 bytes.
  mem.c:64: TINFO: swapped is 25546752 bytes.     <------- swap occuring -----
  mem.c:164: TFAIL: victim unexpectedly ended with retcode: 0, expected: 12

TBH, this can not really test the 'memory.swap.max' as expected, since in the
kernel side mem_cgroup_out_of_memory split OOM margin into two-part, one for
memory.max limit, another for memory.swap.max, if any of them get overflow,
then invoke out_of_memory to kill victim-process.

Theoretically, alloc_mem(TESTMEM + MB, ) should work while 'memory.max' is equal
to TESTMEM, but Cgroup v2 tracks memory and swap in separate, which splits memory
and swap counter. So with swappiness enable (default value is 60 on RHEL), it
likely has part of memory swapping out during the allocating, upon that the two
limit loss effect@the same time. Unless disable swap completely then memory.max
will take effect in precisely.

To get more opportunities to reach the swap limitation, let's scale down the
value of 'memory.swap.max' to only 1MB for CGroup v2.

But for CGroup v1, the memory.memsw.limit_in_bytes disallow to less than
memory.limit_in_bytes, so we'd better raise the child_alloc to the twofold
of TESTMEM, and reset memory.memsw.limit_in_bytes to 'TESTMEM + MB'.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3
      * set memory.memsw.limit_in_bytes to TESTMEM+MB as suggest by Richard
      * typo fix and some comments embellishment

 testcases/kernel/mem/lib/mem.c   |  2 +-
 testcases/kernel/mem/oom/oom03.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 9f946b5c9..ac890491c 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -78,7 +78,7 @@ static void child_alloc(int testcase, int lite, int threads)
 	pthread_t *th;
 
 	if (lite) {
-		int ret = alloc_mem(TESTMEM + MB, testcase);
+		int ret = alloc_mem(TESTMEM * 2 + MB, testcase);
 		exit(ret);
 	}
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 939413744..b3770cf8f 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -46,7 +46,21 @@ static void verify_oom(void)
 	testoom(0, 0, ENOMEM, 1);
 
 	if (SAFE_CGROUP_HAS(cg, "memory.swap.max")) {
-		SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM);
+		/*
+		 * Cgroup v2 tracks memory and swap in separate, which splits
+		 * memory and swap counter. So with swappiness enable (default
+		 * value is 60 on RHEL), it likely has part of memory swapping
+		 * out during the allocating.
+		 *
+		 * To get more opportunities to reach the swap limitation,
+		 * let's scale down the value of 'memory.swap.max' to only
+		 * 1MB for CGroup v2.
+		 */
+		if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", MB);
+		else
+			SAFE_CGROUP_PRINTF(cg, "memory.swap.max", "%lu", TESTMEM + MB);
+
 		testoom(0, 1, ENOMEM, 1);
 	}
 
-- 
2.31.1

