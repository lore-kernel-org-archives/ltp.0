From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Jun 2017 10:30:59 +0800
Subject: [LTP] [PATCH v3] syscalls/shmat0*: cleanup && convert to new API
In-Reply-To: <20170629161411.GD3233@rei.suse.de>
References: <20170629161411.GD3233@rei.suse.de>
Message-ID: <1498789859-6553-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) move shmat_common.h into libnewipc
2) take use of IPC related macros
3) merge shmat03 into shmat02

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/ltplite                                    |   1 -
 runtest/stress.part3                               |   1 -
 runtest/syscalls                                   |   1 -
 runtest/syscalls-ipc                               |   1 -
 testcases/kernel/syscalls/.gitignore               |   1 -
 .../kernel/syscalls/ipc/libnewipc/libnewipc.c      |  30 +++
 .../kernel/syscalls/ipc/libnewipc/libnewipc.h      |   4 +
 testcases/kernel/syscalls/ipc/shmat/Makefile       |   2 +-
 testcases/kernel/syscalls/ipc/shmat/shmat01.c      | 287 ++++++++-------------
 testcases/kernel/syscalls/ipc/shmat/shmat02.c      | 245 +++++++-----------
 testcases/kernel/syscalls/ipc/shmat/shmat03.c      | 184 -------------
 testcases/kernel/syscalls/ipc/shmat/shmat_common.h |  33 ---
 12 files changed, 232 insertions(+), 558 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat03.c
 delete mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat_common.h

diff --git a/runtest/ltplite b/runtest/ltplite
index 8b7b4b9..5418495 100644
--- a/runtest/ltplite
+++ b/runtest/ltplite
@@ -821,7 +821,6 @@ setuid04 setuid04
 
 shmat01 shmat01
 shmat02 shmat02
-shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/runtest/stress.part3 b/runtest/stress.part3
index 3fffa22..242b696 100644
--- a/runtest/stress.part3
+++ b/runtest/stress.part3
@@ -711,7 +711,6 @@ setuid04 setuid04
 
 shmat01 shmat01
 shmat02 shmat02
-shmat03 shmat03
 
 shmctl02 shmctl02
 shmctl03 shmctl03
diff --git a/runtest/syscalls b/runtest/syscalls
index 63c8d27..91aba85 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1159,7 +1159,6 @@ setxattr03 setxattr03
 
 shmat01 shmat01
 shmat02 shmat02
-shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
index 91060b9..de32c6b 100644
--- a/runtest/syscalls-ipc
+++ b/runtest/syscalls-ipc
@@ -52,7 +52,6 @@ semop05 semop05
 
 shmat01 shmat01
 shmat02 shmat02
-shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index 1410f0f..3d9bb75 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -442,7 +442,6 @@
 /ipc/semop/semop05
 /ipc/shmat/shmat01
 /ipc/shmat/shmat02
-/ipc/shmat/shmat03
 /ipc/shmctl/shmctl01
 /ipc/shmctl/shmctl02
 /ipc/shmctl/shmctl03
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
index 8ea421f..ac50fdd 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
@@ -26,6 +26,8 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/ipc.h>
+#include <sys/msg.h>
+#include <sys/shm.h>
 
 #define	TST_NO_DEFAULT_MAIN
 
@@ -79,3 +81,31 @@ int get_used_queues(const char *file, const int lineno)
 
 	return used_queues;
 }
+
+void *probe_free_addr(const char *file, const int lineno)
+{
+	void *addr;
+	int shm_id = -1;
+	key_t probe_key = 0;
+
+	if (!probe_key)
+		probe_key = GETIPCKEY();
+
+	shm_id = shmget(probe_key, SHMLBA * 2, SHM_RW | IPC_CREAT | IPC_EXCL);
+	if (shm_id == -1)
+		tst_brk(TBROK, "probe: shmget() failed at %s:%d", file, lineno);
+
+	addr = shmat(shm_id, NULL, 0);
+	if (addr == (void *) -1)
+		tst_brk(TBROK, "probe: shmat() failed at %s:%d", file, lineno);
+
+	if (shmdt(addr) == -1)
+		tst_brk(TBROK, "probe: shmdt() failed at %s:%d", file, lineno);
+
+	if (shmctl(shm_id, IPC_RMID, NULL) == -1)
+		tst_brk(TBROK, "probe: shmctl() failed at %s:%d", file, lineno);
+
+	addr = (void *)(((unsigned long)(addr) + (SHMLBA - 1)) & ~(SHMLBA - 1));
+
+	return addr;
+}
diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
index 39148be..660be80 100644
--- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
+++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
@@ -50,4 +50,8 @@ int get_used_queues(const char *file, const int lineno);
 #define GET_USED_QUEUES() \
 	get_used_queues(__FILE__, __LINE__)
 
