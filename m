From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:41 +0200
Subject: [LTP] [COMMITTED] [PATCH 08/40] Make use of SAFE_SETEUID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-8-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/module/create_module/create_module02.c   |  6 ++----
 testcases/kernel/syscalls/adjtimex/adjtimex02.c           |  6 ++----
 testcases/kernel/syscalls/capset/capset02.c               |  5 ++---
 testcases/kernel/syscalls/chown/chown03.c                 | 10 +++-------
 testcases/kernel/syscalls/chroot/chroot01.c               |  7 +++----
 testcases/kernel/syscalls/chroot/chroot04.c               |  5 ++---
 testcases/kernel/syscalls/fchmod/fchmod03.c               |  4 ++--
 testcases/kernel/syscalls/ioperm/ioperm02.c               |  6 +++---
 testcases/kernel/syscalls/iopl/iopl02.c                   |  6 +++---
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c | 15 ++++-----------
 testcases/kernel/syscalls/mlockall/mlockall02.c           |  7 ++-----
 testcases/kernel/syscalls/mlockall/mlockall03.c           | 13 +++----------
 testcases/kernel/syscalls/move_pages/move_pages11.c       |  6 ++----
 testcases/kernel/syscalls/munlockall/munlockall02.c       |  6 ++----
 testcases/kernel/syscalls/readlink/readlink01.c           |  5 ++---
 testcases/kernel/syscalls/readlink/readlink04.c           |  7 +++----
 .../syscalls/sched_setscheduler/sched_setscheduler02.c    |  8 ++------
 testcases/kernel/syscalls/setns/setns01.c                 |  6 ++----
 testcases/kernel/syscalls/setregid/setregid03.c           |  4 ++--
 testcases/kernel/syscalls/sysctl/sysctl03.c               | 10 +++-------
 testcases/kernel/syscalls/syslog/syslog11.c               |  6 ++----
 testcases/kernel/syscalls/syslog/syslog12.c               |  6 ++----
 testcases/kernel/timers/clock_settime/clock_settime03.c   |  7 ++-----
 23 files changed, 55 insertions(+), 106 deletions(-)

diff --git a/testcases/kernel/module/create_module/create_module02.c b/testcases/kernel/module/create_module/create_module02.c
index ff28bf2b7..f275adfb6 100644
--- a/testcases/kernel/module/create_module/create_module02.c
+++ b/testcases/kernel/module/create_module/create_module02.c
@@ -91,6 +91,7 @@
 #include <asm/atomic.h>
 #include <linux/module.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #ifndef PAGE_SIZE
 #define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
@@ -210,10 +211,7 @@ int setup1(void)
 void cleanup1(void)
 {
 	/* Change effective user id to root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "seteuid failed to set the effective"
-			 " uid to root");
-	}
+	SAFE_SETEUID(NULL, 0);
 }
 
 int setup2(void)
diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index 493fe55c4..577387d92 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -91,6 +91,7 @@
 #include <unistd.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define SET_MODE ( ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
 	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK )
@@ -272,8 +273,5 @@ int setup6(void)
 void cleanup6(void)
 {
 	/* Set effective user id back to root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid failed to set the"
-			 " effective uid to root");
-	}
+	SAFE_SETEUID(cleanup, 0);
 }
diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index 381ab75f8..aece29511 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -81,6 +81,7 @@
 #include <string.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 
 /**************************************************************************/
@@ -251,9 +252,7 @@ void test_setup(int i, char *argv0)
 			if (ltpuser == NULL)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "getpwnam failed");
-			if (seteuid(ltpuser->pw_uid) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "seteuid failed");
+			SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 		}
 		break;
diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 4dba6c6f3..0ca1428b2 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -171,9 +171,7 @@ void setup(void)
 	if (ltpuser == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "getpwnam(\"nobody\") failed");
 	SAFE_SETEGID(NULL, ltpuser->pw_gid);
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "seteuid(%d) failed",
-			 ltpuser->pw_uid);
+	SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 	/* Create a test file under temporary directory */
 	if ((fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE)) == -1)
@@ -181,8 +179,7 @@ void setup(void)
 			 "open(%s, O_RDWR|O_CREAT, %o) failed", TESTFILE,
 			 FILE_MODE);
 
