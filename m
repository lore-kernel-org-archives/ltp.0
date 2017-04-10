From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:51 +0800
Subject: [LTP] [PATCH V2 09/14] mem/hugeshmctl: convert to new API
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-10-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   | 211 +++++++++------------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   | 153 ++++++---------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   | 152 ++++++---------
 3 files changed, 210 insertions(+), 306 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index a54077a..17ef0b0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -1,27 +1,19 @@
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
- *	hugeshmctl01.c
- *
  * DESCRIPTION
  *	hugeshmctl01 - test the IPC_STAT, IPC_SET and IPC_RMID commands as
  *		   they are used with shmctl()
@@ -44,31 +36,14 @@
  *	    issue a PASS message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmctl01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
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
 
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
 
-char *TCID = "hugeshmctl01";
-int TST_TOTAL = 4;
-
 #define FIRST		0
 #define SECOND		1
 #define N_ATTACH	4
@@ -92,67 +67,54 @@ static void func_rmid(void);
 static void *set_shmat(void);
 
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
 	int cmd;
 	void (*func_test) (void);
 	void (*func_setup) (void);
-} TC[] = {
-	{
-	IPC_STAT, func_stat, stat_setup}, {
-	IPC_STAT, func_stat, stat_setup}, {
-	IPC_SET, func_set, set_setup}, {
-	IPC_RMID, func_rmid, NULL}
+} tcases[] = {
+	{IPC_STAT, func_stat, stat_setup},
+	{IPC_STAT, func_stat, stat_setup},
+	{IPC_SET,  func_set,  set_setup},
+	{IPC_RMID, func_rmid, NULL}
 };
 