+void *probe_free_addr(const char *file, const int lineno);
+#define PROBE_FREE_ADDR() \
+	probe_free_addr(__FILE__, __LINE__)
+
 #endif /* newlibipc.h */
diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
index f467389..f9ee8d2 100644
--- a/testcases/kernel/syscalls/ipc/shmat/Makefile
+++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
@@ -19,5 +19,5 @@
 top_srcdir              ?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(abs_srcdir)/../Makefile.inc
+include $(abs_srcdir)/../Makefile2.inc
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 6de1872..0ea4075 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -17,225 +17,144 @@
  */
 
 /*
- * NAME
- *	shmat01.c
- *
  * DESCRIPTION
- *	shmat01 - test that shmat() works correctly
  *
- * ALGORITHM
- *	create a shared memory resouce with read/write permissions
- *	loop if that option was specified
- *	call shmat() with the TEST() macro using three valid conditions
- *	check the return code
- *	  if failure, issue a FAIL message.
- *	otherwise,
- *	  if doing functionality testing
- *		check for the correct conditions after the call
- *		if correct,
- *			issue a PASS message
- *		otherwise
- *			issue a FAIL message
- *	call cleanup
+ * 1) shmat() chooses a suitable (unused) address when shmaddr is NULL.
+ * 2) shmat() attaches shm segment to the shmaddr when shmaddr is a
+ *    page-aligned address.
+ * 3) shmat() attaches shm segment to the address equal to shmaddr rounded
+ *    down to the nearest multiple of SHMLBA when shmaddr is a page-unaligned
+ *    address and shmflg is set to SHM_RND.
+ * 4) shmat() attaches shm segment to the shmaddr for reading when shmflg
+ *    is set to SHM_RDONLY.
  */
 
-#include "ipcshm.h"
-#include "shmat_common.h"
-
-#define CASE0		10
-#define CASE1		20
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+#include <stdlib.h>
 
-char *TCID = "shmat01";
-int TST_TOTAL = 4;
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-int shm_id_1 = -1;
+#define ALIGN_DOWN(in_addr) ((void *)(((intptr_t)in_addr / SHMLBA) * SHMLBA))
 
-/*
- * By probing this address first, we can make
- * non-aligned addresses from it for different
- * architectures without explicitly code it.
- */
-void *base_addr;
-void *addr;
+static int shm_id = -1;
+static key_t shm_key;
+static void *null_addr;
+static void *aligned_addr;
+static void *unaligned_addr;
 
 static struct test_case_t {
-	int *shmid;
-	int offset;
-	int flags;
-	int getbase;
-} *TC;
-
-static void check_functionality(int);
-
-int main(int argc, char *argv[])
+	void **shmaddr;
+	int flag;
+	int exp_status;
+	char *desp;
+} tcases[] = {
+	{&null_addr, 0, 0, "NULL address"},
+	{&aligned_addr, 0, 0, "aligned address"},
+	{&unaligned_addr, SHM_RND, 0, "unaligned address with SHM_RND"},
+	{&aligned_addr, SHM_RDONLY, SIGSEGV,
+	"aligned address with SHM_READONLY, and got SIGSEGV on write"}
+};
+
+static void *expected_addr(void *in_addr, void *out_addr)
 {
-	int lc, i;
-	void *attchaddr;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
+	if (!in_addr)
+		return out_addr;
 
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			if (TC[i].getbase) {
-				base_addr = probe_free_addr();
-				attchaddr = base_addr + TC[i].offset;
-			} else {
-				attchaddr = NULL;
-			}
+	return ALIGN_DOWN(in_addr);
+}
 
-			addr = shmat(*(TC[i].shmid), attchaddr, TC[i].flags);
+static void do_child(int *in_addr)
+{
+	*in_addr = 10;
 
-			TEST_ERRNO = errno;
-			if (addr == (void *)-1) {
-				tst_brkm(TFAIL | TTERRNO, cleanup,
-					 "shmat call failed");
-			} else {
-				check_functionality(i);
-			}
+	exit(0);
+}
 
