From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 5 Mar 2020 17:53:43 +0800
Subject: [LTP] [PATCH] hugeshmctl01: Revert "hugeshmctl: Use loop from the
 API"
Message-ID: <1583402023-22461-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently, when I run this case, it failed as below:
./hugeshmctl01 -i 2
tst_test.c:1229: INFO: Timeout per run is 0h 05m 00s
mem.c:817: INFO: set nr_hugepages to 128
hugeshmctl01.c:198: PASS: pid, size, # of attaches and mode are correct - pass #0
hugeshmctl01.c:198: PASS: pid, size, # of attaches and mode are correct - pass #1
hugeshmctl01.c:263: PASS: new mode and change time are correct
hugeshmctl01.c:280: PASS: shmctl in func_rmid() failed as expected,...
tst_checkpoint.c:149: BROK: hugeshmctl01.c:152: tst_checkpoint_wait(0, 10000):ETIMEDOUT (110)

dmesg
hugeshmctl01[12232]: segfault at 7fe9d0000000 ip 0000000000404041 sp
00007fff69d8a8e0 error 6 in hugeshmctl01[400000+21000]

addr2line -e hugeshmctl01 -f  0000000000404041
stat_setup
/root/ltp/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c:139 (discriminator 4)

test = (stat_time == FIRST) ? set_shmat() : set_shared;

			/* do an assignement for fun */
139line			*(int *)test = i;

Case doesn't reset STAT_TIME(test used a null set_shared, and then test got value from
a null pointer), so it got segfault.

Also, if I reset this STAT_TIME in test_hugeshmctl when i is equal to 0, this case
still fails because shm_id_1 is disabled in func_rmid. If I don't disable shm_id_1,
it will report the following warning
WARNING: shared memory deletion failed
hugetlb.c:150: INFO: WARNING: shared memory deletion failed.
hugetlb.c:151: INFO: This could lead to IPC resource problems.

So I think reverting patch "hugeshmctl: Use loop from the API " for this case maybe a
good choice because old hugeshmctl works fine.

ps: If I am wrong, please correct me.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index e6cf8bf09..03dd46ea7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2004
- * Copyright (c) Linux Test Project, 2004-2020
+ * Copyright (c) Linux Test Project, 2004-2017
  */
 
 /*
@@ -73,20 +73,37 @@ struct tcase {
 	{IPC_RMID, func_rmid, NULL}
 };
 
-static void test_hugeshmctl(unsigned int i)
+static void test_hugeshmctl(void)
 {
+	unsigned int i;
+
+	/* initialize stat_time */
+	stat_time = FIRST;
+
 	/*
-	 * if needed, set up any required conditions by
-	 * calling the appropriate setup function
+	 * Create a shared memory segment with read and write
+	 * permissions.  Do this here instead of in setup()
+	 * so that looping (-i) will work correctly.
 	 */
-	if (tcases[i].func_setup != NULL)
-		(*tcases[i].func_setup) ();
+	shm_id_1 = shmget(shmkey, shm_size,
+			SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
+	if (shm_id_1 == -1)
+		tst_brk(TBROK | TERRNO, "shmget #main");
 
-	if (shmctl(shm_id_1, tcases[i].cmd, &buf) == -1) {
-		tst_res(TFAIL | TERRNO, "shmctl #main");
-		return;
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		/*
+		 * if needed, set up any required conditions by
+		 * calling the appropriate setup function
+		 */
+		if (tcases[i].func_setup != NULL)
+			(*tcases[i].func_setup) ();
+
+		if (shmctl(shm_id_1, tcases[i].cmd, &buf) == -1) {
+			tst_res(TFAIL | TERRNO, "shmctl #main");
+			continue;
+		}
+		(*tcases[i].func_test) ();
 	}
-	(*tcases[i].func_test)();
 }
 
 /*
@@ -296,19 +313,6 @@ void setup(void)
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
 	shmkey = getipckey();
-
-	/* initialize stat_time */
-	stat_time = FIRST;
-
-	/*
-	 * Create a shared memory segment with read and write
-	 * permissions.  Do this here instead of in setup()
-	 * so that looping (-i) will work correctly.
-	 */
-	shm_id_1 = shmget(shmkey, shm_size,
-			SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
-	if (shm_id_1 == -1)
-		tst_brk(TBROK | TERRNO, "shmget #main");
 }
 
 void cleanup(void)
@@ -318,12 +322,11 @@ void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.forks_child = 1,
 	.options = options,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = test_hugeshmctl,
+	.test_all = test_hugeshmctl,
 	.needs_checkpoints = 1,
 };
-- 
2.18.0



