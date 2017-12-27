From: Liu Haitao <haitao.liu@windriver.com>
Date: Wed, 27 Dec 2017 17:15:00 +0800
Subject: [LTP] [PATCH] tunable/overcommit_memory: clear the cached memory
	when overcommit_memory is set to 0
Message-ID: <1514366100-260502-1-git-send-email-haitao.liu@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes failures on machines where the overcommit_memory is set to 0.

For some embedded machines with memory less than 1G, when run ltp testcase a lot
of memory would be cached by kernel which could be found in "/proc/meminfo".

This testcase would allocate the double amount of free_memory when
overcommit_memory is set to 0.

If the overcommit_memory is 0, the kernel would regard the cached memory as a
part of allocatable memory which could be allocated.

So if a mass of memory is cached by kernel, the testcase would fail.

For example:
------------------------------------------------
root@nxp-ls1012:~# cat /proc/meminfo
MemTotal:        1001228 kB
MemFree:          863816 kB
MemAvailable:     938212 kB
Buffers:               0 kB
Cached:            48448 kB

This nxp-ls1012 machine has 1G memory and the  cached memory is just 40M.

When run the overcommit_memory testcase it failed with the following error:

	overcommit_memory    0  TINFO  :  set overcommit_memory to 0
	overcommit_memory    0  TINFO  :  malloc 164628 kB successfully
	overcommit_memory    1  TPASS  :  alloc passed as expected
	overcommit_memory    0  TINFO  :  malloc 658512 kB successfully
	overcommit_memory    2  TFAIL  :  overcommit_memory.c:210: alloc passed,
		     expected to fail

root@nxp-ls1012:~# cat /proc/meminfo
MemTotal:        1001228 kB
MemFree:          329848 kB
MemAvailable:     936008 kB
Buffers:             748 kB
Cached:           577936 kB

After running this testcase, about 500M memory was cached and it succeeded in
allocating 658512KB memory which is double than MemFree.

-------------------------------------------

So we should clear the catched memory before the test.

Signed-off-by: Liu Haitao <haitao.liu@windriver.com>
---
 testcases/kernel/mem/tunable/overcommit_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 984448b6f..5a496eef5 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -157,7 +157,8 @@ static void overcommit_memory_test(void)
 
 	/* start to test overcommit_memory=0 */
 	set_sys_tune("overcommit_memory", 0, 1);
-
+	/* clear the cached memory */
+	set_sys_tune("drop_caches", 3, 1);
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
 	update_mem();
-- 
2.11.0