-			if (shmdt(addr) == -1)
-				tst_brkm(TBROK, cleanup,
-					 "Couldn't detach shared memory");
-		}
-	}
+static int expected_status(int status, int exp_status)
+{
+	if (!exp_status && WIFEXITED(status))
+		return 0;
 
-	cleanup();
+	if (exp_status && WIFSIGNALED(status) && WTERMSIG(status) == exp_status)
+		return 0;
 
-	tst_exit();
+	return 1;
 }
 
-/*
- * check_functionality - check various conditions to make sure they
- *			 are correct.
- */
-static void check_functionality(int i)
+static void verify_shmat(unsigned int n)
 {
-	void *orig_add;
-	int *shared;
-	int fail = 0;
+	int *addr;
+	pid_t pid;
+	int status;
 	struct shmid_ds buf;
 
-	shared = (int *)addr;
+	struct test_case_t *tc = &tcases[n];
+
+	addr = shmat(shm_id, *tc->shmaddr, tc->flag);
+	if (addr == (void *)-1) {
+		tst_res(TFAIL | TERRNO, "shmat() failed");
+		return;
+	}
 
-	/* stat the shared memory ID */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
-		tst_brkm(TBROK, cleanup, "couldn't stat shared memory");
+	SAFE_SHMCTL(shm_id, IPC_STAT, &buf);
 
-	/* check the number of attaches */
 	if (buf.shm_nattch != 1) {
-		tst_resm(TFAIL, "# of attaches is incorrect");
-		return;
+		tst_res(TFAIL, "number of attaches was incorrect");
+		goto end;
 	}
 
-	/* check the size of the segment */
 	if (buf.shm_segsz != INT_SIZE) {
-		tst_resm(TFAIL, "segment size is incorrect");
-		return;
+		tst_res(TFAIL, "segment size was incorrect");
+		goto end;
 	}
 
-	/* check for specific conditions depending on the type of attach */
-	switch (i) {
-	case 0:
-	case 1:
-		/*
-		 * Check the functionality of shmat by simply "writing"
-		 * a value to the shared memory space.
-		 * If this fails the program will get a SIGSEGV, dump
-		 * core and exit.
-		 */
-
-		*shared = CASE0;
-		break;
-	case 2:
-		/*
-		 * Check the functionality of shmat by writing a value
-		 * to the shared memory space and then checking that
-		 * the original address given was rounded down as
-		 * specified in the man page.
-		 */
-
-		*shared = CASE1;
-		orig_add = addr + ((unsigned long)TC[2].offset % SHMLBA);
-		if (orig_add != base_addr + TC[2].offset) {
-			tst_resm(TFAIL, "shared memory address is not "
-				 "correct");
-			fail = 1;
-		}
-		break;
-	case 3:
-		/*
-		 * This time the shared memory is read only.  Read the value
-		 * and check that it is equal to the value set in last case,
-		 * because shared memory is persistent.
-		 */
-
-		if (*shared != CASE1) {
-			tst_resm(TFAIL, "shared memory value isn't correct");
-			fail = 1;
-		}
-		break;
+	if (expected_addr(*tc->shmaddr, addr) != addr) {
+		tst_res(TFAIL, "shared memory address was not correct");
+		goto end;
 	}
 
-	if (!fail)
-		tst_resm(TPASS, "conditions and functionality are correct");
-}
+	pid = SAFE_FORK();
+	if (!pid)
+		do_child(addr);
+	else
+		SAFE_WAITPID(pid, &status, 0);
 
-void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	TC = malloc(TST_TOTAL * sizeof(struct test_case_t));
-	if (TC == NULL)
-		tst_brkm(TFAIL | TERRNO, cleanup, "failed to allocate memory");
-
-	/* set NULL as attaching address*/
-	TC[0].shmid = &shm_id_1;
-	TC[0].offset = 0;
-	TC[0].flags = 0;
-	TC[0].getbase = 0;
-
-	/* a straight forward read/write attach */
-	TC[1].shmid = &shm_id_1;
-	TC[1].offset = 0;
-	TC[1].flags = 0;
-	TC[1].getbase = 1;
-
-	/* an attach using unaligned memory */
-	TC[2].shmid = &shm_id_1;
-	TC[2].offset = SHMLBA - 1;
-	TC[2].flags = SHM_RND;
-	TC[2].getbase = 1;
-
-	/* a read only attach */
-	TC[3].shmid = &shm_id_1;
-	TC[3].offset = 0;
-	TC[3].flags = SHM_RDONLY;
-	TC[3].getbase = 1;
-
-	tst_tmpdir();
-
-	shmkey = getipckey();
-
-	shm_id_1 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id_1 == -1)
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource 1 in setup()");
+	if (expected_status(status, tc->exp_status))
+		tst_res(TFAIL, "shmat() failed to attach %s", tc->desp);
+	else
+		tst_res(TPASS, "shmat() succeeded to attach %s", tc->desp);
+
+end:
+	SAFE_SHMDT(addr);
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	rm_shm(shm_id_1);
+	aligned_addr = PROBE_FREE_ADDR();
+	unaligned_addr = aligned_addr + SHMLBA - 1;
 