-	if (seteuid(0) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid(0) failed");
+	SAFE_SETEUID(cleanup, 0);
 
 	if (fchown(fd, -1, 0) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fchown failed");
@@ -190,8 +187,7 @@ void setup(void)
 	if (fchmod(fd, NEW_PERMS) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fchmod failed");
 
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid to nobody failed");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	SAFE_CLOSE(cleanup, fd);
 }
diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index 875c8c1cf..9b0c30cf1 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -47,6 +47,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <pwd.h>
 
 char *TCID = "chroot01";
@@ -98,8 +99,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "getpwnam(\"nobody\") failed");
 
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid to nobody failed");
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -108,8 +108,7 @@ void setup(void)
 
 void cleanup(void)
 {
-	if (seteuid(0) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid(0) failed");
+	SAFE_SETEUID(NULL, 0);
 
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index 254db0ca0..4bbdcd231 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -48,6 +48,7 @@
 #include <errno.h>
 #include <sys/stat.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <pwd.h>
 
 char *TCID = "chroot04";
@@ -114,9 +115,7 @@ void setup(void)
 	}
 
 	ltpuser = getpwnam(nobody_uid);
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK, cleanup, "seteuid to nobody failed");
-	}
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 }
 
diff --git a/testcases/kernel/syscalls/fchmod/fchmod03.c b/testcases/kernel/syscalls/fchmod/fchmod03.c
index a3e79b3e6..8d35bc1ef 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod03.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod03.c
@@ -80,6 +80,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define FILE_MODE       (S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define PERMS		01777
@@ -147,8 +148,7 @@ void setup(void)
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
+	SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/ioperm/ioperm02.c b/testcases/kernel/syscalls/ioperm/ioperm02.c
index a25531ec3..3d9b1445f 100644
--- a/testcases/kernel/syscalls/ioperm/ioperm02.c
+++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
@@ -77,6 +77,7 @@ char *TCID = "ioperm02";
 #include <sys/io.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define NUM_BYTES 3
 #define TURN_ON 1
@@ -179,9 +180,7 @@ int setup1(void)
 void cleanup1(void)
 {
 	/* reset user as root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to set uid as root");
-	}
+	SAFE_SETEUID(NULL, 0);
 }
 
 /* setup() - performs all ONE TIME setup for this test */
@@ -237,6 +236,7 @@ void cleanup(void)
 #else /* __i386__ */
 
 #include "test.h"
+#include "safe_macros.h"
 
 int TST_TOTAL = 0;
 
diff --git a/testcases/kernel/syscalls/iopl/iopl02.c b/testcases/kernel/syscalls/iopl/iopl02.c
index be3be1b25..35d239268 100644
--- a/testcases/kernel/syscalls/iopl/iopl02.c
+++ b/testcases/kernel/syscalls/iopl/iopl02.c
@@ -78,6 +78,7 @@ char *TCID = "iopl02";
 #include <sys/io.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define INVALID_LEVEL 4		/* Invalid privilege level */
 #define EXP_RET_VAL -1
@@ -175,9 +176,7 @@ int setup1(void)
 void cleanup1(void)
 {
 	/* reset user as root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "Failed to set uid as root");
-	}
+	SAFE_SETEUID(NULL, 0);
 }
 
 /* setup() - performs all ONE TIME setup for this test */
@@ -208,6 +207,7 @@ void cleanup(void)
 #else /* __i386__ */
 
 #include "test.h"
+#include "safe_macros.h"
 
 int TST_TOTAL = 0;
 
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 4b1126eaf..d18458972 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -207,9 +207,7 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 		testp[0] = 1;
 		testp2[0] = 1;
 		if (!cap_sys_nice)
-			if (seteuid(ltpuser->pw_uid) == -1)
-				tst_brkm(TBROK | TERRNO, NULL,
-					 "seteuid failed");
+			SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 		migrate_to_node(0, node1);
 		/* child can migrate non-shared memory */
@@ -266,8 +264,7 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 		migrate_to_node(0, node1);
 		check_addr_on_node(testp, node1);
 
-		if (seteuid(ltpuser->pw_uid) == -1)
-			tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
+		SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 		/* signal parent it's OK to migrate child and wait */
 		if (write(child_ready[1], &tmp, 1) != 1)
@@ -288,9 +285,7 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 		close(pages_migrated[0]);
 
 		if (!cap_sys_nice)
-			if (seteuid(ltpuser->pw_uid) == -1)
-				tst_brkm(TBROK | TERRNO, NULL,
-					 "seteuid failed");
+			SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 		/* wait until child is ready on node1, then migrate and
 		 * signal to check current node */
@@ -309,9 +304,7 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 
 		/* reset euid, so this testcase can be used in loop */
 		if (!cap_sys_nice)
-			if (seteuid(0) == -1)
-				tst_brkm(TBROK | TERRNO, NULL,
-					 "seteuid failed");
+			SAFE_SETEUID(NULL, 0);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index f1ec962d1..f2eca09c0 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -77,6 +77,7 @@
 #include <pwd.h>
 #include <sys/mman.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <sys/resource.h>
 
 void setup();
@@ -248,11 +249,7 @@ void cleanup_test(int i)
 		}
 		return;
 	case 1:
-		if (seteuid(0) == -1) {
-			tst_brkm(TBROK, cleanup, "seteuid() failed to "
-				 "change euid to %d errno = %d : %s",
-				 0, TEST_ERRNO, strerror(TEST_ERRNO));
-		}
+		SAFE_SETEUID(cleanup, 0);
 		return;
 
 	}
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 5bdbdd051..5e8e55648 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -79,6 +79,7 @@
 #include <ctype.h>
 #include <sys/mman.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <sys/resource.h>
 #include <sys/utsname.h>
 
@@ -267,11 +268,7 @@ void cleanup_test(int i)
 
 	switch (i) {
 	case 0:
-		if (seteuid(0) == -1) {
-			tst_brkm(TBROK, cleanup, "seteuid() failed to "
-				 "change euid to %d errno = %d : %s",
-				 0, TEST_ERRNO, strerror(TEST_ERRNO));
-		}
+		SAFE_SETEUID(cleanup, 0);
 
 		rl.rlim_max = -1;
 		rl.rlim_cur = -1;
@@ -287,11 +284,7 @@ void cleanup_test(int i)
 		return;
 
 	case 1:
-		if (seteuid(0) == -1) {
-			tst_brkm(TBROK, cleanup, "seteuid() failed to "
-				 "change euid to %d errno = %d : %s",
-				 0, TEST_ERRNO, strerror(TEST_ERRNO));
-		}
+		SAFE_SETEUID(cleanup, 0);
 		return;
 
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 440e11621..773e9c569 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -59,6 +59,7 @@
 #include <errno.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "move_pages_support.h"
 
 #define TEST_PAGES 2
@@ -210,10 +211,7 @@ void setup(void)
 		tst_brkm(TBROK, NULL, "'nobody' user not present");
 	}
 
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK, NULL, "setting uid to %d failed",
-			 ltpuser->pw_uid);
-	}
+	SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -c option.
diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
index 648ab785d..f97905473 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall02.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
@@ -70,6 +70,7 @@
 #include <pwd.h>
 #include <sys/mman.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -126,10 +127,7 @@ void setup(void)
 		tst_brkm(TBROK, NULL, "\"nobody\"user not present");
 	}
 
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK, NULL, "seteuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
-	}
+	SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/readlink/readlink01.c b/testcases/kernel/syscalls/readlink/readlink01.c
index 068227551..3999a3a48 100644
--- a/testcases/kernel/syscalls/readlink/readlink01.c
+++ b/testcases/kernel/syscalls/readlink/readlink01.c
@@ -72,6 +72,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TESTFILE	"testfile"
 #define SYMFILE		"slink_file"
