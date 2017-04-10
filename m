From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:50 +0800
Subject: [LTP] [PATCH V2 08/14] mem/hugeshmat: convert to new API
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-9-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     | 179 +++++++++------------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     | 133 ++++++---------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     | 132 ++++++---------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat04.c     | 118 +++++---------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat05.c     |  70 +++-----
 5 files changed, 239 insertions(+), 393 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index cfb4d72..b892d57 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -1,26 +1,19 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2001-2017
  *
- *   Copyright (c) International Business Machines  Corp., 2001
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
- *	hugeshmat01.c
- *
  * DESCRIPTION
  *	hugeshmat01 - test that shmat() works correctly
  *
@@ -39,107 +32,73 @@
  *			issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmat01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -f   : Turn off functionality Testing.
- *	       -i n : Execute test n times.
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
 
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
+#include "hugetlb.h"
 
-char *TCID = "hugeshmat01";
-int TST_TOTAL = 3;
-
-#define CASE0		10	/* values to write into the shared */
-#define CASE1		20	/* memory location.                */
+#define CASE0 10 /* values to write into the shared */
+#define CASE1 20 /* memory location.                */
 
 static size_t shm_size;
 static int shm_id_1 = -1;
 static void *addr;
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-struct test_case_t {
+static struct tcase {
 	int *shmid;
 	void *addr;
 	int flags;
-} TC[] = {
+} tcases[] = {
 	/* a straight forward read/write attach */
-	{
-	&shm_id_1, 0, 0},
-	    /*
-	     * an attach using non aligned memory
-	     * -1 will be replaced with an unaligned addr
-	     */
-	{
-	&shm_id_1, (void *)-1, SHM_RND},
-	    /* a read only attach */
-	{
-	&shm_id_1, 0, SHM_RDONLY}
+	{&shm_id_1, 0, 0},
+	/*
+	 * an attach using non aligned memory
+	 * -1 will be replaced with an unaligned addr
+	 */
+	{&shm_id_1, (void *)-1, SHM_RND},
+	/* a read only attach */
+	{&shm_id_1, 0, SHM_RDONLY}
 };
 
-static void check_functionality(int i);
+static void check_functionality(unsigned int i);
 
-int main(int ac, char **av)
+static void verify_hugeshmat(unsigned int i)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, options, NULL);
-
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			addr = shmat(*(TC[i].shmid), TC[i].addr, TC[i].flags);
-			if (addr == (void *)-1) {
-				tst_brkm(TFAIL | TERRNO, cleanup, "shmat");
-			} else {
-				check_functionality(i);
-			}
-
-			/*
-			 * addr in TC[0] will be used to generate an unaligned
-			 * address for TC[1]
-			 */
-			if (i == 0 && addr != (void *)-1)
-				TC[1].addr = (void *)(((unsigned long)addr &
-						       ~(SHMLBA - 1)) + SHMLBA -
-						      1);
-			if (shmdt(addr) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup, "shmdt");
-		}
+	struct tcase *tc = &tcases[i];
+
+	addr = shmat(*(tc->shmid), tc->addr, tc->flags);
+	if (addr == (void *)-1) {
+		tst_brk(TFAIL | TERRNO, "shmat");
+	} else {
+		check_functionality(i);
 	}
-	cleanup();
-	tst_exit();
+
+	/*
+	 * addr in tcases[0] will be used to generate an unaligned
+	 * address for tcases[1]
+	 */
+	if (i == 0 && addr != (void *)-1)
+		tc[1].addr = (void *)(((unsigned long)addr &
+					~(SHMLBA - 1)) + SHMLBA - 1);
+	if (shmdt(addr) == -1)
+		tst_brk(TBROK | TERRNO, "shmdt");
 }
 
 /*
  * check_functionality - check various conditions to make sure they
  *			 are correct.
  */
