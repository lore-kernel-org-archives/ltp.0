From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:52 +0800
Subject: [LTP] [PATCH V2 10/14] mm/hugeshmdt: convert to new API
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-11-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     | 124 ++++++++-------------
 1 file changed, 47 insertions(+), 77 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 0ebcca6..dc16b9c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -1,26 +1,19 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2004
+ * Copyright (c) Linux Test Project, 2004-2017
  *
- *   Copyright (c) International Business Machines  Corp., 2004
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
- * NAME
- *	hugeshmdt01.c
- *
  * DESCRIPTION
  *	hugeshmdt01 - check that largr shared memory is detached correctly
  *
@@ -41,29 +34,14 @@
  *			issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmdt01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
  *	04/2004 - Updated by Robbie Williamson
- *
- * RESTRICTIONS
- *	none
  */
 
 #include <setjmp.h>
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmdt01";
-int TST_TOTAL = 1;
+#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -73,54 +51,43 @@ static int pass;
 static sigjmp_buf env;
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
 static void check_functionality(void);
 static void sighandler(int sig);
 
-int main(int ac, char **av)
+static void hugeshmdt_test(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, options, NULL);
-
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
+	struct sigaction sa;
 
-	setup();
+	sa.sa_handler = sighandler;
+	sigaction(SIGSEGV, &sa, NULL);
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		if (shmdt(shared) == -1) {
-			tst_resm(TFAIL | TERRNO, "shmdt");
-		} else {
-			check_functionality();
-		}
+	if (shmdt(shared) == -1)
+		tst_res(TFAIL | TERRNO, "shmdt");
+	else
+		check_functionality();
 
-		/* reattach the shared memory segment in case we are looping */
-		shared = shmat(shm_id_1, 0, 0);
-		if (shared == (void *)-1)
-			tst_brkm(TBROK | TERRNO, cleanup, "shmat #2: reattach");
+	/* reattach the shared memory segment in case we are looping */
+	shared = shmat(shm_id_1, 0, 0);
+	if (shared == (void *)-1)
+		tst_brk(TBROK | TERRNO, "shmat #2: reattach");
 
-		/* also reset pass */
-		pass = 0;
-	}
-	cleanup();
-	tst_exit();
+	/* also reset pass */
+	pass = 0;
 }
 
 static void check_functionality(void)
 {
 	/* stat the shared memory segment */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmctl");
+		tst_brk(TBROK | TERRNO, "shmctl");
 
 	if (buf.shm_nattch != 0) {
-		tst_resm(TFAIL, "# of attaches is incorrect");
+		tst_res(TFAIL, "# of attaches is incorrect");
 		return;
 	}
 
@@ -142,9 +109,9 @@ static void check_functionality(void)
 		*shared = 2;
 
 	if (pass)
-		tst_resm(TPASS, "huge shared memory detached correctly");
+		tst_res(TPASS, "huge shared memory detached correctly");
 	else
-		tst_resm(TFAIL, "huge shared memory was not detached "
+		tst_res(TFAIL, "huge shared memory was not detached "
 			 "correctly");
 }
 
@@ -156,7 +123,7 @@ static void sighandler(int sig)
 		pass = 1;
 		siglongjmp(env, 1);
 	} else {
-		tst_brkm(TBROK, cleanup, "unexpected signal received: %d", sig);
+		tst_brk(TBROK, "unexpected signal received: %d", sig);
 	}
 }
 
@@ -164,41 +131,44 @@ void setup(void)
 {
 	long hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-	tst_sig(NOFORK, sighandler, cleanup);
-	tst_tmpdir();
+	if (nr_opt)
+		hugepages = SAFE_STRTOL(nr_opt, 0, LONG_MAX);
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	set_sys_tune("nr_hugepages", hugepages, 1);
-	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
 	shm_size = hpage_size * hugepages / 2;
 	update_shm_size(&shm_size);
-	shmkey = getipckey(cleanup);
+	shmkey = getipckey();
 
 	/* create a shared memory resource with read and write permissions */
 	shm_id_1 = shmget(shmkey, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+		tst_brk(TBROK | TERRNO, "shmget");
 
 	/* attach the shared memory segment */
 	shared = shmat(shm_id_1, 0, 0);
 	if (shared == (void *)-1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmat #1");
+		tst_brk(TBROK | TERRNO, "shmat #1");
 
 	/* give a value to the shared memory integer */
 	*shared = 4;
-
-	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
 	rm_shm(shm_id_1);
-
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmdt01",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = hugeshmdt_test,
+};
-- 
2.9.3

