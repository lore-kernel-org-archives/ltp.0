From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:53 +0800
Subject: [LTP] [PATCH V2 11/14] mem/hugeshmget: convert to new API
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-12-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   | 168 ++++++++-------------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   | 155 ++++++++-----------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   | 118 ++++++---------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   | 121 ++++++---------
 4 files changed, 206 insertions(+), 356 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 2367c4d..d1a3dea 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
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
- *	hugeshmget01.c
- *
  * DESCRIPTION
  *	hugeshmget01 - test that shmget() correctly creates a large
  *			shared memory segment
@@ -41,128 +34,93 @@
  *	  else issue a PASS message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  shmget01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
-
-char *TCID = "hugeshmget01";
-int TST_TOTAL = 1;
+#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-int main(int ac, char **av)
+static void test_hugeshmget(void)
 {
-	int lc;
 	struct shmid_ds buf;
 
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
-		shm_id_1 = shmget(shmkey, shm_size,
-				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
-		if (shm_id_1 == -1) {
-			tst_resm(TFAIL | TERRNO, "shmget");
-		} else {
-			/* do a STAT and check some info */
-			if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-				tst_resm(TBROK | TERRNO,
-					 "shmctl(IPC_STAT)");
-				continue;
-			}
-			/* check the seqment size */
-			if (buf.shm_segsz != shm_size) {
-				tst_resm(TFAIL, "seqment size is not "
-					 "correct");
-				continue;
-			}
-			/* check the pid of the creator */
-			if (buf.shm_cpid != getpid()) {
-				tst_resm(TFAIL, "creator pid is not "
-					 "correct");
-				continue;
-			}
-			/*
-			 * check the mode of the seqment
-			 * mask out all but the lower 9 bits
-			 */
-			if ((buf.shm_perm.mode & MODE_MASK) !=
-			    ((SHM_RW) & MODE_MASK)) {
-				tst_resm(TFAIL, "segment mode is not "
-					 "correct");
-				continue;
-			}
-			/* if we get here, everything looks good */
-			tst_resm(TPASS, "size, pid & mode are correct");
-		}
-
-		/*
-		 * clean up things in case we are looping
-		 */
-		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1)
-			tst_resm(TBROK | TERRNO, "shmctl(IPC_RMID)");
-		else
-			shm_id_1 = -1;
+	/* do a STAT and check some info */
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
+		tst_res(TFAIL | TERRNO,
+				"shmctl(IPC_STAT)");
+		return;
+	}
+	/* check the seqment size */
+	if (buf.shm_segsz != shm_size) {
+		tst_res(TFAIL, "seqment size is not "
+				"correct");
+		return;
+	}
+	/* check the pid of the creator */
+	if (buf.shm_cpid != getpid()) {
+		tst_res(TFAIL, "creator pid is not "
+				"correct");
+		return;
+	}
+	/*
+	 * check the mode of the seqment
+	 * mask out all but the lower 9 bits
+	 */
+	if ((buf.shm_perm.mode & MODE_MASK) !=
+			((SHM_RW) & MODE_MASK)) {
+		tst_res(TFAIL, "segment mode is not "
+				"correct");
+		return;
 	}
-	cleanup();
-	tst_exit();
+
+	/* if we get here, everything looks good */
+	tst_res(TPASS, "size, pid & mode are correct");
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
 