@@ -158,9 +159,7 @@ void setup(void)
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_brkm(TBROK, cleanup, "getpwname(nobody_uid) failed ");
 	}
-	if (seteuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup, "seteuid to nobody failed");
-	}
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index 62cc9e492..13175145d 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -39,6 +39,7 @@
 #include <errno.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "readlink04";
 int TST_TOTAL = 1;
@@ -150,14 +151,12 @@ static void setup(void)
 	if ((pwent = getpwnam("nobody")) == NULL)
 		tst_brkm(TBROK, cleanup, "getpwname() failed for nobody");
 
-	if (seteuid(pwent->pw_uid) == -1)
-		tst_brkm(TBROK, cleanup, "seteuid() failed for nobody");
+	SAFE_SETEUID(cleanup, pwent->pw_uid);
 }
 
 static void cleanup(void)
 {
-	if (seteuid(0) == -1)
-		tst_brkm(TBROK, NULL, "failed to set process id to root");
+	SAFE_SETEUID(NULL, 0);
 
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
index ba0e89428..36952d9cb 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler02.c
@@ -88,9 +88,7 @@ int main(int ac, char **av)
 		if (pid == 0) {	/* child */
 			param.sched_priority = 1;
 
-			if (seteuid(nobody_uid) == -1) {
-				tst_brkm(TBROK, cleanup, "seteuid() failed");
-			}
+			SAFE_SETEUID(cleanup, nobody_uid);
 
 			TEST(sched_setscheduler(pid, SCHED_FIFO, &param));
 
@@ -116,9 +114,7 @@ int main(int ac, char **av)
 			}
 		}
 
