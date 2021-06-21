From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Jun 2021 19:15:08 +0800
Subject: [LTP] [PATCH 1/2] mem: child memory alloc should larger than
 memory.max+memory.swap.max if lite==1
Message-ID: <20210621111509.358656-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

oom03 often gets fail while setting 'memory.swap.max = TESTMEM' in CGroup,
because in that scenario (lite == 1), child_alloc only start a single process
to dirty 'TESTMEM + 1MB' anonymous memory for testing:

testoom(, lite == 1, ,)
? oom(, lite == 1, ,)
? ? child_alloc(, lite == 1,)
? ? ? ? alloc_mem(TESTMEM + MB, )

  mem.c:224: TINFO: start normal OOM testing.
  mem.c:146: TINFO: expected victim is 80466.
  mem.c:38: TINFO: thread (7f411c69d740), allocating 1074790400 bytes.

  mem.c:64: TINFO: swapped is 25546752 bytes.  <-------- swap occuring -----

  mem.c:164: TFAIL: victim unexpectedly ended with retcode: 0, expected: 12

TBH, it can NOT really test the memory.swap.max as expected, since in
kernel side mem_cgroup_out_of_memory split OOM margin into two part, one
for memory.max limit, another for memory.swap.max, if any of them get
overflow, then involk out_of_memory to kill victim-process.

Theoretically, alloc_mem(TESTMEM + MB, ) should work while 'memory.max' is
equal to TESTMEM, but with swappiness enable (default value is 60 on RHEL),
it likely has part of memory swapping out during the allocating, so the two
limit loss effect@the same time. (unless disable swappiness completely then
memory.max will take effect in precisely)

To stay on the safe side, here raising the single process to alloc a bit
more memory which is larger than 'memory.max + memory.swap.max' (TESTMEM * 2 + 1MB),
that will obviously work fine in real situations.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    This is debugging code for showing swapped:
    
    --- a/testcases/kernel/mem/lib/mem.c
    +++ b/testcases/kernel/mem/lib/mem.c
    @@ -59,6 +59,10 @@ static int alloc_mem(long int length, int testcase)
            for (i = 0; i < length; i += pagesz)
                    s[i] = '\a';
    
    +       long swapped = SAFE_READ_PROC_STATUS(getpid(), "VmSwap:");
    +       tst_res(TINFO, "swapped is %ld bytes.", swapped * 1024);
    +
            return 0;
     }

 testcases/kernel/mem/lib/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 9f946b5c9..ecc61b216 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -78,7 +78,7 @@ static void child_alloc(int testcase, int lite, int threads)
 	pthread_t *th;
 
 	if (lite) {
-		int ret = alloc_mem(TESTMEM + MB, testcase);
+		int ret = alloc_mem(TESTMEM + TESTMEM + MB, testcase);
 		exit(ret);
 	}
 
-- 
2.31.1