-static void check_functionality(int i)
+static void check_functionality(unsigned int i)
 {
 	void *orig_add;
 	int *shared;
@@ -149,17 +108,17 @@ static void check_functionality(int i)
 
 	/* stat the shared memory ID */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmctl");
+		tst_brk(TBROK | TERRNO, "shmctl");
 
 	/* check the number of attaches */
 	if (buf.shm_nattch != 1) {
-		tst_resm(TFAIL, "# of attaches is incorrect");
+		tst_res(TFAIL, "# of attaches is incorrect");
 		return;
 	}
 
 	/* check the size of the segment */
 	if (buf.shm_segsz != shm_size) {
-		tst_resm(TFAIL, "segment size is incorrect");
+		tst_res(TFAIL, "segment size is incorrect");
 		return;
 	}
 
@@ -182,9 +141,9 @@ static void check_functionality(int i)
 		 * specified in the man page.
 		 */
 		*shared = CASE1;
-		orig_add = addr + ((unsigned long)TC[i].addr % SHMLBA);
-		if (orig_add != TC[i].addr) {
-			tst_resm(TFAIL, "shared memory address is not "
+		orig_add = addr + ((unsigned long)tcases[i].addr % SHMLBA);
+		if (orig_add != tcases[i].addr) {
+			tst_res(TFAIL, "shared memory address is not "
 				 "correct");
 			return;
 		}
@@ -196,43 +155,49 @@ static void check_functionality(int i)
 		 * because shared memory is persistent.
 		 */
 		if (*shared != CASE1) {
-			tst_resm(TFAIL, "shared memory value isn't correct");
+			tst_res(TFAIL, "shared memory value isn't correct");
 			return;
 		}
 		break;
 	}
-	tst_resm(TPASS, "conditions and functionality are correct");
+	tst_res(TPASS, "conditions and functionality are correct");
 }
 
-void setup(void)
+static void setup(void)
 {
 	long hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
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
 	shm_id_1 = shmget(shmkey++, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+		tst_brk(TBROK | TERRNO, "shmget");
 
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmat01",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_hugeshmat,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index e644178..ef26e95 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
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
- *	hugeshmat02.c
- *
  * DESCRIPTION
  *	hugeshmat02 - check for EINVAL and EACCES errors with hugetlb
  *
@@ -33,15 +26,6 @@
  *	    issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmat02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
  *	04/2004 - Updated By Robbie Williamson
@@ -50,13 +34,8 @@
  *	Must be ran as root
  */
 
-#include <pwd.h>
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmat02";
-int TST_TOTAL = 2;
+#include "hugetlb.h"
 
 #if __WORDSIZE == 64
 #define NADDR	0x10000000eef	/* a 64bit non alligned address value */
@@ -70,88 +49,80 @@ static int shm_id_2 = -1;
 static void *addr;
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-struct test_case_t {
+struct tcase {
 	int *shmid;
 	void *addr;
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* EINVAL - the shared memory ID is not valid */
-	{
-	&shm_id_1, NULL, EINVAL},
-	    /* EINVAL - the address is not page aligned and SHM_RND is not given */
-	{
-&shm_id_2, (void *)NADDR, EINVAL},};
+	{&shm_id_1, NULL, EINVAL},
+	/* EINVAL - the address is not page aligned and SHM_RND is not given */
+	{&shm_id_2, (void *)NADDR, EINVAL}
+};
 
-int main(int ac, char **av)
+static void verify_hugeshmat(unsigned int i)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, options, NULL);
-
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			addr = shmat(*(TC[i].shmid), TC[i].addr, 0);
-			if (addr != (void *)-1) {
-				tst_resm(TFAIL, "shmat suceeded unexpectedly");
-				continue;
-			}
-			if (errno == TC[i].error)
-				tst_resm(TPASS | TERRNO, "shmat failed as "
-					 "expected");
-			else
-				tst_resm(TFAIL | TERRNO, "shmat failed "
-					 "unexpectedly - expect errno=%d, "
-					 "got", TC[i].error);
-		}
+	struct tcase *tc = &tcases[i];
+
+	addr = shmat(*(tc->shmid), tc->addr, 0);
+	if (addr != (void *)-1) {
+		tst_res(TFAIL, "shmat suceeded unexpectedly");
+		return;
+	}
+
+	if (errno == tc->error) {
+		tst_res(TPASS | TERRNO, "shmat failed as "
+				"expected");
+	} else {
+		tst_res(TFAIL | TERRNO, "shmat failed "
+				"unexpectedly - expect errno=%d, "
+				"got", tc->error);
 	}
-	cleanup();
-	tst_exit();
 }
 
 void setup(void)
 {
 	long hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
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
 	/* also post increment the shmkey for the next shmget call */
 	shm_id_2 = shmget(shmkey++, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_2 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
-
-	TEST_PAUSE;
+		tst_brk(TBROK | TERRNO, "shmget");
 }
 
 void cleanup(void)
 {
 	rm_shm(shm_id_2);
-
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmat02",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_hugeshmat,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index a0cea9a..8121e3c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
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
- *	hugeshmat03.c
- *
  * DESCRIPTION
  *	hugeshmat03 - test for EACCES error
  *
@@ -40,15 +33,6 @@
  *	  wait for child to exit
  *	  remove the shared memory segment
  *
- * USAGE:  <for command-line>
- *  hugeshmat03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
  * HISTORY
  *	03/2001 - Written by Wayne Boyer
  *	04/2004 - Updated by Robbie Williamson
@@ -57,12 +41,8 @@
  *	test must be run at root
  */
 
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmat03";
-int TST_TOTAL = 1;
+#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -71,92 +51,76 @@ static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-static void do_child(void);
-
-int main(int ac, char **av)
+static void verify_hugeshmat(void)
 {
 	int status;
 	pid_t pid;
 
-	tst_parse_opts(ac, av, options, NULL);
-
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	switch (pid = SAFE_FORK()) {
 	case 0:
 		if (setuid(ltp_uid) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "setuid");
-		do_child();
-		tst_exit();
-	default:
-		if (waitpid(pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void do_child(void)
-{
-	int lc;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
+			tst_brk(TBROK | TERRNO, "setuid");
 
 		addr = shmat(shm_id_1, NULL, 0);
 		if (addr != (void *)-1) {
-			tst_resm(TFAIL, "shmat succeeded unexpectedly");
-			continue;
+			tst_res(TFAIL, "shmat succeeded unexpectedly");
+			return;
+		}
+		if (errno == EACCES) {
+			tst_res(TPASS | TERRNO, "shmat failed as expected");
+		} else {
+			tst_res(TFAIL | TERRNO, "shmat failed unexpectedly "
+					"- expect errno=EACCES, got");
 		}
-		if (errno == EACCES)
-			tst_resm(TPASS | TERRNO, "shmat failed as expected");
-		else
-			tst_resm(TFAIL | TERRNO, "shmat failed unexpectedly "
-				 "- expect errno=EACCES, got");
+		break;
+	default:
+		if (waitpid(pid, &status, 0) == -1)
+			tst_brk(TBROK | TERRNO, "waitpid");
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
 	long hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-	tst_sig(FORK, DEF_HANDLER, cleanup);
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
 	shm_id_1 = shmget(shmkey, shm_size,
 			  SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
-
-	ltp_uid = getuserid(cleanup, ltp_user);
+		tst_brk(TBROK | TERRNO, "shmget");
 
-	TEST_PAUSE;
+	ltp_uid = getuserid(ltp_user);
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	rm_shm(shm_id_1);
-
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmat03",
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.test_all = verify_hugeshmat,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 7a71747..4239b2f 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -1,20 +1,15 @@
 /*
- *   Copyright (c) Linux Test Project, 2014
+ * Copyright (c) Linux Test Project, 2014-2017
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- *   02110-1301 USA
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -35,26 +30,12 @@
  * 	test must be run at root
  */
 
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/shm.h>
-#include <sys/wait.h>
-
-#include "test.h"
 #include "mem.h"
 #include "hugetlb.h"
 
 #define SIZE	(1024 * 1024 * 1024)
 #define BOUNDARY (1024 * 1024 * 1024)
 
-char *TCID = "hugeshmat04";
-int TST_TOTAL = 3;
-
 static long huge_free;
 static long huge_free2;
 static long hugepages;
@@ -62,36 +43,19 @@ static long orig_shmmax, new_shmmax;
 
 static void shared_hugepage(void);
 
-int main(int ac, char **av)
+static void test_hugeshmat(unsigned int i LTP_ATTRIBUTE_UNUSED)
 {
-	int lc, i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			huge_free = read_meminfo("HugePages_Free:");
-			shared_hugepage();
-			huge_free2 = read_meminfo("HugePages_Free:");
-
-			if (huge_free2 != huge_free)
-				tst_brkm(TFAIL, cleanup,
-				"Test failed. Hugepage leak inspection.");
-			else
-				tst_resm(TPASS, "No regression found.");
-		}
-	}
-
-	cleanup();
-	tst_exit();
+	huge_free = SAFE_READ_MEMINFO("HugePages_Free:");
+	shared_hugepage();
+	huge_free2 = SAFE_READ_MEMINFO("HugePages_Free:");
+
+	if (huge_free2 != huge_free)
+		tst_brk(TFAIL, "Test failed. Hugepage leak inspection.");
+	else
+		tst_res(TPASS, "No regression found.");
 }
 
-void shared_hugepage(void)
+static void shared_hugepage(void)
 {
 	pid_t pid;
 	int status, shmid;
@@ -100,56 +64,60 @@ void shared_hugepage(void)
 
 	shmid = shmget(IPC_PRIVATE, size, SHM_HUGETLB | IPC_CREAT | 0777);
 	if (shmid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+		tst_brk(TBROK | TERRNO, "shmget");
 
 	buf = shmat(shmid, (void *)BOUNDARY, SHM_RND | 0777);
 	if (buf == (void *)-1) {
 		shmctl(shmid, IPC_RMID, NULL);
-		tst_brkm(TBROK | TERRNO, cleanup, "shmat");
+		tst_brk(TBROK | TERRNO, "shmat");
 	}
 
 	memset(buf, 2, size);
-	pid = fork();
-
+	pid = SAFE_FORK();
 	if (pid == 0)
 		exit(1);
-	else if (pid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 
 	wait(&status);
 	shmdt(buf);
 	shmctl(shmid, IPC_RMID, NULL);
 }
 
-void setup(void)
+static void setup(void)
 {
 	long mem_total, hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-
-	mem_total = read_meminfo("MemTotal:");
-	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &orig_shmmax);
-	SAFE_FILE_PRINTF(NULL, PATH_SHMMAX, "%ld", (long)SIZE);
-	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &new_shmmax);
+	mem_total = SAFE_READ_MEMINFO("MemTotal:");
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
+	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
 
 	if (mem_total < 2L*1024*1024)
-		tst_brkm(TCONF,	NULL, "Needed > 2GB RAM, have: %ld", mem_total);
+		tst_brk(TCONF,	"Needed > 2GB RAM, have: %ld", mem_total);
 
 	if (new_shmmax < SIZE)
-		tst_brkm(TCONF,	NULL, "shmmax too low, have: %ld", new_shmmax);
+		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
-	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
 	hugepages = (orig_hugepages * hpage_size + SIZE) / hpage_size;
 	set_sys_tune("nr_hugepages", hugepages, 1);
-
-	TEST_PAUSE;
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-	SAFE_FILE_PRINTF(NULL, PATH_SHMMAX, "%ld", orig_shmmax);
+	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmat04",
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.tcnt = 3,
+	.test = test_hugeshmat,
+	.setup = setup,
+	.cleanup = cleanup,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
index 8c17f21..23c1a3b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat05.c
@@ -1,18 +1,15 @@
 /*
- * Copyright (c) 2015 Red Hat, Inc.
+ * Copyright (c) 2015-2017 Red Hat, Inc.
  *
- * This program is free software: you can redistribute it and/or modify
+ * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
+ * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  */
 
 /*
@@ -39,21 +36,9 @@
  *
  */
 
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <sys/mman.h>
-#include <fcntl.h>
-
-#include "test.h"
 #include "mem.h"
 #include "hugetlb.h"
 
-char *TCID = "hugeshmat05";
-int TST_TOTAL = 1;
-
 static long page_size;
 static long hpage_size;
 static long hugepages;
@@ -62,17 +47,13 @@ static long hugepages;
 
 void setup(void)
 {
-	tst_require_root();
 	check_hugepage();
-
 	orig_hugepages = get_sys_tune("nr_hugepages");
 	page_size = getpagesize();
-	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 
 	hugepages = N + 1;
 	set_sys_tune("nr_hugepages", hugepages, 1);
-
-	TEST_PAUSE;
 }
 
 void cleanup(void)
@@ -87,35 +68,30 @@ void shm_test(int size)
 
 	shmid = shmget(IPC_PRIVATE, size, 0600 | IPC_CREAT | SHM_HUGETLB);
 	if (shmid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget failed");
+		tst_brk(TBROK | TERRNO, "shmget failed");
 
 	shmaddr = shmat(shmid, 0, 0);
 	if (shmaddr == (char *)-1) {
 		shmctl(shmid, IPC_RMID, NULL);
-		tst_brkm(TFAIL | TERRNO, cleanup,
+		tst_brk(TFAIL | TERRNO,
 			 "Bug: shared memory attach failure.");
 	}
 
 	shmaddr[0] = 1;
-	tst_resm(TINFO, "allocated %d huge bytes", size);
+	tst_res(TINFO, "allocated %d huge bytes", size);
 
 	if (shmdt((const void *)shmaddr) != 0) {
 		shmctl(shmid, IPC_RMID, NULL);
-		tst_brkm(TFAIL | TERRNO, cleanup, "Detach failure.");
+		tst_brk(TFAIL | TERRNO, "Detach failure.");
 	}
 
 	shmctl(shmid, IPC_RMID, NULL);
 }
 
-int main(int ac, char **av)
+static void test_hugeshmat(void)
 {
-	int lc;
 	unsigned int i;
 
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
 	const int tst_sizes[] = {
 		N * hpage_size - page_size,
 		N * hpage_size - page_size - 1,
@@ -123,15 +99,17 @@ int main(int ac, char **av)
 		hpage_size + 1
 	};
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < ARRAY_SIZE(tst_sizes); ++i)
-			shm_test(tst_sizes[i]);
+	for (i = 0; i < ARRAY_SIZE(tst_sizes); ++i)
+		shm_test(tst_sizes[i]);
 
-		tst_resm(TPASS, "No regression found.");
-	}
-
-	cleanup();
-	tst_exit();
+	tst_res(TPASS, "No regression found.");
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmat05",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.test_all = test_hugeshmat,
+	.setup = setup,
+	.cleanup = cleanup,
+};
-- 
2.9.3