-	if (TC != NULL)
-		free(TC);
+	shm_key = GETIPCKEY();
 
-	tst_rmdir();
+	shm_id = SAFE_SHMGET(shm_key, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
 }
+
+static void cleanup(void)
+{
+	if (shm_id != -1)
+		SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_shmat,
+	.tcnt = ARRAY_SIZE(tcases)
+};
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
index d6355f7..83f785c 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
@@ -1,189 +1,132 @@
 /*
+ * Copyright (c) International Business Machines  Corp., 2001
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
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
  */
 
 /*
- * NAME
- *	shmat02.c
- *
  * DESCRIPTION
- *	shmat02 - check for EINVAL and EACCES errors
- *
- * ALGORITHM
- *	loop if that option was specified
- *	  call shmat() using three invalid test cases
- *	  check the errno value
- *	    issue a PASS message if we get EINVAL or EACCES
- *	  otherwise, the tests fails
- *	    issue a FAIL message
- *	call cleanup
- *
- * USAGE:  <for command-line>
- *  shmat02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
  *
- *      27/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
- *      - Fix concurrency issue. The second key used for this test could
- *        conflict with the key from another task.
- *
- * RESTRICTIONS
- *	Must be ran as non-root
+ * 1) shmat() fails and set errno to EINVAL when shmid is invalid.
+ * 2) shmat() fails and set errno to EINVAL when shmaddr is not page
+ *    aligned and SHM_RND is not given
+ * 3) shmat() fails and set errno to EACCES when the shm resource has
+ *    no read/write permission.
+ * 4) shmat() fails and set errno to EACCES when non-root user access
+ *    shm created by root.
  */
 
-#include "ipcshm.h"
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
 #include <pwd.h>
-#include "shmat_common.h"
-
-char *TCID = "shmat02";
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
 
-int shm_id_1 = -1;
-int shm_id_2 = -1;
-int shm_id_3 = -1;
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+#include "libnewipc.h"
 
-void *base_addr;		/* By probing this address first, we can make
-				 * non-aligned addresses from it for different
-				 * architectures without explicitly code it.
-				 */
+static int shm_id1 = -1;
+static int shm_id2 = -1;
+static int shm_id3 = -1;
+static void *aligned_addr;
+static void *unaligned_addr;
+static key_t shm_key1, shm_key2;
+static struct passwd *pw;
 