-	TEST_PAUSE;
+	shm_id_1 = shmget(shmkey, shm_size,
+			SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
+	if (shm_id_1 == -1)
+		tst_brk(TBROK | TERRNO, "shmget");
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
+	.tid = "hugeshmget01",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmget,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 5f2cb31..6296b91 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
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
- *	hugeshmget02.c
- *
  * DESCRIPTION
  *	hugeshmget02 - check for ENOENT, EEXIST and EINVAL errors
  *
@@ -34,29 +27,13 @@
  *	    issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmget02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *
- * RESTRICTIONS
- *	none
  */
 
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmget02";
-int TST_TOTAL = 4;
+#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -64,105 +41,91 @@ static int shm_nonexistent_key = -1;
 static key_t shmkey2;
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-struct test_case_t {
+static struct tcase {
 	int *skey;
 	int size_coe;
 	int flags;
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* EINVAL - size is 0 */
-	{
-	&shmkey2, 0, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
-	    /* EINVAL - size is larger than created segment */
-	{
-	&shmkey, 2, SHM_HUGETLB | SHM_RW, EINVAL},
-	    /* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
-	{
-	&shmkey, 1, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EEXIST},
-	    /* ENOENT - no segment exists for the key and IPC_CREAT is not given */
-	    /* use shm_nonexistend_key (-1) as the key */
-	{
-	&shm_nonexistent_key, 1, SHM_HUGETLB | SHM_RW, ENOENT}
+	{&shmkey2, 0, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
+	/* EINVAL - size is larger than created segment */
+	{&shmkey, 2, SHM_HUGETLB | SHM_RW, EINVAL},
+	/* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
+	{&shmkey, 1, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EEXIST},
+	/* ENOENT - no segment exists for the key and IPC_CREAT is not given */
+	/* use shm_nonexistend_key (-1) as the key */
+	{&shm_nonexistent_key, 1, SHM_HUGETLB | SHM_RW, ENOENT}
 };
 
-int main(int ac, char **av)
+static void test_hugeshmget(void)
 {
-	int lc, i;
+	unsigned int i;
 	int shm_id_2 = -1;
 
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
-			/* If this key is existent, just remove it */
-			if (*TC[i].skey == -1) {
-				shm_id_2 = shmget(*(TC[i].skey), 0, 0);
-				if (shm_id_2 != -1)
-					shmctl(shm_id_2, IPC_RMID, NULL);
-			}
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		/* If this key is existent, just remove it */
+		if (*tcases[i].skey == -1) {
+			shm_id_2 = shmget(*(tcases[i].skey), 0, 0);
+			if (shm_id_2 != -1)
+				shmctl(shm_id_2, IPC_RMID, NULL);
+		}
 
-			TEST(shmget(*(TC[i].skey), TC[i].size_coe * shm_size,
-				    TC[i].flags));
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "shmget succeeded "
-					 "unexpectedly");
-				continue;
-			}
-			if (TEST_ERRNO == TC[i].error)
-				tst_resm(TPASS | TTERRNO, "shmget failed "
-					 "as expected");
-			else
-				tst_resm(TFAIL | TTERRNO, "shmget failed "
-					 "unexpectedly - expect errno=%d, "
-					 "got", TC[i].error);
+		TEST(shmget(*(tcases[i].skey), tcases[i].size_coe * shm_size,
+					tcases[i].flags));
+		if (TEST_RETURN != -1) {
+			tst_res(TFAIL, "shmget succeeded "
+					"unexpectedly");
+			continue;
 		}
+		if (TEST_ERRNO == tcases[i].error)
+			tst_res(TPASS | TTERRNO, "shmget failed "
+					"as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "shmget failed "
+					"unexpectedly - expect errno=%d, "
+					"got", tcases[i].error);
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
 	shmkey2 = shmkey + 1;
 	shm_id_1 = shmget(shmkey, shm_size, IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #setup");
-
-	TEST_PAUSE;
+		tst_brk(TBROK | TERRNO, "shmget #setup");
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
+	.tid = "hugeshmget02",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmget,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 402313a..00a895e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
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
- *	hugeshmget03.c
- *
  * DESCRIPTION
  *	hugeshmget03 - test for ENOSPC error
  *
@@ -35,29 +28,13 @@
  *	    issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmget03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *
- * RESTRICTIONS
- *	none
  */
 
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmget03";
-int TST_TOTAL = 1;
+#include "hugetlb.h"
 
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
@@ -73,57 +50,41 @@ static int shm_id_arr[MAXIDS];
 
 static long hugepages = 128;
 static long orig_shmmni;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
-int main(int ac, char **av)
+static void test_hugeshmget(void)
 {
-	int lc;
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
-		TEST(shmget(IPC_PRIVATE, shm_size,
-			    SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "shmget succeeded unexpectedly");
-			continue;
-		}
-		if (TEST_ERRNO == ENOSPC)
-			tst_resm(TPASS | TTERRNO, "shmget failed as expected");
-		else
-			tst_resm(TFAIL | TTERRNO, "shmget failed unexpectedly "
-				 "- expect errno=ENOSPC, got");
+	TEST(shmget(IPC_PRIVATE, shm_size,
+				SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "shmget succeeded unexpectedly");
+		return;
 	}
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == ENOSPC)
+		tst_res(TPASS | TTERRNO, "shmget failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "shmget failed unexpectedly "
+				"- expect errno=ENOSPC, got");
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
-	SAFE_FILE_SCANF(NULL, PATH_SHMMNI, "%ld", &orig_shmmni);
+	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
 
 	set_sys_tune("nr_hugepages", hugepages, 1);
-	SAFE_FILE_PRINTF(NULL, PATH_SHMMNI, "%ld", hugepages / 2);
+	SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", hugepages / 2);
 
-	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	shm_size = hpage_size;
 
 	/*
@@ -136,7 +97,7 @@ void setup(void)
 	while (shm_id_1 != -1) {
 		shm_id_arr[num_shms++] = shm_id_1;
 		if (num_shms == MAXIDS)
-			tst_brkm(TBROK, cleanup, "The maximum number of "
+			tst_brk(TBROK, "The maximum number of "
 				 "shared memory ID's has been reached. "
 				 "Please increase the MAXIDS value in "
 				 "the test.");
@@ -144,12 +105,10 @@ void setup(void)
 				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	}
 	if (errno != ENOSPC)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #setup");
-
-	TEST_PAUSE;
+		tst_brk(TBROK | TERRNO, "shmget #setup");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int i;
 
@@ -158,6 +117,13 @@ void cleanup(void)
 
 	FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmget03",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmget,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 1a96c3c..994b294 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
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
- *	hugeshmget05.c
- *
  * DESCRIPTION
  *	hugeshmget05 - test for EACCES error
  *
@@ -41,31 +34,13 @@
  *	  wait for child to exit
  *	  remove the shared memory segment
  *
- * USAGE:  <for command-line>
- *  hugeshmget05 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
- *
- * RESTRICTIONS
- *	test must be run at root
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "hugetlb.h"
-#include "safe_macros.h"
 #include "mem.h"
-
-char *TCID = "hugeshmget05";
-int TST_TOTAL = 1;
+#include "hugetlb.h"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -73,95 +48,83 @@ static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
 static long hugepages = 128;
-static option_t options[] = {
-	{"s:", &sflag, &nr_opt},
+static struct tst_option options[] = {
+	{"s:", &nr_opt, "-s   num  Set the number of the been allocated hugepages"},
 	{NULL, NULL, NULL}
 };
 
 static void do_child(void);
 
-int main(int ac, char **av)
+static void test_hugeshmget(void)
 {
 	pid_t pid;
 	int status;
 
-	tst_parse_opts(ac, av, options, NULL);
-
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
 	switch (pid = fork()) {
 	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		tst_brk(TBROK | TERRNO, "fork");
 	case 0:
 		/* set the user ID of the child to the non root user */
 		if (setuid(ltp_uid) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "setuid");
+			tst_brk(TBROK | TERRNO, "setuid");
 		do_child();
-		tst_exit();
+		exit(0);
 	default:
 		/* wait for the child to return */
 		if (waitpid(pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK | TERRNO, "waitpid");
 	}
-	cleanup();
-	tst_exit();
 }
 
 static void do_child(void)
 {
-	int lc;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		TEST(shmget(shmkey, shm_size, SHM_HUGETLB | SHM_RW));
-		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "shmget succeeded unexpectedly");
-			continue;
-		}
-		if (TEST_ERRNO == EACCES)
-			tst_resm(TPASS | TTERRNO, "shmget failed as expected");
-		else
-			tst_resm(TFAIL | TTERRNO, "shmget failed unexpectedly "
-				 "- expect errno=EACCES, got");
+	TEST(shmget(shmkey, shm_size, SHM_HUGETLB | SHM_RW));
+	if (TEST_RETURN != -1) {
+		tst_res(TFAIL, "shmget succeeded unexpectedly");
+		return;
 	}
+	if (TEST_ERRNO == EACCES)
+		tst_res(TPASS | TTERRNO, "shmget failed as expected");
+	else
+		tst_res(TFAIL | TTERRNO, "shmget failed unexpectedly "
+				"- expect errno=EACCES, got");
 }
 
 void setup(void)
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
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #setup");
+		tst_brk(TBROK | TERRNO, "shmget #setup");
 
 	/* get the userid for a non-root user */
-	ltp_uid = getuserid(cleanup, ltp_user);
-
-	TEST_PAUSE;
+	ltp_uid = getuserid(ltp_user);
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
+	.tid = "hugeshmget05",
+	.needs_root = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmget,
+};
-- 
2.9.3