-		if (seteuid(0) == -1) {
-			tst_brkm(TBROK, cleanup, "seteuid(0) failed");
-		}
+		SAFE_SETEUID(cleanup, 0);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
index 5d8a49117..864899205 100644
--- a/testcases/kernel/syscalls/setns/setns01.c
+++ b/testcases/kernel/syscalls/setns/setns01.c
@@ -141,8 +141,7 @@ static void setup3(struct testcase_t *t, int i)
 
 static void setup4(struct testcase_t *t, int i)
 {
-	if (seteuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
+	SAFE_SETEUID(NULL, ltpuser->pw_uid);
 
 	t->fd = ns_fds[i];
 	t->ns_type = ns_types[i];
@@ -150,8 +149,7 @@ static void setup4(struct testcase_t *t, int i)
 
 static void cleanup4(struct testcase_t *t)
 {
-	if (seteuid(0) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "seteuid restore failed");
+	SAFE_SETEUID(NULL, 0);
 }
 
 static void test_setns(struct testcase_t *t)
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 2a4852288..a51719e80 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -30,6 +30,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setregid03);
@@ -104,8 +105,7 @@ int main(int ac, char **av)
 		if (SETREGID(NULL, sys.gr_gid, bin.gr_gid) == -1)
 			tst_brkm(TBROK, NULL, "Initial setregid failed");
 
-		if (seteuid(nobody.pw_uid) == -1)
-			tst_brkm(TBROK, NULL, "Initial seteuid failed");
+		SAFE_SETEUID(NULL, nobody.pw_uid);
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, NULL, "fork failed");
diff --git a/testcases/kernel/syscalls/sysctl/sysctl03.c b/testcases/kernel/syscalls/sysctl/sysctl03.c
index 68e4f86c2..0c8e691d8 100644
--- a/testcases/kernel/syscalls/sysctl/sysctl03.c
+++ b/testcases/kernel/syscalls/sysctl/sysctl03.c
@@ -61,6 +61,7 @@
  *	Test must be run as root.
  */
 #include "test.h"
+#include "safe_macros.h"
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <stdio.h>
@@ -146,10 +147,7 @@ int main(int ac, char **av)
 		}
 
 		/* set process ID to "ltpuser1" */
-		if (seteuid(ltpuser->pw_uid) == -1) {
-			tst_brkm(TBROK, cleanup,
-				 "seteuid() failed, errno %d", errno);
-		}
+		SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
 		if ((pid = FORK_OR_VFORK()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() failed");
@@ -182,9 +180,7 @@ int main(int ac, char **av)
 		}
 
 		/* set process ID back to root */
-		if (seteuid(0) == -1) {
-			tst_brkm(TBROK, cleanup, "seteuid() failed");
-		}
+		SAFE_SETEUID(cleanup, 0);
 	}
 	cleanup();
 	tst_exit();
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index 8d1f2c837..b9540ef47 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -71,6 +71,7 @@
 #include <linux/unistd.h>
 #include <sys/syscall.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define UNEXP_RET_VAL	-1
 
@@ -176,10 +177,7 @@ int setup1(void)
 void cleanup1(void)
 {
 	/* Change effective user id to root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "seteuid failed to set the effective"
-			 " uid to root");
-	}
+	SAFE_SETEUID(NULL, 0);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/syslog/syslog12.c b/testcases/kernel/syscalls/syslog/syslog12.c
index 883c3eb37..ac28d43c9 100644
--- a/testcases/kernel/syscalls/syslog/syslog12.c
+++ b/testcases/kernel/syscalls/syslog/syslog12.c
@@ -81,6 +81,7 @@
 #include <linux/unistd.h>
 #include <sys/syscall.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #define EXP_RET_VAL	-1
 
@@ -197,10 +198,7 @@ int setup1(void)
 void cleanup1(void)
 {
 	/* Change effective user id to root */
-	if (seteuid(0) == -1) {
-		tst_brkm(TBROK, NULL, "seteuid failed to set the effective"
-			 " uid to root");
-	}
+	SAFE_SETEUID(NULL, 0);
 }
 
 /*
diff --git a/testcases/kernel/timers/clock_settime/clock_settime03.c b/testcases/kernel/timers/clock_settime/clock_settime03.c
index b4c10de14..38b41d025 100644
--- a/testcases/kernel/timers/clock_settime/clock_settime03.c
+++ b/testcases/kernel/timers/clock_settime/clock_settime03.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "common_timers.h"
 
 static void setup(void);
@@ -80,11 +81,7 @@ int main(int ac, char **av)
 
 			/* Change the UID back to root */
 			if (i == TST_TOTAL - 1) {
-				if (seteuid(0) == -1) {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "Failed to set the effective "
-						 "uid to root");
-				}
+				SAFE_SETEUID(cleanup, 0);
 			}
 
 			/* check return code */
-- 
2.13.5