-void *addr;			/* for result of shmat-call */
-
-struct test_case_t {
+static struct test_case_t {
 	int *shmid;
-	int offset;
-	int error;
+	void **shmaddr;
+	int rw_flag;
+	int exp_err;
+	int exp_user;
+} tcases[] = {
+	{&shm_id1, &aligned_addr, 1, EINVAL, 0},
+	{&shm_id2, &unaligned_addr, 1, EINVAL, 0},
+	{&shm_id2, &aligned_addr, 1, EACCES, 1},
+	{&shm_id3, &aligned_addr, 0, EACCES, 1}
 };
 
-int TST_TOTAL = 3;
-
-static void setup_tc(int i, struct test_case_t *tc)
+static void verify_shmat(struct test_case_t *tc)
 {
+	void *addr;
 
-	struct test_case_t TC[] = {
-		/* EINVAL - the shared memory ID is not valid */
-		{&shm_id_1, 0, EINVAL},
-		/* EINVAL - the address is not page aligned and SHM_RND is not given */
-		{&shm_id_2, SHMLBA - 1, EINVAL},
-		/* EACCES - the shared memory resource has no read/write permission */
-		{&shm_id_3, 0, EACCES}
-	};
+	if (!tc->rw_flag)
+		shm_id3 = SAFE_SHMGET(shm_key2, INT_SIZE, IPC_CREAT | IPC_EXCL);
 
-	if (i > TST_TOTAL || i < 0)
+	addr = shmat(*tc->shmid, *tc->shmaddr, 0);
+	if (addr != (void *)-1) {
+		tst_res(TFAIL, "shmat() succeeded unexpectedly");
 		return;
+	}
+
+	if (errno == tc->exp_err) {
+		tst_res(TPASS | TERRNO, "shmat() failed as expected");
+	} else {
+		tst_res(TFAIL | TERRNO, "shmat() failed unexpectedly,"
+			 "expected: %s", tst_strerrno(tc->exp_err));
+	}
 
-	*tc = TC[i];
+	if (shm_id3 != -1)
+		SAFE_SHMCTL(shm_id3, IPC_RMID, NULL);
 }
 
-int main(int ac, char **av)
+static void do_shmat(unsigned int n)
 {
-	int lc;
-	int i;
-	struct test_case_t *tc;
-
-	tc = NULL;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	tc = malloc(sizeof(struct test_case_t));
-	if (tc == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc failed");
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++) {
-
-			setup_tc(i, tc);
-
-			base_addr = probe_free_addr();
-			errno = 0;
-			addr = shmat(*(tc->shmid), base_addr + tc->offset, 0);
-
-			if (addr != (void *)-1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			if (errno == tc->error)
-				tst_resm(TPASS | TERRNO,
-					 "shmat failed as expected");
-			else
-				tst_resm(TFAIL,
-					 "shmat failed unexpectedly; expected: "
-					 "%d - %s", tc->error,
-					 strerror(tc->error));
+	pid_t pid;
+
+	struct test_case_t *tc = &tcases[n];
+
+	if (tc->exp_user == 0) {
+		verify_shmat(tc);
+	} else {
+		pid = SAFE_FORK();
+		if (pid) {
+			tst_reap_children();
+		} else {
+			SAFE_SETUID(pw->pw_uid);
+			verify_shmat(tc);
+			exit(0);
 		}
 	}
-
-	cleanup();
-
-	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-	key_t shmkey2;
-
-	tst_require_root();
-	ltpuser = getpwnam(nobody_uid);
-	if (ltpuser == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid failed");
+	aligned_addr = PROBE_FREE_ADDR();
+	unaligned_addr = aligned_addr + SHMLBA - 1;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	shm_key1 = GETIPCKEY();
+	shm_key2 = GETIPCKEY();
 
-	TEST_PAUSE;
+	shm_id2 = SAFE_SHMGET(shm_key1, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
 
-	tst_tmpdir();
-
-	shmkey = getipckey();
-
-	shm_id_2 = shmget(shmkey, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id_2 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #1 failed");
-
-	/* Get an new IPC resource key. */
-	shmkey2 = getipckey();
-
-	/* create a shared memory resource without read and write permissions */
-	shm_id_3 = shmget(shmkey2, INT_SIZE, IPC_CREAT | IPC_EXCL);
-	if (shm_id_3 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "shmget #2 failed");
+	pw = SAFE_GETPWNAM("nobody");
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
-	/* if they exist, remove the shared memory resources */
-	rm_shm(shm_id_2);
-	rm_shm(shm_id_3);
-
-	tst_rmdir();
-
+	if (shm_id2 != -1)
+		SAFE_SHMCTL(shm_id2, IPC_RMID, NULL);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.test = do_shmat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup
+};
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
deleted file mode 100644
index 266ea1c..0000000
--- a/testcases/kernel/syscalls/ipc/shmat/shmat03.c
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
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
- */
-
-/*
- * NAME
- *	shmat03.c
- *
- * DESCRIPTION
- *	shmat03 - test for EACCES error
- *
- * ALGORITHM
- *	create a shared memory segment with root only read & write permissions
- *	fork a child process
- *	if child
- *	  set the ID of the child process to that of "nobody"
- *	  loop if that option was specified
- *	    call shmat() using the TEST() macro
- *	    check the errno value
- *	      issue a PASS message if we get EACCES
- *	    otherwise, the tests fails
- *	      issue a FAIL message
- *	  call cleanup
- *	if parent
- *	  wait for child to exit
- *	  remove the shared memory segment
- *
- * USAGE:  <for command-line>
- *  shmat03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	03/2001 - Written by Wayne Boyer
- *
- * RESTRICTIONS
- *	test must be run at root
- */
-
-#include "ipcshm.h"
-
-char *TCID = "shmat03";
-int TST_TOTAL = 1;
-
-int shm_id_1 = -1;
-
-void *addr;			/* for result of shmat-call */
-
-uid_t ltp_uid;
-char *ltp_user = "nobody";
-
-static void do_child(void);
-
-int main(int ac, char **av)
-{
-	int pid;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();		/* global setup */
-
-	pid = FORK_OR_VFORK();
-	if (pid == -1)
-		tst_brkm(TBROK, cleanup, "could not fork");
-
-	if (pid == 0) {		/* child */
-		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1) {
-			perror("setuid() failed");
-			exit(1);
-		}
-
-		do_child();
-
-	} else {		/* parent */
-		/* wait for the child to return */
-		if (waitpid(pid, NULL, 0) == -1)
-			tst_brkm(TBROK, cleanup, "waitpid failed");
-
-		/* if it exists, remove the shared memory resource */
-		rm_shm(shm_id_1);
-
-		tst_rmdir();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-/*
- * do_child - make the TEST call as the child process
- */
-static void do_child(void)
-{
-	int lc;
-
-	/* The following loop checks looping state if -i option given */
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset tst_count in case we are looping */
-		tst_count = 0;
-
-		/*
-		 * use TEST macro to make the call
-		 */
-		errno = 0;
-		addr = shmat(shm_id_1, NULL, 0);
-		TEST_ERRNO = errno;
-
-		if (addr != (char *)-1) {
-			tst_resm(TFAIL, "call succeeded unexpectedly");
-			continue;
-		}
-
-		switch (TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS | TTERRNO, "expected failure");
-			break;
-		default:
-			tst_resm(TFAIL | TTERRNO,
-				 "call failed with an unexpected error");
-			break;
-		}
-	}
-}
-
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
-	tst_tmpdir();
-
-	/* get an IPC resource key */
-	shmkey = getipckey();
-
-	/* create a shared memory segment with read and write permissions */
-	shm_id_1 = shmget(shmkey, SHM_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id_1 == -1)
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "segment in setup");
-
-	/* get the userid for a non root user */
-	ltp_uid = getuserid(ltp_user);
-}
-
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- *		or premature exit.
- */
-void cleanup(void)
-{
-
-}
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat_common.h b/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
deleted file mode 100644
index 06cf5ab..0000000
--- a/testcases/kernel/syscalls/ipc/shmat/shmat_common.h
+++ /dev/null
@@ -1,33 +0,0 @@
-static key_t probe_key;
-
-void *probe_free_addr(void)
-{
-	void *p;
-	int ret;
-	int shm_id = -1;
-
-	if (probe_key == 0)
-		probe_key = getipckey();
-
-	/* create a shared memory resource with read and write permissions
-	 * We align this to SHMLBA so we should allocate at least
-	 * SHMLBA*2 in case SHMLBA > page_size. */
-	shm_id = shmget(probe_key, SHMLBA*2, SHM_RW | IPC_CREAT | IPC_EXCL);
-	if (shm_id == -1)
-		tst_brkm(TBROK, cleanup, "probe: shmget failed");
-
-	/* Probe an available linear address for attachment */
-	p = shmat(shm_id, NULL, 0);
-	if (p == (void *)-1)
-		tst_brkm(TBROK, cleanup, "probe: shmat failed");
-	ret = shmdt(p);
-	if (ret == -1)
-		tst_brkm(TBROK, cleanup, "probe: shmdt failed");
-
-	rm_shm(shm_id);
-
-	/* some architectures (e.g. parisc) are strange, so better always
-	 * align to next SHMLBA address. */
-	p = (void *)(((unsigned long)(p) + (SHMLBA - 1)) & ~(SHMLBA - 1));
-	return p;
-}
-- 
1.8.3.1