-int main(int ac, char **av)
+static void test_hugeshmctl(void)
 {
-	int lc, i;
+	unsigned int i;
 
-	tst_parse_opts(ac, av, options, NULL);
+	/* initialize stat_time */
+	stat_time = FIRST;
 
-	if (sflag)
-		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		/* initialize stat_time */
-		stat_time = FIRST;
+	/*
+	 * Create a shared memory segment with read and write
+	 * permissions.  Do this here instead of in setup()
+	 * so that looping (-i) will work correctly.
+	 */
+	shm_id_1 = shmget(shmkey, shm_size,
+			SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
+	if (shm_id_1 == -1)
+		tst_brk(TBROK | TERRNO, "shmget #main");
 
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
 		/*
-		 * Create a shared memory segment with read and write
-		 * permissions.  Do this here instead of in setup()
-		 * so that looping (-i) will work correctly.
+		 * if needed, set up any required conditions by
+		 * calling the appropriate setup function
 		 */
-		shm_id_1 = shmget(shmkey, shm_size,
-				  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
-		if (shm_id_1 == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "shmget #main");
+		if (tcases[i].func_setup != NULL)
+			(*tcases[i].func_setup) ();
 
-		for (i = 0; i < TST_TOTAL; i++) {
-			/*
-			 * if needed, set up any required conditions by
-			 * calling the appropriate setup function
-			 */
-			if (TC[i].func_setup != NULL)
-				(*TC[i].func_setup) ();
-
-			if (shmctl(shm_id_1, TC[i].cmd, &buf) == -1) {
-				tst_resm(TFAIL | TERRNO, "shmctl #main");
-				continue;
-			}
-			(*TC[i].func_test) ();
+		if (shmctl(shm_id_1, tcases[i].cmd, &buf) == -1) {
+			tst_res(TFAIL | TERRNO, "shmctl #main");
+			continue;
 		}
+		(*tcases[i].func_test) ();
 	}
-	cleanup();
-	tst_exit();
 }
 
 /*
@@ -166,7 +128,7 @@ void *set_shmat(void)
 
 	rval = shmat(shm_id_1, 0, 0);
 	if (rval == (void *)-1)
-		tst_brkm(TBROK | TERRNO, cleanup, "set shmat");
+		tst_brk(TBROK | TERRNO, "set shmat");
 
 	return rval;
 }
@@ -182,7 +144,15 @@ static void stat_setup(void)
 	void *test;
 	pid_t pid;
 	sigset_t newmask, oldmask;
-
+	struct sigaction sa;
+
+	memset (&sa, '\0', sizeof(sa));
+	sa.sa_handler = sighandler;
+	sa.sa_flags = 0;
+	TEST(sigaction(SIGUSR1, &sa, NULL));
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TRERRNO,
+				"SIGSEGV signal setup failed");
 	/*
 	 * The first time through, let the children attach the memory.
 	 * The second time through, attach the memory first and let
@@ -210,12 +180,10 @@ static void stat_setup(void)
 	sigemptyset(&newmask);
 	sigaddset(&newmask, SIGUSR1);
 	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "block SIGUSR1 error");
+		tst_brk(TBROK | TERRNO, "block SIGUSR1 error");
 
 	for (i = 0; i < N_ATTACH; i++) {
-		switch (pid = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		switch (pid = SAFE_FORK()) {
 		case 0:
 			test = (stat_time == FIRST) ? set_shmat() : set_shared;
 
@@ -229,19 +197,19 @@ static void stat_setup(void)
 			 */
 			rval = sigsuspend(&oldmask);
 			if (rval != -1)
-				tst_brkm(TBROK | TERRNO, cleanup, "sigsuspend");
+				tst_brk(TBROK | TERRNO, "sigsuspend");
 
 			/*
 			 * don't have to block SIGUSR1 any more,
 			 * recover the mask
 			 */
 			if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-				tst_brkm(TBROK | TERRNO, cleanup,
+				tst_brk(TBROK | TERRNO,
 					 "child sigprocmask");
 
 			/* now we're back - detach the memory and exit */
 			if (shmdt(test) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
+				tst_brk(TBROK | TERRNO,
 					 "shmdt in stat_setup()");
 			exit(0);
 		default:
@@ -252,7 +220,7 @@ static void stat_setup(void)
 
 	/* parent doesn't have to block SIGUSR1, recover the mask */
 	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		tst_brkm(TBROK, cleanup, "parent sigprocmask");
+		tst_brk(TBROK, "parent sigprocmask");
 
 	usleep(250000);
 }
@@ -270,12 +238,12 @@ static void func_stat(void)
 	pid = getpid();
 
 	if (buf.shm_cpid != pid) {
-		tst_resm(TFAIL, "creator pid is incorrect");
+		tst_res(TFAIL, "creator pid is incorrect");
 		goto fail;
 	}
 
 	if (buf.shm_segsz != shm_size) {
-		tst_resm(TFAIL, "segment size is incorrect");
+		tst_res(TFAIL, "segment size is incorrect");
 		goto fail;
 	}
 
@@ -286,18 +254,18 @@ static void func_stat(void)
 	 * that memory so the attaches equal N_ATTACH + stat_time (1).
 	 */
 	if (buf.shm_nattch != N_ATTACH + stat_time) {
-		tst_resm(TFAIL, "# of attaches is incorrect - %lu",
+		tst_res(TFAIL, "# of attaches is incorrect - %lu",
 			 (unsigned long)buf.shm_nattch);
 		goto fail;
 	}
 
 	/* use MODE_MASK to make sure we are comparing the last 9 bits */
 	if ((buf.shm_perm.mode & MODE_MASK) != ((SHM_RW) & MODE_MASK)) {
-		tst_resm(TFAIL, "segment mode is incorrect");
+		tst_res(TFAIL, "segment mode is incorrect");
 		goto fail;
 	}
 
-	tst_resm(TPASS, "pid, size, # of attaches and mode are correct "
+	tst_res(TPASS, "pid, size, # of attaches and mode are correct "
 		 "- pass #%d", stat_time);
 
 fail:
@@ -319,15 +287,21 @@ static void stat_cleanup(void)
 	/* wake up the childern so they can detach the memory and exit */
 	for (i = 0; i < N_ATTACH; i++)
 		if (kill(pid_arr[i], SIGUSR1) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill with SIGUSR1");
+			tst_brk(TBROK | TERRNO, "kill with SIGUSR1");
 
 	/* remove the parent's shared memory the second time through */
 	if (stat_time == SECOND)
 		if (shmdt(set_shared) == -1)
-			tst_resm(TBROK | TERRNO, "shmdt in stat_cleanup()");
+			tst_res(TBROK | TERRNO, "shmdt in stat_cleanup()");
 	stat_time++;
 }
 
+static void sighandler(int sig)
+{
+	if (sig != SIGUSR1)
+		tst_res(TFAIL, "received unexpected signal %d", sig);
+}
+
 /*
  * set_setup() - set up for the IPC_SET command with shmctl()
  */
@@ -347,21 +321,21 @@ static void func_set(void)
 {
 	/* first stat the shared memory to get the new data */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-		tst_resm(TBROK | TERRNO, "shmctl in func_set()");
+		tst_res(TBROK | TERRNO, "shmctl in func_set()");
 		return;
 	}
 
 	if ((buf.shm_perm.mode & MODE_MASK) != ((SHM_RW | NEWMODE) & MODE_MASK)) {
-		tst_resm(TFAIL, "new mode is incorrect");
+		tst_res(TFAIL, "new mode is incorrect");
 		return;
 	}
 
 	if (save_time >= buf.shm_ctime) {
-		tst_resm(TFAIL, "change time is incorrect");
+		tst_res(TFAIL, "change time is incorrect");
 		return;
 	}
 
-	tst_resm(TPASS, "new mode and change time are correct");
+	tst_res(TPASS, "new mode and change time are correct");
 }
 
 /*
@@ -371,48 +345,47 @@ static void func_rmid(void)
 {
 	/* Do another shmctl() - we should get EINVAL */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1)
-		tst_brkm(TBROK, cleanup, "shmctl in func_rmid() "
+		tst_brk(TBROK, "shmctl in func_rmid() "
 			 "succeeded unexpectedly");
 	if (errno != EINVAL)
-		tst_resm(TFAIL | TERRNO, "shmctl in func_rmid() failed "
+		tst_res(TFAIL | TERRNO, "shmctl in func_rmid() failed "
 			 "unexpectedly - expect errno=EINVAL, got");
 	else
-		tst_resm(TPASS, "shmctl in func_rmid() failed as expected, "
+		tst_res(TPASS, "shmctl in func_rmid() failed as expected, "
 			 "shared memory appears to be removed");
 	shm_id_1 = -1;
 }
 
-static void sighandler(int sig)
-{
-	if (sig != SIGUSR1)
-		tst_resm(TFAIL, "received unexpected signal %d", sig);
-}
-
 void setup(void)
 {
 	long hpage_size;
 
-	tst_require_root();
 	check_hugepage();
-	tst_sig(FORK, sighandler, cleanup);
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
-
-	TEST_PAUSE;
+	shmkey = getipckey();
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
+	.tid = "hugeshmctl01",
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmctl,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index f5ae366..488cff5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
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
- *	hugeshmctl02.c
- *
  * DESCRIPTION
  *	hugeshmctl02 - check for EACCES, EFAULT and EINVAL errors
  *
@@ -35,32 +28,14 @@
  *	    issue a FAIL message
  *	call cleanup
  *
- * USAGE:  <for command-line>
- *  hugeshmctl02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
 
-#include <pwd.h>
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
 
-char *TCID = "hugeshmctl02";
-int TST_TOTAL = 4;
-
 static size_t shm_size;
 static int shm_id_1 = -1;
 static int shm_id_2 = -1;
@@ -68,101 +43,91 @@ static int shm_id_3 = -1;
 static struct shmid_ds buf;
 
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
 	int cmd;
 	struct shmid_ds *sbuf;
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* EFAULT - IPC_SET & buf isn't valid */
-	{
-	&shm_id_2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
-	    /* EFAULT - IPC_STAT & buf isn't valid */
-	{
-	&shm_id_2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
-	    /* EINVAL - the shmid is not valid */
-	{
-	&shm_id_3, IPC_STAT, &buf, EINVAL},
-	    /* EINVAL - the command is not valid */
-	{
-&shm_id_2, -1, &buf, EINVAL},};
-
-int main(int ac, char **av)
+	{&shm_id_2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
+	/* EFAULT - IPC_STAT & buf isn't valid */
+	{&shm_id_2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
+	/* EINVAL - the shmid is not valid */
+	{&shm_id_3, IPC_STAT, &buf, EINVAL},
+	/* EINVAL - the command is not valid */
+	{&shm_id_2, -1, &buf, EINVAL},
+};
+
+static void test_hugeshmctl(void)
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
-			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "shmctl succeeded "
-					 "unexpectedly");
-				continue;
-			}
-			if (TEST_ERRNO == TC[i].error)
-				tst_resm(TPASS | TTERRNO, "shmctl failed "
-					 "as expected");
-			else
-				tst_resm(TFAIL | TTERRNO, "shmctl failed "
-					 "unexpectedly - expect errno = "
-					 "%d, got", TC[i].error);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		TEST(shmctl(*(tcases[i].shmid), tcases[i].cmd, tcases[i].sbuf));
+		if (TEST_RETURN != -1) {
+			tst_res(TFAIL, "shmctl succeeded "
+					"unexpectedly");
+			continue;
+		}
+		if (TEST_ERRNO == tcases[i].error) {
+			tst_res(TPASS | TTERRNO, "shmctl failed "
+					"as expected");
+		} else {
+			tst_res(TFAIL | TTERRNO, "shmctl failed "
+					"unexpectedly - expect errno = "
+					"%d, got", tcases[i].error);
 		}
 	}
-	cleanup();
-	tst_exit();
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
 
 	/* create a shared memory segment without read or write permissions */
 	shm_id_1 = shmget(shmkey, shm_size, SHM_HUGETLB | IPC_CREAT | IPC_EXCL);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #1");
+		tst_brk(TBROK | TERRNO, "shmget #1");
 
 	/* create a shared memory segment with read and write permissions */
 	shm_id_2 = shmget(shmkey + 1, shm_size,
 			  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_2 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #2");
-
-	TEST_PAUSE;
+		tst_brk(TBROK | TERRNO, "shmget #2");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
-
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
-
-	tst_rmdir();
 }
+
+static struct tst_test test = {
+	.tid = "hugeshmctl02",
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmctl,
+};
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index bb2b7e7..e3abba1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
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
- *	hugeshmctl03.c
- *
  * DESCRIPTION
  *	hugeshmctl03 - check for EACCES, and EPERM errors
  *
@@ -41,15 +34,6 @@
  *	  wait for child to exit
  *	  remove the large shared memory segment
  *
- * USAGE:  <for command-line>
- *  hugeshmctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
@@ -58,16 +42,9 @@
  *	test must be run as root
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
-#include "test.h"
-#include "safe_macros.h"
 #include "mem.h"
 #include "hugetlb.h"
 
-char *TCID = "hugeshmctl03";
-int TST_TOTAL = 3;
-
 static size_t shm_size;
 static int shm_id_1 = -1;
 static struct shmid_ds buf;
@@ -75,80 +52,64 @@ static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
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
 	int cmd;
 	struct shmid_ds *sbuf;
 	int error;
-} TC[] = {
+} tcases[] = {
 	/* EACCES - child has no read permission for segment */
-	{
-	&shm_id_1, IPC_STAT, &buf, EACCES},
-	    /* EPERM - IPC_SET - child doesn't have permission to change segment */
-	{
-	&shm_id_1, IPC_SET, &buf, EPERM},
-	    /* EPERM - IPC_RMID - child can not remove the segment */
-	{
-&shm_id_1, IPC_RMID, &buf, EPERM},};
+	{&shm_id_1, IPC_STAT, &buf, EACCES},
+	/* EPERM - IPC_SET - child doesn't have permission to change segment */
+	{&shm_id_1, IPC_SET, &buf, EPERM},
+	/* EPERM - IPC_RMID - child can not remove the segment */
+	{&shm_id_1, IPC_RMID, &buf, EPERM},
+};
 
 static void do_child(void);
 
-int main(int ac, char **av)
+static void test_hugeshmctl(void)
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
-	switch (pid = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+	switch (pid = SAFE_FORK()) {
 	case 0:
-		/* set  the user ID of the child to the non root user */
+		/* set the user ID of the child to the non root user */
 		if (setuid(ltp_uid) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "setuid");
+			tst_brk(TBROK | TERRNO, "setuid");
 		do_child();
-		tst_exit();
+		exit(0);
 	default:
 		if (waitpid(pid, &status, 0) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+			tst_brk(TBROK | TERRNO, "waitpid");
 	}
-	cleanup();
-	tst_exit();
 }
 
 static void do_child(void)
 {
-	int i, lc;
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "shmctl succeeded "
-					 "unexpectedly");
-				continue;
-			}
-			if (TEST_ERRNO == TC[i].error)
-				tst_resm(TPASS | TTERRNO, "shmctl failed "
-					 "as expected");
-			else
-				tst_resm(TFAIL | TTERRNO, "shmctl failed "
-					 "unexpectedly - expect errno = "
-					 "%d, got", TC[i].error);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
+		TEST(shmctl(*(tcases[i].shmid), tcases[i].cmd, tcases[i].sbuf));
+		if (TEST_RETURN != -1) {
+			tst_res(TFAIL, "shmctl succeeded "
+					"unexpectedly");
+			continue;
 		}
+		if (TEST_ERRNO == tcases[i].error)
+			tst_res(TPASS | TTERRNO, "shmctl failed "
+					"as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "shmctl failed "
+					"unexpectedly - expect errno = "
+					"%d, got", tcases[i].error);
 	}
 }
 
@@ -156,34 +117,39 @@ void setup(void)
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
 			  SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
 	if (shm_id_1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget");
+		tst_brk(TBROK | TERRNO, "shmget");
 
 	/* get the userid for a non root user */
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
+	.tid = "hugeshmctl03",
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_hugeshmctl,
+};
-- 
2.9.3

